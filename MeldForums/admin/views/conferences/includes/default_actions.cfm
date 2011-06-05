<!---
||MELDGALLERYLICENSE||
--->
<cfsilent>
	<cfset local.rc = rc>
</cfsilent><cfoutput>
<ul class="meld-nav-secondary">
	<li>
		<a href="?action=admin:conferences.edit" title="#local.rc.mmRBF.key('addnewconference','tip')#">#local.rc.mmRBF.key('addnewconference')#</a>				
	</li>
</ul>
</cfoutput>