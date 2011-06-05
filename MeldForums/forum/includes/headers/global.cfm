<cfset var="#rc.$.getContentRenderer().loadJSLib()#">
<cfsilent>
<cfsavecontent variable="local.str"><cfoutput>
<link rel="stylesheet" href="#rc.MFBean.getPluginWebRoot()#/forum/assets/css/base.css" type="text/css" media="screen" />
<link rel="stylesheet" href="#rc.MFBean.getThemeWebRoot()#/assets/css/forums.css" type="text/css" media="screen" />
</cfoutput>
</cfsavecontent>
<cfset arrayPrepend( rc.headLoader,local.str )>
</cfsilent>	