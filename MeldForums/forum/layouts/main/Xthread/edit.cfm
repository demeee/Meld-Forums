<cfsilent>
	<!--- use 'local' to keep view-related data in-scope --->
	<cfset local.rc		= rc>
	<!--- headers --->
	<cfinclude template="../../includes/headers/editor.cfm">
	<cfinclude template="../../includes/headers/editthread.cfm">
</cfsilent><cfoutput>#body#</cfoutput>
