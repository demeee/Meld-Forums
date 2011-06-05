<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
<div>
	<dl class="oneColumn">
	<h4>#local.rc.mmRBF.key('general')#</h4>
	<ul class="metadata">
		<li>#local.rc.mmRBF.key('threadsperpage')#: <strong>#local.rc.settingsBean.getThreadsPerPage()#</strong></li>
		<li>#local.rc.mmRBF.key('postsperpage')#: <strong>#local.rc.settingsBean.getPostsPerPage()#</strong></li>
		<li>#local.rc.mmRBF.key('searchmode')#: <strong>#local.rc.settingsBean.getSearchMode()#</strong></li>
		<li>#local.rc.mmRBF.key('usercachesize')#: <strong>#local.rc.settingsBean.getuserCacheSize()#</strong></li>
	</ul>
	</dl>
	<dl class="oneColumn">
	<h4>#local.rc.mmRBF.key('permissions')#</h4>
	<ul class="metadata">
		<li>#local.rc.mmRBF.key('settingspermissions')#: <strong>#local.rc.settingsBean.getPermissionGroups()#</strong></li>
	</ul>
	</dl>
	<dl class="oneColumn">
	<h4>#local.rc.mmRBF.key('files')#</h4>
	<ul class="metadata">
		<li>#local.rc.mmRBF.key('filesizelimit')#: <strong>#local.rc.settingsBean.getFileSizeLimit()#</strong></li>
		<li>#local.rc.mmRBF.key('tempdir')#: <strong>#local.rc.settingsBean.getTempDir()#</strong></li>
		<li>#local.rc.mmRBF.key('basetempdir')#: <strong>#local.rc.settingsBean.getBaseTempDir()#</strong></li>
		<li>#local.rc.mmRBF.key('allowedextensions')#: <strong>#replace(local.rc.settingsBean.getAllowedExtensions(),",",", ","all")#</strong></li>		
	</ul>
	</dl>
	<dl class="oneColumn">
	<h4>#local.rc.mmRBF.key('avatar')#</h4>
	<ul class="metadata">
		<li>#local.rc.mmRBF.key('avatarresizetype')#: <strong>#local.rc.settingsBean.getAvatarResizeType()#</strong></li>
		<li>#local.rc.mmRBF.key('avatarqualitytype')#: <strong>#local.rc.settingsBean.getAvatarQualityType()#</strong></li>
		<li>#local.rc.mmRBF.key('avataraspecttype')#: <strong>#local.rc.settingsBean.getAvatarAspectType()#</strong></li>
		<li>#local.rc.mmRBF.key('avatarcroptype')#: <strong>#local.rc.settingsBean.getAvatarCropType()#</strong></li>
	</ul>
	</dl>
</div>
</cfoutput>