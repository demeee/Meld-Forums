<cfcomponent extends="controller">

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('conferences'),"?action=conferences" )>
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset var conferenceService	= getBeanFactory().getBean("conferenceService") />
		<cfset var configurationService	= getBeanFactory().getBean("configurationService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var conferenceBean		= "" />
		<cfset var newConferenceBean	= "" />
		<cfset var aConfiguration		= ArrayNew(1)>

		<cfset var sPresets			= StructNew() />
		<cfset var sArgs			= StructNew() />

		<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('conferences'),"?action=conferences" )>

		<!--- check if a button was clicked --->
		<cfif isDefined("rc.btaction")>
			<!--- cancel? --->
			<cfif arguments.rc.btaction eq 'cancel'>
				<cflocation url="?action=conferences" addtoken="false">
			<!--- save? --->
			<cfelseif rc.btaction eq 'save'>
				<cfset success = actionSaveConference( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=conferences" addtoken="false">
				</cfif> 
			<!--- update? --->
			<cfelseif rc.btaction eq 'update'>
				<cfset success = actionUpdateConference( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=conferences" addtoken="false">
				</cfif>
			</cfif>
		<cfelseif isDefined("rc.btdeleteconfirm") and rc.btdeleteconfirm eq "delete">
			<cfset success = actionDeleteConference( arguments.rc )>
			<cfif success eq true>
				<cflocation url="?action=conferences" addtoken="false">
			</cfif> 
		</cfif>

		<cfif isDefined( "rc.conferenceID" )>
			<cfset conferenceBean = conferenceService.getConference( conferenceID = rc.conferenceID ) />
			<cfif conferenceBean.beanExists()>
				<cfset rc.mmBC.addCrumb( rc,conferenceBean.getName() )>
			</cfif>
			<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('edit') )>
		<cfelse>
			<cfset sPresets.isActive		= 1 />
			<cfset conferenceBean = conferenceService.createConference() />
			<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('addconference') )>
		</cfif>
		
		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(conferenceBean,sPresets) />

		<cfset var aConfiguration		= configurationService.getConfigurations( siteID=rc.siteID )>
		
		<!--- return vars --->
		<cfset rc.conferenceBean		= conferenceBean />
		<cfset rc.aConfiguration		= aConfiguration />
	</cffunction>

	<cffunction name="actionUpdateConference" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var conferenceBean		= "" />
		<cfset var sArgs				= StructNew() />

		<!--- create a blank Conference bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset var conferenceBean 		= conferenceService.createConference() />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(conferenceBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
	
		<!--- now get the existing bean --->
		<cfset conferenceBean = ConferenceService.getConference( formData.conferencebean.conferenceID ) />
		<!--- set the new values --->
		<cfset conferenceBean.updateMemento( formData.conferenceBean )>
		
		<!--- update the conference --->
		<cfreturn ConferenceService.updateConference( conferenceBean ) />		
	</cffunction>	

	<cffunction name="actionSaveConference" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var conferenceBean		= "" />
		<cfset var sArgs				= StructNew() />
		<cfset var formData				= StructNew() />

		<!--- create a blank Conference bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset var conferenceBean 		= conferenceService.createConference() />

		<cfset conferenceBean.setSiteID( rc.siteID ) />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(conferenceBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset conferenceBean.updateMemento( formData.conferenceBean )>
		
		<!--- save the conference --->
		<cfreturn ConferenceService.saveConference( conferenceBean ) />		
	</cffunction>	

	<cffunction name="actionDeleteConference" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">
		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
		
		<!--- save the conference --->
		<cfreturn ConferenceService.deleteConference( formData.conferencebean.conferenceID ) />		
	</cffunction>	
</cfcomponent>