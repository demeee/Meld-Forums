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
	<cfset local.event.setValue('postBean',rc.postBean ) />
	<cfset local.event.setValue('threadBean',rc.threadBean ) />
	<cfset local.event.setValue('parentPostBean',rc.parentPostBean ) />
	<cfset local.sStr = "" />

	<cfset local.sStr = rc.mmEvents.renderEvent( rc.$,"onMeldForumsRenderPostNew",local.event ) />

	<cfif len(local.sStr)>
		#local.sStr#
	<cfelse>
		<cfinclude template="#rc.MFBean.getThemeDirectory()#/templates/display/editor.cfm">
	</cfif>

	#createUUID()#
</div>	
<!--- end content --->
</cfoutput> 