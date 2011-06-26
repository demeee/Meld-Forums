<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
		
</cfsilent>
<cfoutput>
	<ul id="mf-profile-panel-nav">
		<li><a class="submit<cfif rc.panel eq ''> current</cfif>" href="./">#rc.mmRBF.key('overview')#</a></li>		
		<li><a class="submit<cfif rc.panel eq 'profile'> current</cfif>" href="?panel=settings">#rc.mmRBF.key('profile')#</a></li>		
		<li><a class="submit<cfif rc.panel eq 'avatar'> current</cfif>" href="?panel=avatar">#rc.mmRBF.key('avatar')#</a></li>		
		<li><a class="submit<cfif rc.panel eq 'privacy'> current</cfif>" href="?panel=privacy">#rc.mmRBF.key('privacy')#</a></li>		
		<li><a class="submit<cfif rc.panel eq 'subscriptions'> current</cfif>" href="?panel=subscriptions">#rc.mmRBF.key('subscriptions')#</a></li>		
		#rc.panelMenu#		
		<cfif rc.MFBean.userHasModeratePermissions(rc.userID)>
			<li><a class="submit<cfif rc.panel eq 'moderate'> current</cfif>" href="?panel=moderate">#rc.mmRBF.key('moderate')#</a></li>
		</cfif>
	</ul>
</cfoutput>