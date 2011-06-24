<cfcomponent extends="controller">
	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var settingsService		= getBeanFactory().getBean("settingsService") />
		<cfset var mmBreadCrumbs		= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle		= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var settingsBean			= "" />
		<cfset var sArgs				= StructNew() />

		<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('settings'),"" )>

		<!--- Settings are by siteID --->
		<cfset sArgs = StructNew() />
		<cfset sArgs.siteID = rc.siteID>
		<cfset settingsBean		= settingsService.getSettings( argumentCollection=sArgs ) />

		<!--- Settings are by siteID; if settingsBean does not exist, call the function to create the site settingsBean --->
		<cfif not settingsBean.beanExists()>
			<cfset settingsService.createSettingsForSite( argumentCollection=sArgs )>
			<cfset settingsBean	= settingsService.getSettings( argumentCollection=sArgs ) />
		</cfif>

		<cfset rc.settingsBean	= settingsBean />
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset var settingsService		= getBeanFactory().getBean("settingsService") />
		<cfset var themeService			= getBeanFactory().getBean("themeService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var mmBreadCrumbs		= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle		= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var settingsBean			= "" />
		<cfset var newSettingsBean		= "" />
		
		<cfset var qGroupsPublic		= rc.$.getBean("userManager").getPublicGroups( session.siteID ) />
		<cfset var qGroupsPrivate		= rc.$.getBean("userManager").getPrivateGroups( session.siteID ) />

		<cfset var sPresets			= StructNew() />
		<cfset var sArgs			= StructNew() />

		<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('settings'),"?action=settings" )>

		<!--- check if a button was clicked --->
		<cfif isDefined("rc.btaction")>
			<!--- cancel? --->
			<cfif rc.btaction eq 'cancel'>
				<cflocation url="?action=settings" addtoken="false">
			<!--- update? --->
			<cfelseif rc.btaction eq 'update'>
				<cfset success = actionUpdateSettings( rc )>
				<cfif success eq true>
					<cflocation url="?action=settings" addtoken="false">
				</cfif>
			</cfif>
		</cfif>

		<!--- Settings are by siteID --->
		<cfset sArgs = StructNew() />
		<cfset sArgs.siteID = rc.siteID>
		<cfset settingsBean		= settingsService.getSettings( argumentCollection=sArgs ) />

		<!--- Settings are by siteID; if settingsBean does not exist, call the function to create the site settingsBean --->
		<cfif not settingsBean.beanExists()>
			<cfset settingsService.createSettingsForSite( argumentCollection=sArgs )>
			<cfset settingsBean	= settingsService.getSettings( argumentCollection=sArgs ) />
		</cfif>

		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(settingsBean,sPresets) />
		
		<!--- return vars --->
		<cfset rc.settingsBean	= settingsBean />
		<cfset rc.aThemes		= themeService.getThemes( isActive=1 ) />

		<cfset rc.qGroupsPublic		= qGroupsPublic />
		<cfset rc.qGroupsPrivate	= qGroupsPrivate />
			
	</cffunction>

	<cffunction name="actionUpdateSettings" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var settingsService	= getBeanFactory().getBean("SettingsService") />
		<cfset var mmFormTools		= getBeanFactory().getBean("mmFormTools") />
		<cfset var settingsBean		= "" />
		<cfset var sArgs			= StructNew() />

		<!--- create a blank Settings bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset var settingsBean 		= settingsService.createSettings() />

		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(settingsBean) />

		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
	
		<!--- now get the existing bean --->
		<cfset settingsBean = SettingsService.getBeanByAttributes( formData.settingsbean.settingsID ) />

		<!--- set the new values --->
		<cfset settingsBean.updateMemento( formData.settingsBean )>
		
		<!--- update the settings --->
		<cfreturn SettingsService.updateSettings( settingsBean ) />		
	</cffunction>	
</cfcomponent>