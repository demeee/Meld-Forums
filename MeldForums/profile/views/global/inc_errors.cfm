<cfsilent>
	<cfset local.rc = rc />
</cfsilent>
<cfoutput>
	<cfif local.rc.errors.hasErrors($.event(),"notice")>
	<div class="notice">
		#local.rc.errors.displayErrorsHTML($.event(),"notice")#
	</div>
	</cfif>
	<cfif local.rc.errors.hasErrors($.event(),"custom")>
	<div class="error">
		#local.rc.errors.displayErrorsHTML($.event(),"custom")#
	</div>
	</cfif>
	<cfif local.rc.errors.hasErrors($.event(),"other")>
	<div class="error">
		#local.rc.errors.displayErrorsHTML($.event(),"other")#
	</div>
	</cfif>
</cfoutput>