<cfsilent>
	<!--- use 'local' to keep view-related data in-scope --->
	<cfset local.rc		= rc>
	<!--- headers --->
	<cfinclude template="headers/jquery-datatable-conference.cfm">
	<cfinclude template="/#local.rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-datatable.cfm">
	<cfinclude template="/#local.rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui.cfm">
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<div id="meld-actions" class="clearfix">
		#view("conferences/includes/default_actions")#
	</div>
	<!-- CONTENT HERE -->
	#view("conferences/includes/default_list")#
</div>	
<!--- end content --->
</cfoutput> 