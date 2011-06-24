<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
		
</cfsilent>
<cfoutput>
<cfif attributes.userBean.getExternalUserBean().getInActive()>
<div class="columns2 mf-profile clearfix">
	<div class="attention"><h4>#rc.mmRBF.key('disabledbyadministrator')#</h4></div>
</div>
</cfif>
<cfif not attributes.userBean.getExternalUserBean().getInActive() or rc.MFBean.userHasFullPermissions()>

</cfif>

</cfoutput>