<cfsilent>
	<cfset local.rc = rc />
</cfsilent>
<cfoutput>
	<cfif local.rc.errors.hasErrors("notice")>
	<div class="notice">
		#local.rc.errors.displayErrorsHTML("notice")#
	</div>
	</cfif>
	<cfif local.rc.errors.hasErrors("custom")>
	<div class="error">
		#local.rc.errors.displayErrorsHTML("custom")#
	</div>
	</cfif>
	<cfif local.rc.errors.hasErrors("other")>
	<div class="error">
		#local.rc.errors.displayErrorsHTML("other")#
	</div>
	</cfif>
</cfoutput>