<!---
||MELDFORUMSLICENSE||
--->
<cfsilent>
</cfsilent>
<cfoutput>
	<cfif rc.errorBean.hasErrors("notice")>
	<div class="notice">
		#rc.errorBean.hasErrors.displayErrorsHTML("notice")#
	</div>
	</cfif>
	<cfif rc.errorBean.hasErrors("custom")>
	<div class="error">
		#rc.errorBean.displayErrorsHTML("custom")#
	</div>
	</cfif>
	<cfif rc.errorBean.hasErrors("other")>
	<div class="error">
		#rc.errorBean.displayErrorsHTML("other")#
	</div>
	</cfif>
</cfoutput>