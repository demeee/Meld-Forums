<cfsilent>
	<cfset rc = attributes.local.rc />
	<cfset local = StructNew() />

	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_services_panel.cfm">
</cfsilent><cfoutput>
<table class="servicesblock">
	<tr>
		<td class="searchform">
			<cfif StructKeyExists(attributes.eventContent,"search")>
				#attributes.eventContent['search']#
			<cfelse>
				<cfmodule template="searchform.cfm" local="#attributes.local#">
			</cfif>
		</td>
		<td class="servicelinks">
			<cfif StructKeyExists(attributes.eventContent,"panel")>
				#attributes.eventContent['panel']#
			</cfif>
			<cfif local.event.getValue('renderDefaultPanel')>
				#rc.MFBean.getProfilePanelLink()#
				#rc.MFBean.getLogInOutLink()#
			</cfif>
		</td>
	</tr>
</table>
</cfoutput>