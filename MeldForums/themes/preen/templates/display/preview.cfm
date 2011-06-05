<cfoutput>
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<link rel="stylesheet" href="#rc.themeDirectory#assets/css/base.css" type="text/css" media="all">
	</head>
	<body>
	<div class="meld-forums preview">
	<table class="mf-post-block">
		<tr class="mf-post-contents">
			<td class="mf-content">
				<div class="message preview">
				<cfif isDefined("form.data") and len(form.data)><cfmodule template="/#rc.pluginConfig.getPackage()#/includes/utilities/parseBBML.cfm" ConvertSmilies="false">#trim(rereplace(replacelist(form.data,"<,>","&lt;,&gt;"),"
					|\n","#chr(13)##chr(10)#","all"))#</cfmodule><cfelse>#rc.mmRBF.key('preview_empty')#</cfif>
				</div>
			</td>
		</tr>
	</table>
	</div>
	</body>
	</html>
	<cfset request.layout = false>
</cfoutput>