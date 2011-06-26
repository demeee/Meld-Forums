<cfsilent>
	<!--- headers --->
	<cfset local.sStr = "" />
	<cfinclude template="../../includes/headers/editor.cfm">
	<cfinclude template="../../includes/headers/edit.cfm">
	<cfif len(rc.panel)>
		<cfinclude template="panels/#rc.panel#.cfm">
	</cfif>
</cfsilent><cfoutput>
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
	<cfif local.rc.errors.hasErrors()>
		<cfset local.sStr = "" />
		<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
		<cfset local.event.setValue('errors',rc.errors) />
		<cfset local.sStr = rc.mmEvents.renderEvent( rc.$,"onMeldForumsRenderErrors",local.event ) />
		<cfif len(local.sStr)>
			#local.sStr#
		<cfelse>
			#view("global/inc_errors")#
		</cfif>
	</cfif>

	<cfif len(local.sStr) and rc.MFBean.userHasProfilePermissions(rc.userID)>
		#local.sStr#
	<cfelse>
		<cfif rc.panel eq "moderate">
			<cfif  rc.MFBean.userHasModeratePermissions(rc.userID)>
				<cfinclude template="#rc.MFBean.getThemeDirectory()#/templates/display/profilepanel.cfm">
			<cfelse>
				<cflocation url="#rc.MFBean.getProfileLink(rc.userBean)#?ecode=2021" addtoken="false" />
			</cfif>
		<cfelseif rc.MFBean.userHasProfilePermissions(rc.userID)>
			<cfinclude template="#rc.MFBean.getThemeDirectory()#/templates/display/profilepanel.cfm">
		<cfelse>
			<cflocation url="#rc.MFBean.getProfileLink(rc.userBean)#?ecode=2020" addtoken="false" />
		</cfif>
	</cfif>
</div>	
<!--- end content --->
</cfoutput>