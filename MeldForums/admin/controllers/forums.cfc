<cfcomponent extends="controller">

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var conferenceService		= getBeanFactory().getBean("conferenceService") />
		<cfset var aConferences				= ArrayNew(1) />
		<cfset var sArgs					= StructNew() />
		<cfset var mmBreadCrumbs			= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle			= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var conferenceBean			= "" />
		<cfset var configurationService	= getBeanFactory().getBean("configurationService") />

		<cfset configurationService.verifyBaseConfiguration( rc.siteID ) />
		
		<cfparam name="arguments.rc.conferenceID" default="" />

		<cfset sArgs.isActive		= 1>
		<cfset sArgs.siteID			= rc.siteID />
		<cfset aConferences			= conferenceService.getConferences(argumentCollection=sArgs) />
		<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('conferences'),"?action=conferences" )>
		<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('forums'),"?action=forums" )>

		<cfset arguments.rc.aConferences	= aConferences />
		<cfset arguments.rc.conferenceBean	= conferenceBean />
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset var conferenceService	= getBeanFactory().getBean("conferenceService") />
		<cfset var forumService			= getBeanFactory().getBean("forumService") />
		<cfset var configurationService	= getBeanFactory().getBean("configurationService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var mmBreadCrumbs		= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle		= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var forumBean			= "" />
		<cfset var newForumBean			= "" />
		<cfset var aConfiguration		= ArrayNew(1)>
		<cfset var conferenceBean		= "" />
		<cfset var aConferences			= ArrayNew(1) />

		<cfset var sPresets			= StructNew() />
		<cfset var sArgs			= StructNew() />

		<cfparam name="rc.conferenceID" default="" />

		<!--- check if a button was clicked --->
		<cfif isDefined("arguments.rc.btaction")>
			<!--- cancel? --->
			<cfif arguments.rc.btaction eq 'cancel'>
				<cflocation url="?action=forums&conferenceID=#arguments.rc.conferenceID#" addtoken="false">
			<!--- save? --->
			<cfelseif arguments.rc.btaction eq 'save'>
				<cfset success = actionSaveForum( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=forums&conferenceID=#arguments.rc.conferenceID#" addtoken="false">
				</cfif> 
			<!--- update? --->
			<cfelseif arguments.rc.btaction eq 'update'>
				<cfset success = actionUpdateForum( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=forums&conferenceID=#arguments.rc.conferenceID#" addtoken="false">
				</cfif>
			</cfif>
		<cfelseif isDefined("arguments.rc.btdeleteconfirm") and arguments.rc.btdeleteconfirm eq "delete">
			<cfset success = actionDeleteForum( arguments.rc )>
			<cfif success eq true>
				<cflocation url="?action=forums&conferenceID=#arguments.rc.conferenceID#" addtoken="false">
			</cfif> 
		</cfif>

		<cfif isDefined( "arguments.rc.forumID" )>
			<cfset var forumBean = forumService.getForum( forumID = arguments.rc.forumID ) />
			<cfset arguments.rc.conferenceID = forumBean.getConferenceID()>
		<cfelse>
			<cfset sPresets.isActive		= 1 />
			<cfif StructKeyExists(rc,"conferenceID")>
				<cfset sPresets.conferenceID	= rc.conferenceID />
			</cfif>
			<cfset forumBean 				= forumService.createForum() />
		</cfif>

		<cfif forumBean.beanExists()>
			<cfset sArgs = StructNew() />
			<cfset sArgs.conferenceID = arguments.rc.conferenceID>
			<cfset conferenceBean		= conferenceService.getConference(argumentCollection=sArgs) />
			<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('conferences'),"?action=conferences" )>
			<cfset mmBreadCrumbs.addCrumb( rc,conferenceBean.getName(),"?action=forums&conferenceid=" & arguments.rc.conferenceID )>
			<cfset mmBreadCrumbs.addCrumb( rc,forumBean.getName() )>
			<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('edit') )>
		<cfelse>
			<cfset sArgs = StructNew() />
			<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('conferences'),"?action=conferences" )>

			<cfif StructKeyExists(rc,"conferenceID") and len(rc.conferenceID)>
				<cfset sArgs.conferenceID	= arguments.rc.conferenceID>
				<cfset conferenceBean 		= conferenceService.getConference(argumentCollection=sArgs) />
				<cfset mmBreadCrumbs.addCrumb( rc,conferenceBean.getName(),"?action=forums&conferenceid=" & arguments.rc.conferenceID )>
			</cfif>
			<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('addforum') )>
		</cfif>
		
		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(forumBean,sPresets) />

		<cfset aConfiguration				= configurationService.getConfigurations( siteID=arguments.rc.siteID )>

		<cfset sArgs				= StructNew() />

		<!---<cfset sArgs.isActive		= 1>--->
		<cfset sArgs.siteID			= rc.siteID />
		<cfset aConferences			= conferenceService.getConferences(argumentCollection=sArgs) />
		
		<!--- return vars --->
		<cfset rc.aConferences		= aConferences />
		<cfset rc.forumBean			= forumBean />
		<cfset rc.aConfiguration	= aConfiguration />
	</cffunction>

	<cffunction name="actionUpdateForum" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var forumService		= getBeanFactory().getBean("ForumService") />
		<cfset var mmFormTools		= getBeanFactory().getBean("mmFormTools") />
		<cfset var forumBean		= "" />
		<cfset var sArgs			= StructNew() />

		<!--- create a blank Forum bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset var forumBean 		= forumService.createForum() />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(forumBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
	
		<!--- now get the existing bean --->
		<cfset forumBean = ForumService.getForum( formData.forumbean.forumID ) />
		<!--- set the new values --->
		<cfset forumBean.updateMemento( formData.forumBean )>
		
		<!--- update the forum --->
		<cfreturn ForumService.updateForum( forumBean ) />		
	</cffunction>	

	<cffunction name="actionSaveForum" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var forumService			= getBeanFactory().getBean("ForumService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var forumBean			= "" />
		<cfset var sArgs				= StructNew() />

		<!--- create a blank Forum bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset var forumBean 		= forumService.createForum() />

		<cfset forumBean.setAdminID( rc.$.currentUser('userID') ) />
		<cfset forumBean.setSiteID( rc.siteID ) />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(forumBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset forumBean.updateMemento( formData.forumBean )>

		<!--- save the forum --->
		<cfreturn ForumService.saveForum( forumBean ) />		
	</cffunction>	

	<cffunction name="actionDeleteForum" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">
		<cfset var forumService	= getBeanFactory().getBean("ForumService") />
		<cfset var mmFormTools	= getBeanFactory().getBean("mmFormTools") />
		
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
		
		<!--- save the forum --->
		<cfreturn ForumService.deleteForum( formData.forumbean.forumID ) />		
	</cffunction>	
</cfcomponent>