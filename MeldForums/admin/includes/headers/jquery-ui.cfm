<!---
||MELDFORUMSLICENSE||
--->
<cfsilent>
<cfsavecontent variable="local.str">
<cfoutput><link rel="stylesheet" href="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/admin/assets/css/custom-theme/jquery-ui-1.8.custom.css" type="text/css" media="all">
<link rel="stylesheet" href="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/admin/assets/css/custom-theme/jquery-ui-custom.css" type="text/css" media="all">
<script src="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/admin/assets/js/jquery-ui-1.8.custom.min.js" type="text/javascript"></script></cfoutput>
</cfsavecontent>
<cfset arrayPrepend( rc.headLoader,local.str )>
</cfsilent>
