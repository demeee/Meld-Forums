<cfset var="#rc.$.getContentRenderer().loadJSLib()#">
<cfsilent>
<cfsavecontent variable="local.str"><cfoutput>
<script type="text/javascript" src="#rc.MFBean.getPluginWebRoot()#/editor/markitup/jquery.markitup.js"></script>
<script type="text/javascript" src="#rc.MFBean.getPluginWebRoot()#/editor/markitup/sets/bbcode/set.js"></script>
<link rel="stylesheet" type="text/css" href="#rc.MFBean.getPluginWebRoot()#/editor/markitup/skins/markitup/style.css" />
<link rel="stylesheet" type="text/css" href="#rc.MFBean.getPluginWebRoot()#/editor/markitup/sets/bbcode/style.css" />
</cfoutput>
</cfsavecontent>
<cfset arrayPrepend( rc.headLoader,local.str )>
</cfsilent>
