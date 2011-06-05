<cfsilent>
	<!--- headers --->
	<cfset local.sStr = "" />
	<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
	<cfset local.event.setValue('data',form.data) />
	<cfset local.sStr = "" />
	<cfset local.sStr = rc.mmEvents.renderEvent( rc.$,"onMeldForumsRenderPreview",local.event ) />
</cfsilent><cfoutput>
<!--- begin content --->
	<!-- CONTENT HERE -->
	<cfif len(local.sStr)>
		#local.sStr#
	<cfelse>
		<cfinclude template="#rc.themeDirectory#/templates/display/preview.cfm">
	</cfif>
<!--- end content --->
</cfoutput> 
