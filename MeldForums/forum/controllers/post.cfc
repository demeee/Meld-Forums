<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
		
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doUpdateEditPost( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetEditPost( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="new" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doCreateNewPost( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetNewPost( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doGetEditPost" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var userService				= getBeanFactory().getBean("userService") />
		<cfset var mmUtility				= getBeanFactory().getBean("mmUtility")>

		<cfset var pageManager				= getBeanFactory().getBean("PageManager")>
		<!---<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>--->
		<cfset var userBean					= rc.MFBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var parentPostBean			= "" />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />
		<cfset var configurationBean		= "" />

		<cfset var postID					= $.event().getValue("postID") />
		<cfset var attachmentID				= "" />
		<cfset var aIntercept				= rc.MFBean.getIntercept() />

		<cfif not ArrayLen(aIntercept) gte 3>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		<cfelseif not mmUtility.isUUID( aIntercept[3] )>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1054" addtoken="false">
			<cfreturn>
		</cfif>
	
		<cfset sArgs.postID					= aIntercept[3] />

		<cfset postBean						= postService.getPost( argumentCollection=sArgs ) />
		
		<cfset sArgs.ThreadID				= postBean.getThreadID() />
		<cfset threadBean					= threadService.getThread( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserEditPost( postBean,threadBean )>
			<cfset getErrorManager().addErrorByCode(2001)>
		</cfif>

		<cfif not postBean.beanExists()>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		</cfif>

		<!--- threaded --->
		<cfif len( postBean.getParentID() )>
			<cfset sArgs.postID				= postBean.getParentID() />
			<cfset parentPostBean			= postService.getPost( argumentCollection=sArgs ) />
		</cfif>

		<cfset rc.postBean			= postBean />
		<cfset rc.threadBean		= threadBean />
		<cfset rc.parentPostBean	= parentPostBean />
		<cfset rc.configurationBean	= rc.MFBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="doUpdateEditPost" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var threadService		= getBeanFactory().getBean("threadService") />
		<cfset var postService			= getBeanFactory().getBean("postService") />
		<cfset var userService			= getBeanFactory().getBean("userService") />
		<cfset var mmUtility			= getBeanFactory().getBean("mmUtility")>
		<cfset var mmFileUpload			= getBeanFactory().getBean("mmFileUpload") />

		<!---<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>--->
		<cfset var userBean					= rc.MFBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />

		<cfset var postID					= $.event().getValue("postID") />
		<cfset var attachmentID				= "" />
		<cfset var oldAttachmentID			= "" />

		<cfset postBean						= postService.getPost( postID ) />
		
		<cfif not postBean.beanExists()>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset threadBean					= threadService.getThread( postBean.getThreadID() ) />

		<!--- content check --->
		<cfif not len( form.message )>
			<cfset getErrorManager().addErrorByCode(1055)>
			<cfreturn>
		</cfif>

		<!--- moderator fields --->
		<cfif rc.MFBean.UserHasModeratePermissions()>
			<cfset sArgs.IsActive			= $.event().getValue("doSetActive") eq 1 />
			<cfset sArgs.IsDisabled			= $.event().getValue("doSetDisabled") eq 1 />
			<cfset sArgs.IsModerated		= $.event().getValue("doSetModerated") eq 1 />
			<cfset sArgs.doBlockAttachment	= $.event().getValue("doBlockAttachment") eq 1 />

			<cfif sArgs.IsModerated>
				<cfset sArgs.dateModerated	= CreateODBCDateTime( now() ) />
			</cfif>

			<cfset sArgs.adminID			= $.currentUser().getUserID()>
		</cfif>

		<!--- new post --->
		<cfset sArgs.message		= mmUtility.stripHTML( form.message ) />
		<cfset postBean.updateMemento( sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserEditPost( postBean,threadBean )>
			<cfset getErrorManager().addErrorByCode(2001)>
		</cfif>

		<cftry>
			<cfif $.event().getValue("doDeleteAttachment") eq 1 and len( postBean.getAttachmentID() )>
				<cfset mmFileUpload.deleteFileByFileID( postBean.getAttachmentID() ) />
				<cfset postBean.setAttachmentID('')>
			</cfif>
				<cfcatch>
				<cfif len( attachmentID )>
					<cfset mmFileUpload.deleteFileByFileID( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError(cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
		</cftry>

		<cftry>
			<cfif not getErrorManager().hasErrors()>
				<cfif isDefined("form.NEWATTACHMENT") and len(form.NEWATTACHMENT)>
					<cfset oldAttachmentID			= postBean.getAttachmentID() />
					<cfset sArgs.rc					= arguments.rc />
					<cfset sArgs.postID				= postBean.getPostID() />
					<cfset sArgs.configurationBean	= rc.MFBean.getConfigurationBean() />
					<cfset attachmentID				= doFileAttachment( argumentCollection=sArgs )>
					<cfset postBean.setAttachmentID( attachmentID ) />
				</cfif>

				<cfset postBean.save() />

				<cfif len( oldAttachmentID )>
					<cfset mmFileUpload.deleteFileByFileID( oldAttachmentID ) />
				</cfif>
			</cfif>
			<cfcatch type="custom">
				<cfif len( attachmentID )>
					<cfset mmFileUpload.deleteFileByFileID( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError(cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
			<cfcatch>
				<cfif len( attachmentID )>
					<cfset mmFileUpload.deleteFileByFileID( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError(cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
				<cfdump var="#cfcatch#"><cfabort>
				<cfreturn>
			</cfcatch>
		</cftry>
		
		<cfif not getErrorManager().hasErrors()>
			<cflocation url="#rc.MFBean.getThreadLink( threadBean )#" addtoken="false">
		</cfif>
	</cffunction>

	<cffunction name="doGetNewPost" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var threadService		= getBeanFactory().getBean("threadService") />
		<cfset var postService			= getBeanFactory().getBean("postService") />
		<cfset var mmUtility			= getBeanFactory().getBean("mmUtility")>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var parentPostBean			= "" />
		<cfset var threadBean				= "" />

		<cfset var threadID					= "" />
		<cfset var parentID					= "" />
		<cfset var doQuote					= false />

		<cfset var txtQuote					= "" />

		<cfset var aIntercept				= rc.MFBean.getIntercept() />
		<cfset var event					= rc.mmEvents.createEvent( rc.$ ) />

		<cfif not ArrayLen(aIntercept) gte 3>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		<cfelseif not mmUtility.isUUID( aIntercept[3] )>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1054" addtoken="false">
			<cfreturn>
		</cfif>
	
		<cfset sArgs.ThreadID				= aIntercept[3] />

		<cfif ArrayLen(aIntercept) gte 4>
			<cfset parentID					= aIntercept[4] />
		</cfif>

		<cfif ArrayLen(aIntercept) gte 5>
			<cfset doQuote					= aIntercept[5] eq true />
		</cfif>
		
		<cfset threadBean					= threadService.getThread( argumentCollection=sArgs ) />
		<cfset postBean						= postService.createPost( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.mfBean.CanUserCreatePost( threadBean )>
			<cflocation url="#rc.mfBean.getForumWebRoot()#/?ecode=2001" addtoken="false">
			<cfreturn>
		</cfif>
		
		<!--- threaded --->
		<cfif len( parentID )>
			<cfset sArgs.postID				= parentID />
			<cfset parentPostBean			= postService.getPost( argumentCollection=sArgs ) />
			<cfset postBean.setParentID( parentID ) />

			<!--- quote --->
			<cfif doQuote and parentPostBean.beanExists()>
				<cfset txtQuote = "[quote]" & parentPostBean.getMessage() & "[/quote]" />
				<cfset postBean.setMessage( txtQuote ) />		
	
				<cfset rc.quote 			= parentPostBean.getMessage() />
			</cfif>

		</cfif>

		<cfset event.setValue('threadBean',threadBean ) />
		<cfset event.setValue('postBean',postBean ) />
		<cfset event.setValue('parentPostBean',parentPostBean ) />
		<cfset event.setValue('configurationBean',rc.mfBean.getConfigurationBean() ) />
		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsGetNewPost",event ) />
		
		<cfset rc.threadBean		= threadBean />
		<cfset rc.postBean			= postBean />
		<cfset rc.parentPostBean	= parentPostBean />
		<cfset rc.configurationBean	= rc.mfBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="doCreateNewPost" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var forumService			= getBeanFactory().getBean("forumService") />
		<cfset var threadService		= getBeanFactory().getBean("threadService") />
		<cfset var postService			= getBeanFactory().getBean("postService") />
		<cfset var userService			= getBeanFactory().getBean("userService") />
		<cfset var mmUtility			= getBeanFactory().getBean("mmUtility")>
		<cfset var mmFileUpload			= getBeanFactory().getBean("mmFileUpload") />

		<!---<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>--->
		<cfset var userBean					= rc.MFBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var threadBean				= "" />
		<cfset var configurationBean		= "" />

		<cfset var threadID					= $.event().getValue("threadID") />
		<cfset var attachmentID				= "" />
		<cfset var postPosition				= 0 />

		<cfset var event					= rc.mmEvents.createEvent( rc.$ ) />

		<cfset var event					= rc.mmEvents.createEvent( rc.$ ) />

		<cfset sArgs.threadID			= threadID />
		<cfset threadBean				= threadService.getThread( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserCreatePost( threadBean )>
			<cfset getErrorManager().addErrorByCode(2016)>
			<cfreturn>
		</cfif>

		<!--- content check --->
		<cfif not len( form.message )>
			<cfset getErrorManager().addErrorByCode(1055)>
			<cfreturn>
		</cfif>

		<!--- new post --->
		<cfset sArgs.message		= mmUtility.stripHTML( form.message ) />
		<cfset sArgs.threadID		= threadBean.getThreadID() />
		<cfset sArgs.siteID			= $.event().getValue("siteID") />
		<cfset sArgs.userID			= $.currentUser().getUserID() />
		<cfset sArgs.parentID		= $.event().getValue("parentID") />
		<cfset sArgs.isActive		= 1 />

		<cfset postBean				= postService.createPost( argumentCollection=sArgs ) />

		<cfset event.setValue('message',form.message ) />
		<cfset event.setValue('postBean',postBean ) />
		<cfset event.setValue('userID',sArgs.userID ) />
		<cfset event.setValue('threadBean',threadBean ) />
		<cfset event.setValue('parentID',sArgs.parentID ) />

		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsBeforeCreateNewPost",event ) />

		<cftransaction>
			<cfset sArgs = StructNew() />
			<cfset sArgs.threadID		= threadBean.getThreadID() />
			<cfset sArgs.forumID		= threadBean.getForumID() />
			<cfset sArgs.postID			= postBean.getPostID() />
			<cfset sArgs.postDate		= CreateODBCDateTime( now() ) />
			<cfset sArgs.doIncrement	= true />
			<cfset sArgs.siteID			= $.event().getValue("siteID") />
			<cfset sArgs.userID			= $.currentUser().getUserID() />

			<!--- this ratchets up the value, so do in transaction --->
			<cfset postPosition = threadService.getPostCount( argumentCollection=sArgs ) />
			<cfset postBean.setPostPosition( postPosition ) />
							
			<cfset postService.savePost( postBean )>
			<cfset forumService.updateThreadCounter( argumentCollection=sArgs )>
			<cfset forumService.setLastPostID( argumentCollection=sArgs )>
			<cfset userService.userAddedPost( argumentCollection=sArgs ) />
		</cftransaction>

		<cfif not getErrorManager().hasErrors()>
			<cfif isDefined("form.NEWATTACHMENT") and len(form.NEWATTACHMENT)>
				<cfset sArgs.rc					= arguments.rc />
				<cfset sArgs.postID				= postBean.getPostID() />
				<cfset sArgs.configurationBean	= rc.MFBean.getConfigurationBean() />
				<cfset attachmentID				= doFileAttachment( argumentCollection=sArgs )>
				<cfset postBean.setAttachmentID( attachmentID ) />
			</cfif>
			<cfif len( attachmentID )>
				<cfset postService.updatePost( postBean )>
			</cfif>
		</cfif>

		<!--- process notifications --->
		<cfif not getErrorManager().hasErrors()>
			<cfset event.setValue('subscriptionsProcessed',0 ) />
			<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsAfterCreateNewPost",event ) />

			<cfset rc.postBean			= postBean />
			<cfset rc.threadBean		= threadBean />
			<cfset rc.userBean			= userBean />
			<cfset rc.forumWebRoot		= rc.MFBean.getForumWebRoot() />
			<cfset rc.siteID			= $.event().getValue("siteID") />
			
			<cfset rc.subscriptionText	= "" />
			
			<!---
			<cftry>
				<cfsavecontent variable="rc.subscriptionText">
				<cfoutput><cfinclude template="/#rc.pluginConfig.getPackage()#/themes/#rc.rc.MFBean.getValue("themeBean").getDirectory()#/assets/templates/subscriptionText.cfm" /></cfoutput>
				</cfsavecontent>
				<cfcatch>
					<cfdump var="#cfcatch#"><cfabort>
				</cfcatch>
			</cftry>
				
				<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsBeforeProcessDescriptions",event ) />
				<cfif not event.getValue('subscriptionsProcessed' )>
					<cfset subscribeService.processSubscriptions( argumentCollection=rc )>
					<cfset event.setValue('subscriptionsProcessed',1 ) />
				</cfif>
			--->
		</cfif>
		
		<cfif not getErrorManager().hasErrors()>
			<cflocation url="#rc.MFBean.getThreadLink( rc.threadBean )#/?pp=#postBean.getPostPosition()###p#postBean.getPostPosition()#" addtoken="false">
		</cfif>
	</cffunction>

	<cffunction name="doFileAttachment" returntype="string" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">
		<cfargument name="postID" type="uuid" required="true">
		<cfargument name="configurationBean" type="any" required="true">

		<cfset var mmFileUpload			= getBeanFactory().getBean("mmFileUpload") />
		<cfset var sArgs				= StructNew() />
		<cfset var fileID				= "" />
		<cfset var fileUploadBean		= "" />

		<cfset sArgs.contentID			= arguments.postID>
		<cfset sArgs.moduleID			= rc.pluginConfig.getModuleID()>
		<cfset sArgs.siteID				= $.event().getValue("siteID") />

		<cfset sArgs.FileSizeLimit		= configurationBean.getFilesizeLimit() />
		<cfset sArgs.AllowedExtensions	= configurationBean.getAllowAttachmentExtensions() />
		<cfset sArgs.DoClearPrevious	= true />

		<cfset fileUploadBean			= mmFileUpload.createFileUploadBean( argumentCollection=sArgs ) />
		<cfset fileID 					= mmFileUpload.uploadFile( "NEWATTACHMENT",fileUploadBean )>

		<cfreturn fileID />
	</cffunction>
</cfcomponent>