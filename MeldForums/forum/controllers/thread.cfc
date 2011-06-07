<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="new" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doCreateNewThread( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetNewThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doUpdateEditThread( argumentCollection=arguments ) />
		<cfelseif isDefined("form.btAction") and btAction eq rc.mmRBF.key('delete') and form.btActionConfirm eq "confirm">
			<cfset doDeleteEditThread( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetEditThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doGetThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var pageManager				= getBeanFactory().getBean("PageManager")>
		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>

		<!--- event() value is set via intercepts and validateIntercept() --->
		<cfset var threadID					= $.event().getValue("threadID") />

		<cfset var settingsBean				= rc.MFBean.getValue("settingsBean") />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />
		<cfset var pageBean					= pageManager.getPageBean( $,rc.MFBean.getValue("settingsBean").getPostsPerPage() )>
		<cfset var subscribed				= false>

		<cfset var iiX						= "" />
		<cfset var sArgs					= StructNew() />
		<cfset var pluginEvent	 			= createEvent(rc) />

		<cfset var isSubscribed				= false>
		<cfset var aIntercept				= rc.MFBean.getIntercept() />

		<!--- permissions --->
		<cfif not rc.MFBean.userHasReadPermissions()>
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=2013" addtoken="false">
			<cfreturn>
		</cfif>

		<cfif len( rc.MFBean.getIdent() )>
			<cfset idx = rereplace( rc.MFBean.getIdent(),"[^\d]","","all" ) />
		</cfif>

		<cfif len( rc.MFBean.getIdent() ) and isNumeric(idx) >
			<cfset pluginEvent.setValue("ident",rc.MFBean.getIdent() ) />
			<cfset pluginEvent.setValue("idx",idx ) />
			<cfset pluginEvent.setValue("doPosts",true ) />
			<cfset pluginEvent.setValue("pageBean",pageBean ) />
			<cfset announceEvent(rc,"onMeldForumsGetThread",pluginEvent)>

			<cfif pluginEvent.valueExists('threadBean') and not isSimpleValue( pluginEvent.getValue('threadBean') )>
					<cfset threadBean	= pluginEvent.getValue('threadBean') />
			<cfelse>
				<cfset sArgs.idx = idx />
				<cfif StructKeyExists(rc.params,"threadID") and len( rc.params.threadID )>
					<cfset sArgs.threadID = threadID />
				</cfif>
				<cfset sArgs.pageBean	= pageBean />
				<cfset sArgs.doPosts	= true />
				
				<cfset threadBean		= threadService.getThreadWithPosts( argumentCollection=sArgs )>
			</cfif>
		<cfelse>
			<!--- get the threadBean --->
			<cfset sArgs.threadID		= threadID />
			<cfset sArgs.pageBean		= pageBean />
			<cfset sArgs.doPosts		= true />
			
			<cfset threadBean			= threadService.getThreadWithPosts( argumentCollection=sArgs )>
		</cfif>

		<cfif threadBean.beanExists()>
			<cfset forumBean		= forumService.getForum( threadBean.getForumID() ) />
		<cfelse>
			<cfoutput>nope!</cfoutput><cfabort>
			<!--- 1013: thread not found --->
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=1013" addtoken="false">
			<cfreturn>
		</cfif>
		<!--- ensure the forum exists --->
		<cfif not forumBean.beanExists()>
			<!--- 1012: forum not found --->
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=1012" addtoken="false">
			<cfreturn>
		</cfif>

		<!--- add the pageNav to the event scope --->
		<cfset $.event().setValue("pageBean",pageBean) />

		<!---<cfset isSubscribed = subscribeService.getIsSubscribedToThread( $.currentUser().getUserID(),threadBean.getThreadID() ) />--->

		<cfset rc.ThreadBean		= threadBean />
		<cfset rc.ForumBean			= forumBean />
		<cfset rc.pageBean			= pageBean />
		<cfset rc.isSubscribed		= isSubscribed />
	</cffunction>

	<cffunction name="doGetNewThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var mmUtility				= getBeanFactory().getBean("mmUtility")>

		<cfset var sArgs					= StructNew() />

		<cfset var threadBean				= "" />
		<cfset var forumID					= "" />
		<cfset var aIntercept				= rc.MFBean.getIntercept() />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserCreateThread()>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=2001" addtoken="false">
			<cfreturn>
		</cfif>

		<cfif ArrayLen(aIntercept) lt 3>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset forumID = aIntercept[3] />

		<cfset sArgs.forumID				= forumID />
		<cfset threadBean					= threadService.createThread( argumentCollection=sArgs ) />

		<cfset rc.ThreadBean		= threadBean />
		<cfset rc.configurationBean	= rc.MFBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="doCreateNewThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var forumService			= getBeanFactory().getBean("forumService") />
		<cfset var threadService		= getBeanFactory().getBean("threadService") />
		<cfset var postService			= getBeanFactory().getBean("postService") />
		<cfset var userService			= getBeanFactory().getBean("userService") />
		<cfset var mmUtility			= getBeanFactory().getBean("mmUtility")>
		<cfset var mmFileUpload			= getBeanFactory().getBean("mmFileUpload") />

		<cfset var subscribeService		= getBeanFactory().getBean("SubscribeService")>
		<cfset var userBean				= rc.MFBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs				= StructNew() />

		<cfset var postBean				= "" />
		<cfset var forumBean			= "" />
		<cfset var threadBean			= "" />
		<cfset var configurationBean	= "" />

		<cfset var forumID				= $.event().getValue("forumID") />
		<cfset var attachmentID			= "" />

		<cfset sArgs.forumID			= forumID />

		<cfset forumBean				= forumService.getForum( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserCreateThread()>
			<cfset getErrorManager().addErrorByCode(2016)>
			<cfreturn>
		</cfif>

		<!--- forum exists --->
		<cfif not forumBean.beanExists()>
			<cfset getErrorManager().addErrorByCode(1012)>
			<cfreturn>
		</cfif>

		<!--- content check --->
		<cfif not len( form.message )>
			<cfset getErrorManager().addErrorByCode(1055)>
			<cfreturn>
		</cfif>

		<!--- new thread --->
		<cfset sArgs.siteID			= $.event().getValue("siteID") />
		<cfset sArgs.title			= form.title />
		<cfset sArgs.userID			= $.currentUser().getUserID() />
		<cfset sArgs.isActive		= 1 />

		<!--- moderator fields --->
		<cfif rc.MFBean.UserHasModeratePermissions()>
			<cfset sArgs.IsAnnouncement		= $.event().getValue("doSetAnnouncement") eq 1>
			<cfset sArgs.IsClosed			= $.event().getValue("doSetClosed") eq 1>
			<cfset sArgs.threadType			= $.event().getValue("threadType")>
			<cfset sArgs.adminID			= $.currentUser().getUserID()>
		</cfif>

		<cfset threadBean			= threadService.createThread( argumentCollection=sArgs ) />

		<!--- new post --->
		<cfset sArgs.message		= form.message />
		<cfset sArgs.threadID		= threadBean.getThreadID() />
		<cfset postBean				= postService.createPost( argumentCollection=sArgs ) />

		<cftry>
			<cftransaction>
				<cfset postService.savePost( postBean )>
				<cfset threadService.saveThread( threadBean,postBean )>
				<cfset forumService.updateThreadCounter( threadBean.getForumID() )>
				<cfset forumService.setLastPostID( threadBean.getForumID(),postBean.getPostID() )>

				<cfset userService.userAddedThread( threadBean.getUserID(),threadBean.getThreadID(),$.event().getValue("siteID") ) />
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

			<cfcatch type="custom">
				<cfif len( attachmentID )>
					<cfset mmFileUpload.deleteFile( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError(cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
			<cfcatch>
				<cfif len( attachmentID )>
					<cfset mmFileUpload.deleteFile( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError(cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
		</cftry>
	
<!---
		<!--- process notifications --->
		<cfif not getErrorManager().hasErrors( $.event() )>
			<cfset rc.postBean			= postBean />
			<cfset rc.threadBean		= threadBean />
			<cfset rc.userBean			= userBean />
			<cfset rc.forumWebRoot		= rc.MFBean.getForumWebRoot() />
			<cfset rc.siteID			= $.event().getValue("siteID") />
			
			<cfset rc.subscriptionText	= "" />
			
			<cftry>
				<cfsavecontent variable="rc.subscriptionText">
				<cfoutput><cfinclude template="/#rc.pluginConfig.getPackage()#/themes/#rc.MFBean.getValue("themeBean").getDirectory()#/assets/templates/subscriptionText.cfm" /></cfoutput>
				</cfsavecontent>
				<cfcatch>
					<cfdump var="#cfcatch#"><cfabort>
				</cfcatch>
			</cftry>
				
			<!---<cfset subscribeService.processSubscriptions( argumentCollection=rc )>--->
		</cfif>
--->		

		<cfif not getErrorManager().hasErrors()>
			<cfset threadBean		= threadService.getThread( threadID=threadBean.getThreadID() )>
			<cflocation url="#rc.MFBean.getThreadLink( threadBean )#/" addtoken="false">
		</cfif>
	</cffunction>

	<cffunction name="doGetEditThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var mmUtility				= getBeanFactory().getBean("mmUtility")>

		<cfset var sArgs					= StructNew() />

		<cfset var threadBean				= "" />
		<cfset var postBean					= "" />
		<cfset var threadID					= "" />
		<cfset var aIntercept				= rc.MFBean.getIntercept() />

		<cfif ArrayLen(aIntercept) lt 3>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset threadID = aIntercept[3] />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserCreateThread()>
			<cflocation url="#rc.MFBean.getThreadLink( threadBean )#/?ecode=2001" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset sArgs.threadID			= threadID />
		<cfset threadBean				= threadService.getThread( argumentCollection=sArgs ) />

		<cfset sArgs.postPostiion		= 0 />
		<cfset postBean					= postService.getBeanByAttributes( argumentCollection=sArgs ) />

		<cfset rc.ThreadBean			= threadBean />
		<cfset rc.PostBean				= postBean />
		<cfset rc.configurationBean		= rc.MFBean.getConfigurationBean() />
	</cffunction>


	<cffunction name="doUpdateEditThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var userService				= getBeanFactory().getBean("userService") />
		<cfset var mmUtility				= getBeanFactory().getBean("mmUtility")>

		<cfset var sArgs					= StructNew() />
		<cfset var threadBean				= "" />
		<cfset var threadID					= $.event().getValue("threadID") />

		<cfset sArgs.threadID				= threadID />
		<cfset threadBean					= threadService.getThread( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.canUserEditThread( threadBean )>
			<cfset getErrorManager().addErrorByCode(2013)>
			<cfreturn>
		</cfif>

		<!--- threadBean exists --->
		<cfif not threadBean.beanExists()>
			<cfset getErrorManager().addErrorByCode(1013)>
			<cfreturn>
		</cfif>

		<cfset sArgs.title			= form.title />

		<!--- moderator fields --->
		<cfif rc.MFBean.UserHasModeratePermissions()>
			<cfset sArgs.IsActive			= $.event().getValue("doSetActive") eq 1>
			<cfset sArgs.IsDisabled			= $.event().getValue("doSetDisabled") eq 1>
			<cfset sArgs.IsAnnouncement		= $.event().getValue("doSetAnnouncement") eq 1>
			<cfset sArgs.IsClosed			= $.event().getValue("doSetClosed") eq 1>
			<cfset sArgs.threadType			= $.event().getValue("threadType")>

			<cfif $.event().getValue("doAddAdminMessage") eq 1>
				<cfset sArgs.adminMessage = message>
			<cfelse>
				<cfset sArgs.adminMessage = "">
			</cfif>

			<cfset sArgs.adminID			= $.currentUser().getUserID()>
		</cfif>

		<cfset threadBean.updateMemento( sArgs ) />

		<cftry>
			<cfset threadService.updateThread( threadBean )>
			<cfcatch type="custom">
				<cfset getErrorManager().addError(cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
			</cfcatch>
			<cfcatch>
				<cfset getErrorManager().addError(cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
			</cfcatch>
		</cftry>

		<cfif not getErrorManager().hasErrors()>
			<cflocation url="#rc.MFBean.getThreadLink( threadBean )#/" addtoken="false">
		</cfif>
	</cffunction>

</cfcomponent>