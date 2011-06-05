<cfsilent>
	<cfset local.rc = rc>
</cfsilent><cfoutput>
<ul class="meld-nav-secondary">
	<li>
		<a href="?action=forums.edit<cfif len(rc.conferenceID)>&conferenceID=#rc.conferenceID#</cfif>" title="#local.rc.mmRBF.key('addnewforum','tip')#">#local.rc.mmRBF.key('addnewforum')#</a>				
	</li>
</ul>
</cfoutput>