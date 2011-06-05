<!---
||MELDFORUMSLICENSE||
--->
<!--- global includes for plugin.css and plugin.js --->
<cfsilent>
<cfsavecontent variable="local.str"><cfoutput>
<link rel="stylesheet" href="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/admin/assets/css/custom-theme/jquery-ui-tabs.css" type="text/css" media="all">
<script src="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/admin/assets/js/jquery-ui-tabs.js" type="text/javascript" language="Javascript"></script></cfoutput>
</cfsavecontent>
<cfset arrayPrepend( rc.headLoader,local.str )>
</cfsilent>
