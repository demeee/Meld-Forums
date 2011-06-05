<cfsilent>
	<cfset attributes.rc		= rc />
	<cfset attributes.user		= attributes.rc.MeldForumsBean.getUser( attributes.threadBean.getAdminID() )>
</cfsilent><cfoutput>
<table class="mf-post-block adminblock">
	<tr class="mf-post-info adminheading">
		<td class="mf-avatar">
			<cfif len( attributes.user.getAvatarID() )>
			<a href="#attributes.rc.meldForumsBean.getForumWebRoot()#viewprofile/#attributes.user.getUserID()#/"><img src="#attributes.rc.pluginConfig.getConfigBean().getContext()#/tasks/render/small/?fileID=#attributes.user.getAvatarID()#"
				class="avatar"
				alt="#attributes.user.getScreenName()# #attributes.rc.mmRBF.key('avatar')#" border="0"/></a>
			<cfelse><a href="#attributes.rc.meldForumsBean.getForumWebRoot()#viewprofile/#attributes.user.getUserID()#/"><img src="#attributes.rc.pluginConfig.getConfigBean().getContext()#/tasks/render/small/?fileID=#attributes.rc.MeldForumsBean.getValue("settingsBean").getAvatarID()#"
				class="avatar"
				alt="#attributes.rc.mmRBF.key('avatar')#"  border="0"/></a></cfif>
		</td>
		<td class="mf-info">
			<div class="col2 clearfix top">
				<div class="name colLeft">
					<h4><a href="#attributes.rc.meldForumsBean.getForumWebRoot()#viewprofile/#attributes.user.getUserID()#/">#attributes.user.getScreenName()#</a></h4>
				</div>
				<div class="date colRight">
				</div>
			</div>
			<div class="col2 clearfix">
				<div class="count colLeft">
					#attributes.user.getPostCounter()# #attributes.rc.mmRBF.key('postcount')#
				</div>
				<div class="status colRight">
					<cfif attributes.rc.MeldForumsBean.getUserCache().IsOnline( attributes.user.getUserID() )>#attributes.rc.mmRBF.key('online')#<cfelse>#attributes.rc.mmRBF.key('offline')#</cfif>
				</div>
			</div>
		</td>
	</tr>
	<tr class="mf-post-contents">
		<td class="mf-content" colspan="2">
			<div class="message">
				<cfmodule template="/plugins/#attributes.rc.pluginConfig.getDirectory()#/includes/utilities/parseBBML.cfm" ConvertSmilies="false">#attributes.threadbean.getAdminMessage()#</cfmodule>
			</div>
		</td>
	</tr>
</table>
</cfoutput>