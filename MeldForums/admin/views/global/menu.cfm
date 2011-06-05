<!---
||MELDFORUMSLICENSE||
--->
<cfoutput>
<ul id="meld-nav-main">
	<li class="first"><a href="?">#rc.mmRBF.key('dashboard')#</a></li>
	<li class="first"><a href="?action=admin:conferences">#rc.mmRBF.key('conferences')#</a></li>
	<li class="first"><a href="?action=admin:forums">#rc.mmRBF.key('forums')#</a></li>
	<li class="first"><a href="?action=admin:users">#rc.mmRBF.key('users')#</a></li>
	<li class="settings">
		<a title="#rc.mmRBF.key('settings')#" href="?action=admin:settings">#rc.mmRBF.key('settings')#</a>
		<ul>
			<li class="first"><a href="?action=admin:settings">#rc.mmRBF.key('settings')#</a></li>
			<li class="last"><a href="?action=admin:configurations">#rc.mmRBF.key('configurations')#</a></li>
		</ul>
	</li>
	<li class="about">
		<a title="#rc.mmRBF.key('About')#" href="?action=admin:about">#rc.mmRBF.key('About')#</a>
		<ul>
			<li class="first"><a href="?action=admin:about">#rc.mmRBF.key('About')#</a></li>
			<li><a href="?action=admin:about.documentation">#rc.mmRBF.key('Documentation')#</a></li>
			<li><a href="?action=admin:about.support">#rc.mmRBF.key('Support')#</a></li>
			<li class="last"><a href="?action=admin:about.license">#rc.mmRBF.key('license')#</a></li>
		</ul>
	</li>
</ul>

</cfoutput>