<!---
||MELDFORUMSLICENSE||
--->
<cfsilent>
	<!--- headers --->
	<cfinclude template="../includes/headers/global.cfm">
</cfsilent>
<cfoutput>#replace(application.pluginManager.renderAdminTemplate(body=body,pageTitle=rc.pluginConfig.getName(),jsLib="jquery"),"cPlugins","msPlugins")#</cfoutput>