<cfsilent>
	<!--- use 'local' to keep view-related data in-scope --->
	<cfset local.rc		= rc>
	<!--- headers --->
	<cfinclude template="../../includes/headers/editor.cfm">
</cfsilent><cfoutput>#body#</cfoutput>
