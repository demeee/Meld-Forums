<cfsilent>
	<!--- headers --->
	<cfset local.sStr = "" />
	<cfinclude template="../../includes/headers/editor.cfm">
	<cfinclude template="../../includes/headers/edit.cfm">
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
	<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
	<cfset local.event.setValue('userBean',rc.userBean ) />
	<cfset local.event.setValue('view',rc.view ) />
	<cfset local.event.setValue('userID',rc.userID ) />
	<cfset local.sStr = "" />

	<cfset local.sStr = rc.mmEvents.renderEvent( rc.$,"onMeldForumsRenderProfile",local.event ) />

	<cfif len(local.sStr)>
		#local.sStr#
	<cfelse>
		<cfinclude template="#rc.MFBean.getThemeDirectory()#/templates/display/viewprofile.cfm">
	</cfif>
</div>	
<!--- end content --->
</cfoutput>