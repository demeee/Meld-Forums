<cfcomponent extends="controller">

	<!--- 
		we need to establish the current theme for all requests
	 --->
	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />

		<cfset rc.meldForumsBean	= meldForumsBean />
		<cfset rc.settingsBean		= meldForumsBean.getValue("settingsBean") />
		<cfset rc.themeBean			= meldForumsBean.getValue("themeBean") />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />

		<cfset doGetConferences( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="viewprofile" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetProfile( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="viewconference" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetConference( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="viewforum" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetForum( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="viewthread" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="newthread" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doCreateNewThread( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetNewThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="editthread" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doUpdateEditThread( argumentCollection=arguments ) />
		<cfelseif isDefined("form.btAction") and btAction eq rc.mmRBF.key('delete') and form.btActionConfirm eq "confirm">
			<cfset doDeleteEditThread( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetEditThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="editpost" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doUpdateEditPost( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetEditPost( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="newpost" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doCreateNewPost( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetNewPost( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="subscribe" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doUpdateSubscribe( argumentCollection=arguments ) />
	</cffunction>

<!--- --------------------------------------------------------------------------------- --->
<!--- ACTIONS --->
	<cffunction name="doGetProfile" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var profileUserBean		= meldForumsBean.getUserCache().getUser( $.event('profileUserID') )>

		<cfset rc.profileUserBean		= profileUserBean />		
	</cffunction>


	<cffunction name="doGetConferences" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />
		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var forumService			= getBeanFactory().getBean("forumService") />
		<cfset var qConferenceTree		= "" />
		<cfset var aConferences			= ArrayNew(1) />
		<cfset var aForums				= ArrayNew(1) />
		<cfset var aForumSet			= ArrayNew(1) />
		<cfset var iiX					= "" />
		<cfset var sArgs				= StructNew() />

		<cfif StructKeyExists(rc,"params")>
			<!--- get conference --->
			<cfif StructKeyExists(rc.params,"conferenceIDList") and len( rc.params.conferenceIDList )>
				<cfset sArgs.idList = rc.params.conferenceIDList />
				<cfset aConferences	= conferenceService.getConferences( argumentCollection=sArgs ) />
			<!--- get conference --->
			<cfelseif StructKeyExists(rc.params,"conferenceID") and len( rc.params.conferenceID )>
				<cfset aConferences	= conferenceService.getConference( rc.params.conferenceID ) />
			<!--- get all --->
			<cfelse>
				<cfset aConferences	= conferenceService.getConferences() />
			</cfif>
			<!--- get all --->
		<cfelse>
			<cfset aConferences	= conferenceService.getConferences() />
		</cfif>

		<cfset rc.aConferences = aConferences />
	</cffunction>

	<cffunction name="doGetConference" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />
		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var forumService			= getBeanFactory().getBean("forumService") />
		<cfset var qConferenceTree		= "" />
		<cfset var aConferences			= ArrayNew(1) />
		<cfset var aForums				= ArrayNew(1) />
		<cfset var aForumSet			= ArrayNew(1) />
		<cfset var iiX					= "" />
		<cfset var conferenceID			= $.event().getValue("conferenceID") />
		<cfset var sArgs				= StructNew() />

		<cfset sArgs.conferenceID	= conferenceID />

		<!--- permissions --->
		<cfif not meldForumsBean.userHasReadPermissions()>
			<cflocation url="#meldForumsBean.getForumWebRoot()#?ecode=2011" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset aConferences	= conferenceService.getConferences( argumentCollection=sArgs) />

		<cfset rc.aConferences = aConferences />
	</cffunction>

	<cffunction name="doGetForum" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var conferenceService		= getBeanFactory().getBean("ConferenceService") />
		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>
		<cfset var pageManager				= getBeanFactory().getBean("PageManager")>
		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>

		<!--- event() value is set via intercepts and validateIntercept() --->
		<cfset var forumID					= $.event().getValue("forumID") />

		<cfset var forumBean				= "" />
		<cfset var conferenceBean			= "" />
		<cfset var pageBean					= pageManager.getPageBean( $,"pageNav","?",meldForumsBean.getValue("settingsBean").getThreadsPerPage() )>

		<cfset var sArgs					= StructNew() />
		<cfset var isSubscribed				= false />

		<!--- permissions --->
		<cfif not meldForumsBean.userHasReadPermissions()>
			<cflocation url="#meldForumsBean.getForumWebRoot()#?ecode=2012" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset sArgs.forumID	= forumID />
		<cfset sArgs.pageBean	= pageBean />
		<cfset sArgs.doThreads	= true />
		 
		<cfset forumBean		= forumService.getForumWithThreads( argumentCollection=sArgs )>

		<cfif forumBean.beanExists()>
			<cfset conferenceBean	= conferenceService.getConference( forumBean.getConferenceID() ) />
		<cfelse>
			<!--- 1012: forum not found --->
			<cflocation url="#meldForumsBean.getForumWebRoot()#?ecode=1012" addtoken="false">
			<cfreturn>
		</cfif>

		<!--- add the pageNav to the event scope --->
		<cfset $.event().setValue("pageBean",pageBean) />

		<cfset isSubscribed = subscribeService.getIsSubscribedToForum( $.currentUser().getUserID(),forumBean.getForumID() ) />

		<cfset rc.ForumBean			= forumBean />
		<cfset rc.ConferenceBean	= conferenceBean />
		<cfset rc.pageBean			= pageBean />
		<cfset rc.isSubscribed		= isSubscribed />
	</cffunction>

	<cffunction name="doGetThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>
		<cfset var pageManager				= getBeanFactory().getBean("PageManager")>
		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>

		<!--- event() value is set via intercepts and validateIntercept() --->
		<cfset var threadID					= $.event().getValue("threadID") />

		<cfset var settingsBean				= meldForumsBean.getValue("settingsBean") />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />
		<cfset var pageBean					= pageManager.getPageBean( $,"pageNav","?",meldForumsBean.getValue("settingsBean").getPostsPerPage() )>
		<cfset var subscribed				= false>

		<cfset var pos						= 0 />
		<cfset var iiX						= "" />
		<cfset var sArgs					= StructNew() />

		<cfset var isSubscribed				= false>

		<!--- permissions --->
		<cfif not meldForumsBean.userHasReadPermissions()>
			<cflocation url="#meldForumsBean.getForumWebRoot()#?ecode=2013" addtoken="false">
			<cfreturn>
		</cfif>

		<!--- get the page position --->
		<cfif isNumeric( $.event().getValue("pp") )>
			<cfset pos = int($.event().getValue("pp")/settingsBean.getPostsPerPage())*settingsBean.getPostsPerPage()>
			<cfset pageBean.setPos( pos )>
		</cfif>

		<!--- get the threadBean --->
		<cfset sArgs.threadID	= threadID />
		<cfset sArgs.pageBean	= pageBean />
		<cfset sArgs.doPosts	= true />
		<cfset threadBean		= threadService.getThreadWithPosts( argumentCollection=sArgs )>

		<cfif threadBean.beanExists()>
			<cfset forumBean		= forumService.getForum( threadBean.getForumID() ) />
		<cfelse>
			<!--- 1013: thread not found --->
			<cflocation url="#meldForumsBean.getForumWebRoot()#?ecode=1013" addtoken="false">
			<cfreturn>
		</cfif>
		<!--- ensure the forum exists --->
		<cfif not forumBean.beanExists()>
			<!--- 1012: forum not found --->
			<cflocation url="#meldForumsBean.getForumWebRoot()#?ecode=1012" addtoken="false">
			<cfreturn>
		</cfif>

		<!--- add the pageNav to the event scope --->
		<cfset $.event().setValue("pageBean",pageBean) />

		<cfset isSubscribed = subscribeService.getIsSubscribedToThread( $.currentUser().getUserID(),threadBean.getThreadID() ) />

		<cfset rc.ThreadBean		= threadBean />
		<cfset rc.ForumBean			= forumBean />
		<cfset rc.pageBean			= pageBean />
		<cfset rc.isSubscribed		= isSubscribed />
	</cffunction>

	<cffunction name="doGetEditThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>

		<cfset var sArgs					= StructNew() />

		<cfset var threadBean				= "" />
		<cfset var postBean					= "" />
		<cfset var threadID					= $.event().getValue("threadID") />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not meldForumsBean.CanUserCreateThread()>
			<cflocation url="#meldForumsBean.getForumWebRoot()#viewthread/#threadID#/?ecode=2001" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset sArgs.threadID			= threadID />
		<cfset threadBean				= threadService.getThread( argumentCollection=sArgs ) />

		<cfset sArgs.postPostiion		= 0 />
		<cfset postBean					= postService.getBeanByAttributes( argumentCollection=sArgs ) />

		<cfset rc.ThreadBean			= threadBean />
		<cfset rc.PostBean				= postBean />
		<cfset rc.configurationBean		= meldForumsBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="doUpdateEditThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var userDataService			= getBeanFactory().getBean("userDataService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>

		<cfset var sArgs					= StructNew() />
		<cfset var threadBean				= "" />
		<cfset var threadID					= $.event().getValue("threadID") />

		<cfset sArgs.threadID				= threadID />
		<cfset threadBean					= threadService.getThread( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not meldForumsBean.canUserEditThread( threadBean )>
			<cfset getErrorManager().addErrorByCode($.event(),2013)>
			<cfreturn>
		</cfif>

		<!--- threadBean exists --->
		<cfif not threadBean.beanExists()>
			<cfset getErrorManager().addErrorByCode($.event(),1013)>
			<cfreturn>
		</cfif>

		<cfset sArgs.title			= form.title />

		<!--- moderator fields --->
		<cfif meldForumsBean.UserHasModeratePermissions()>
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
				<cfset getErrorManager().addError($.event(),cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
			</cfcatch>
			<cfcatch>
				<cfset getErrorManager().addError($.event(),cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
			</cfcatch>
		</cftry>

		<cfif not getErrorManager().hasErrors( $.event() )>
			<cflocation url="#meldForumsBean.getForumWebRoot()#viewthread/#threadBean.getThreadID()#/" addtoken="false">
		</cfif>
	</cffunction>

	<cffunction name="doGetNewThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>

		<cfset var sArgs					= StructNew() />

		<cfset var threadBean				= "" />
		<cfset var forumID					= $.event().getValue("forumID") />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not meldForumsBean.CanUserCreateThread()>
			<cflocation url="#meldForumsBean.getForumWebRoot()#/?ecode=2001" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset sArgs.forumID				= forumID />
		<cfset threadBean					= threadService.createThread( argumentCollection=sArgs ) />

		<cfset rc.ThreadBean		= threadBean />
		<cfset rc.configurationBean	= meldForumsBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="doCreateNewThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var userDataService			= getBeanFactory().getBean("userDataService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>
		<cfset var fileUploadManager		= getBeanFactory().getBean("FileUploadManager") />

		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>
		<cfset var userBean					= meldForumsBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />
		<cfset var configurationBean		= "" />

		<cfset var forumID					= $.event().getValue("forumID") />
		<cfset var attachmentID				= "" />

		<cfset sArgs.forumID				= forumID />

		<cfset forumBean					= forumService.getForum( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not meldForumsBean.CanUserCreateThread()>
			<cfset getErrorManager().addErrorByCode($.event(),2016)>
			<cfreturn>
		</cfif>

		<!--- forum exists --->
		<cfif not forumBean.beanExists()>
			<cfset getErrorManager().addErrorByCode($.event(),1012)>
			<cfreturn>
		</cfif>

		<!--- content check --->
		<cfif not len( form.message )>
			<cfset getErrorManager().addErrorByCode($.event(),1055)>
			<cfreturn>
		</cfif>

		<!--- new thread --->
		<cfset sArgs.siteID			= $.event().getValue("siteID") />
		<cfset sArgs.title			= form.title />
		<cfset sArgs.userID			= $.currentUser().getUserID() />
		<cfset sArgs.isActive		= 1 />

		<!--- moderator fields --->
		<cfif meldForumsBean.UserHasModeratePermissions()>
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
				<cfset threadService.saveThread( threadBean )>
				<cfset forumService.updateThreadCounter( threadBean.getForumID() )>
				<cfset forumService.setLastPostID( threadBean.getForumID(),postBean.getPostID() )>

				<cfset userDataService.userAddedThread( threadBean.getUserID(),threadBean.getThreadID(),$.event().getValue("siteID") ) />
			</cftransaction>
			<cfif not getErrorManager().hasErrors( $.event() )>
				<cfif isDefined("form.NEWATTACHMENT") and len(form.NEWATTACHMENT)>
					<cfset sArgs.rc					= arguments.rc />
					<cfset sArgs.postID				= postBean.getPostID() />
					<cfset sArgs.configurationBean	= meldForumsBean.getConfigurationBean() />
					<cfset attachmentID				= doFileAttachment( argumentCollection=sArgs )>
					<cfset postBean.setAttachmentID( attachmentID ) />
				</cfif>
				<cfif len( attachmentID )>
					<cfset postService.updatePost( postBean )>
				</cfif>
			</cfif>

			<cfcatch type="custom">
				<cfif len( attachmentID )>
					<cfset fileUploadManager.deleteFile( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError($.event(),cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
			<cfcatch>
				<cfif len( attachmentID )>
					<cfset fileUploadManager.deleteFile( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError($.event(),cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
		</cftry>

		<!--- process notifications --->
		<cfif not getErrorManager().hasErrors( $.event() )>
			<cfset rc.postBean			= postBean />
			<cfset rc.threadBean		= threadBean />
			<cfset rc.userBean			= userBean />
			<cfset rc.forumWebRoot		= meldForumsBean.getForumWebRoot() />
			<cfset rc.siteID			= $.event().getValue("siteID") />
			
			<cfset rc.subscriptionText	= "" />
			
			<cftry>
				<cfsavecontent variable="rc.subscriptionText">
				<cfoutput><cfinclude template="/#rc.pluginConfig.getPackage()#/themes/#rc.meldForumsBean.getValue("themeBean").getDirectory()#/assets/templates/subscriptionText.cfm" /></cfoutput>
				</cfsavecontent>
				<cfcatch>
					<cfdump var="#cfcatch#"><cfabort>
				</cfcatch>
			</cftry>
				
			<!---<cfset subscribeService.processSubscriptions( argumentCollection=rc )>--->
		</cfif>
		
		<cfif not getErrorManager().hasErrors( $.event() )>
			<cflocation url="#meldForumsBean.getForumWebRoot()#viewthread/#threadBean.getThreadID()#/" addtoken="false">
		</cfif>
	</cffunction>

	<cffunction name="doGetNewPost" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var quotePostBean			= "" />
		<cfset var threadBean				= "" />

		<cfset var threadID					= $.event().getValue("threadID") />
		<cfset var quoteID					= $.event().getValue("quoteID") />

		<cfset var txtQuote					= "" />

		<cfset sArgs.ThreadID				= threadID />
		<cfset threadBean					= threadService.getThread( argumentCollection=sArgs ) />
		<cfset postBean						= postService.createPost( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not meldForumsBean.CanUserCreatePost( threadBean )>
			<cflocation url="#meldForumsBean.getForumWebRoot()#/?ecode=2001" addtoken="false">
			<cfreturn>
		</cfif>

		<cfif len( quoteID )>
			<cfset sArgs.postID				= quoteID />
			<cfset quotePostBean			= postService.getPost( argumentCollection=sArgs ) />
			
			<cfif quotePostBean.beanExists()>
				<cfset txtQuote = "[quote]" & quotePostBean.getMessage() & "[/quote]" />
				<cfset postBean.setMessage( txtQuote ) />		
			</cfif>
		</cfif>
		
		<cfset rc.threadBean		= threadBean />
		<cfset rc.postBean			= postBean />
		<cfset rc.configurationBean	= meldForumsBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="doCreateNewPost" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var userDataService			= getBeanFactory().getBean("userDataService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>
		<cfset var fileUploadManager		= getBeanFactory().getBean("FileUploadManager") />

		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>
		<cfset var userBean					= meldForumsBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var threadBean				= "" />
		<cfset var configurationBean		= "" />

		<cfset var threadID					= $.event().getValue("threadID") />
		<cfset var attachmentID				= "" />
		<cfset var postPosition				= 0 />

		<cfset sArgs.threadID		= threadID />
		<cfset threadBean			= threadService.getThread( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not meldForumsBean.CanUserCreatePost( threadBean )>
			<cfset getErrorManager().addErrorByCode($.event(),2016)>
			<cfreturn>
		</cfif>

		<!--- content check --->
		<cfif not len( form.message )>
			<cfset getErrorManager().addErrorByCode($.event(),1055)>
			<cfreturn>
		</cfif>

		<!--- new post --->
		<cfset sArgs.message		= form.message />
		<cfset sArgs.threadID		= threadBean.getThreadID() />
		<cfset sArgs.siteID			= $.event().getValue("siteID") />
		<cfset sArgs.userID			= $.currentUser().getUserID() />
		<cfset sArgs.isActive		= 1 />

		<cfset postBean				= postService.createPost( argumentCollection=sArgs ) />

		<cftry>
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
				<cfset userDataService.userAddedPost( argumentCollection=sArgs ) />
			</cftransaction>

			<cfif not getErrorManager().hasErrors( $.event() )>
				<cfif isDefined("form.NEWATTACHMENT") and len(form.NEWATTACHMENT)>
					<cfset sArgs.rc					= arguments.rc />
					<cfset sArgs.postID				= postBean.getPostID() />
					<cfset sArgs.configurationBean	= meldForumsBean.getConfigurationBean() />
					<cfset attachmentID				= doFileAttachment( argumentCollection=sArgs )>
					<cfset postBean.setAttachmentID( attachmentID ) />
				</cfif>
				<cfif len( attachmentID )>
					<cfset postService.updatePost( postBean )>
				</cfif>
			</cfif>

			<cfcatch type="custom">
				<cfif len( attachmentID )>
					<cfset fileUploadManager.deleteFile( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError($.event(),cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
			<cfcatch>
				<cfif len( attachmentID )>
					<cfset fileUploadManager.deleteFile( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError($.event(),cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
		</cftry>

		<!--- process notifications --->
		<cfif not getErrorManager().hasErrors( $.event() )>
			<cfset rc.postBean			= postBean />
			<cfset rc.threadBean		= threadBean />
			<cfset rc.userBean			= userBean />
			<cfset rc.forumWebRoot		= meldForumsBean.getForumWebRoot() />
			<cfset rc.siteID			= $.event().getValue("siteID") />
			
			<cfset rc.subscriptionText	= "" />
			
			<cftry>
				<cfsavecontent variable="rc.subscriptionText">
				<cfoutput><cfinclude template="/#rc.pluginConfig.getPackage()#/themes/#rc.meldForumsBean.getValue("themeBean").getDirectory()#/assets/templates/subscriptionText.cfm" /></cfoutput>
				</cfsavecontent>
				<cfcatch>
					<cfdump var="#cfcatch#"><cfabort>
				</cfcatch>
			</cftry>
				
			<!---<cfset subscribeService.processSubscriptions( argumentCollection=rc )>--->
		</cfif>
		
		<cfif not getErrorManager().hasErrors( $.event() )>
			<cflocation url="#meldForumsBean.getForumWebRoot()#viewthread/#threadBean.getThreadID()#/?pp=#postBean.getPostPosition()###p#postBean.getPostPosition()#" addtoken="false">
		</cfif>

	</cffunction>

	<cffunction name="doGetEditPost" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var userDataService			= getBeanFactory().getBean("userDataService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>

		<cfset var pageManager				= getBeanFactory().getBean("PageManager")>
		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>
		<cfset var userBean					= meldForumsBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />
		<cfset var configurationBean		= "" />

		<cfset var postID					= $.event().getValue("postID") />
		<cfset var attachmentID				= "" />

		<cfset sArgs.postID					= postID />
		<cfset postBean						= postService.getPost( argumentCollection=sArgs ) />
		<cfset sArgs.ThreadID				= postBean.getThreadID() />
		<cfset threadBean					= threadService.getThread( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not meldForumsBean.CanUserEditPost( postBean,threadBean )>
			<cfset getErrorManager().addErrorByCode($.event(),2001)>
		</cfif>

		<cfif not postBean.beanExists()>
			<cflocation url="#meldForumsBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset rc.postBean			= postBean />
		<cfset rc.threadBean		= threadBean />
		<cfset rc.configurationBean	= meldForumsBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="doUpdateEditPost" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean			= $.event().getValue("MeldForumsBean") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var userDataService			= getBeanFactory().getBean("userDataService") />
		<cfset var generalUtility			= getBeanFactory().getBean("generalUtility")>
		<cfset var fileUploadManager		= getBeanFactory().getBean("FileUploadManager") />

		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>
		<cfset var userBean					= meldForumsBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs					= StructNew() />

		<cfset var postBean					= "" />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />

		<cfset var postID					= $.event().getValue("postID") />
		<cfset var attachmentID				= "" />
		<cfset var oldAttachmentID			= "" />


		<cfset postBean						= postService.getPost( postID ) />

		<cfif not postBean.beanExists()>
			<cflocation url="#meldForumsBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset threadBean					= threadService.getThread( postBean.getThreadID() ) />

		<!--- content check --->
		<cfif not len( form.message )>
			<cfset getErrorManager().addErrorByCode($.event(),1055)>
			<cfreturn>
		</cfif>

		<!--- moderator fields --->
		<cfif meldForumsBean.UserHasModeratePermissions()>
			<cfset sArgs.IsActive			= $.event().getValue("doSetActive") eq 1 />
			<cfset sArgs.IsDisabled			= $.event().getValue("doSetDisabled") eq 1 />
			<cfset sArgs.IsModerated		= $.event().getValue("doSetModerated") eq 1 />
			<cfset sArgs.BlockAttachment	= $.event().getValue("doBlockAttachment") eq 1 />

			<cfif sArgs.IsModerated>
				<cfset sArgs.dateModerated	= CreateODBCDateTime( now() ) />
			</cfif>

			<cfset sArgs.adminID			= $.currentUser().getUserID()>
		</cfif>

		<!--- new post --->
		<cfset sArgs.message		= form.message />
		<cfset postBean.updateMemento( sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not meldForumsBean.CanUserEditPost( postBean,threadBean )>
			<cfset getErrorManager().addErrorByCode($.event(),2001)>
		</cfif>

		<cftry>
			<cfif $.event().getValue("doDeleteAttachment") eq 1 and len( postBean.getAttachmentID() )>
				<cfset fileUploadManager.deleteFileByFileID( postBean.getAttachmentID() ) />
				<cfset postBean.setAttachmentID('')>
			</cfif>
			<cfcatch>
				<cfif len( attachmentID )>
					<cfset fileUploadManager.deleteFileByFileID( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError($.event(),cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
		</cftry>

		<cftry>
			<cfif not getErrorManager().hasErrors( $.event() )>
				<cfif isDefined("form.NEWATTACHMENT") and len(form.NEWATTACHMENT)>
					<cfset oldAttachmentID			= postBean.getAttachmentID() />
					<cfset sArgs.rc					= arguments.rc />
					<cfset sArgs.postID				= postBean.getPostID() />
					<cfset sArgs.configurationBean	= meldForumsBean.getConfigurationBean() />
					<cfset attachmentID				= doFileAttachment( argumentCollection=sArgs )>
					<cfset postBean.setAttachmentID( attachmentID ) />
				</cfif>

				<cfset postService.updatePost( postBean )>

				<cfif len( oldAttachmentID )>
					<cfset fileUploadManager.deleteFileByFileID( oldAttachmentID ) />
				</cfif>
			</cfif>
			<cfcatch type="custom">
				<cfif len( attachmentID )>
					<cfset fileUploadManager.deleteFileByFileID( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError($.event(),cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
			<cfcatch>
				<cfif len( attachmentID )>
					<cfset fileUploadManager.deleteFileByFileID( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError($.event(),cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
		</cftry>
		
		<cfif not getErrorManager().hasErrors( $.event() )>
			<cflocation url="#meldForumsBean.getForumWebRoot()#viewthread/#threadBean.getThreadID()#/" addtoken="false">
		</cfif>
	</cffunction>

	<cffunction name="doUpdateSubscribe" returntype="string" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />
		<cfset var subscribeService		= getBeanFactory().getBean("subscribeService") />
		<cfset var subscriptionLimit	= meldForumsBean.getValue("settingsBean").getSubscriptionLimit()>

		<cfset var type					= $.event().getValue("type")>
		<cfset var mode					= $.event().getValue("mode")>

		<cfset var threadID				= $.event().getValue("threadID")>
		<cfset var forumID				= $.event().getValue("forumID")>

		<cfset var isSuccess			= false>

		<cfset var sArgs				= StructNew() />

		<!--- perm --->
		<cfif not meldForumsBean.userHasReadPermissions()>
			<cflocation url="#meldForumsBean.getForumWebRoot()#?ecode=2011" addtoken="false">
			<cfreturn>
		</cfif>

		<cfif meldForumsBean.userHasModeratePermissions()>
			<cfset subscriptionLimit = 0>
		</cfif>

		<cfset sArgs.userID		= $.currentUser().getUserID() />
		<cfset sArgs.limit		= subscriptionLimit />
		<cfset sArgs.threadID	= threadID />
		<cfset sArgs.forumID	= forumID />

		<cfswitch expression="#mode#">
			<cfcase value="add">
				<cfif type eq "thread">
					<cfset isSuccess = subscribeService.doSubscribeToThread(argumentCollection=sArgs)>
				<cfelseif type eq "forum">
					<cfset isSuccess = subscribeService.doSubscribeToForum(argumentCollection=sArgs)>
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<cfif type eq "thread">
					<cfset subscribeService.doUnSubscribeToThread(argumentCollection=sArgs)>
				<cfelseif type eq "forum">
					<cfset subscribeService.doUnSubscribeToForum(argumentCollection=sArgs)>
				</cfif>
				<cfset isSuccess = true>
            </cfdefaultcase>
		</cfswitch>
		
		<cfif isSuccess>
			<cfif type eq "thread">
				<cflocation url="#meldForumsBean.getForumWebRoot()#viewthread/#threadID#/" addtoken="false">
			<cfelseif type eq "forum">
				<cflocation url="#meldForumsBean.getForumWebRoot()#viewforum/#forumID#/" addtoken="false">
			</cfif>
		<cfelse>
			<cfif type eq "thread">
				<cflocation url="#meldForumsBean.getForumWebRoot()#viewthread/#threadID#/?ecode=1601" addtoken="false">
			<cfelseif type eq "forum">
				<cflocation url="#meldForumsBean.getForumWebRoot()#viewforum/#forumID#/?ecode=1601" addtoken="false">
			</cfif>
		</cfif>
	</cffunction>


	<!--- note: make sure calls to this function are within a cftry/cftransaction --->
	<cffunction name="doFileAttachment" returntype="string" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">
		<cfargument name="postID" type="uuid" required="true">
		<cfargument name="configurationBean" type="any" required="true">

		<cfset var fileUploadManager	= getBeanFactory().getBean("FileUploadManager") />
		<cfset var sArgs				= StructNew() />
		<cfset var fileID				= "" />

		<cfset sArgs.FieldName			= "NEWATTACHMENT">
		<cfset sArgs.contentID			= arguments.postID>
		<cfset sArgs.configurationBean	= arguments.configurationBean>
		<cfset sArgs.moduleID			= rc.pluginConfig.getModuleID()>

		<cfset sArgs.siteID				= $.event().getValue("siteID") />

		<cfset fileID = fileUploadManager.uploadFile( argumentCollection=sArgs )>
		<cfreturn fileID />
	</cffunction>
</cfcomponent>