<cfsilent>
	<cfset local.profileUserBean = rc.profileUserBean />
</cfsilent>
<cfoutput>
	<cfmodule template="module/services_panel.cfm" local="#local#">
	<div id="profile" class="profileblock">
		<cfmodule template="module/profile_view.cfm" profileUserBean="#local.profileUserBean#" externalUserBean="#local.profileUserBean.getExternalUserBean()#" local="#local#">
	</div>
</cfoutput>