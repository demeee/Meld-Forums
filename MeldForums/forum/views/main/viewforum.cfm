<cfsilent>
	<!--- use 'local' to keep view-related data in-scope --->
	<cfset local.rc			= rc>
	<cfset local.dirRoot	= "/#rc.pluginConfig.getPackage()#">
	<!--- headers --->
	<cfoutput>
	</cfoutput>
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
	#view("global/inc_errors")#
	<cfinclude template="#local.dirRoot#/themes/#local.rc.themeBean.getDirectory()#/templates/display/viewforum.cfm">
</div>	
<!--- end content --->
</cfoutput> 