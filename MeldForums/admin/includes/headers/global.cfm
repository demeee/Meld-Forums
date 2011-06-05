<!---
||MELDFORUMSLICENSE||
--->
<cfsilent>
<cfsavecontent variable="local.str">
<cfoutput><link rel="stylesheet" href="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/admin/assets/css/admin.css" type="text/css" media="all" />
<script src="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/admin/assets/js/admin.js" type="text/javascript" language="Javascript"></script></cfoutput>
</cfsavecontent>
<cfset arrayPrepend( rc.headLoader,local.str )>
</cfsilent>