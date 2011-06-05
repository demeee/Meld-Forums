<!---
||MELDFORUMSLICENSE||
--->
<cfsilent>
	<!--- headers --->
</cfsilent><cfoutput>
<div id="meld-plugin">
	<div id="meld-content">
		<div id="meld-bc" class="clearfix">
			#view("/global/bc")#
		</div>
		<div id="meld-logo" class="clearfix">
			<a href="http://www.meldsolutions.com" target="_new"></a>
		</div>
		<div id="meld-nav" class="clearfix">
			#view("/global/menu")#
		</div>
		<!--- error template --->
		<cfif structKeyExists(local.rc,"error")>
		<div id="meld-error" class="section clearfix">
			#view("/global/error")#
		</div>
		</cfif>
		#body#
	</div>
</div>
</cfoutput>