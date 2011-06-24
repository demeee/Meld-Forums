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
<div class="columns2 mf-profile clearfix">
	<div class="col">
		<div id="personal" class="clearfix">
			<h3>#rc.mmRBF.key('aboutmember')# #attributes.userBean.getScreenName()#</h3>
			<dl class="profile">
				<cfif not isSimpleValue(attributes.userBean.getExternalUserBean())>
					<cfif not attributes.userBean.getIsPrivate()>
						<dt>#rc.mmRBF.key('user.name','mura')#:</dt>
						<dd>#attributes.userBean.getExternalUserBean().getFName()# #attributes.userBean.getExternalUserBean().getLName()#</dd>
						<cfif attributes.userBean.getExternalUserBean().getAddresses().recordCount>
							<cfset attributes.qAddress = attributes.userBean.getExternalUserBean().getAddresses()>
							<cfif len(attributes.qAddress.city[1])>
							<dt>#rc.mmRBF.key('location')#:</dt>
							<dd>#attributes.qAddress.city[1]#, #attributes.qAddress.state[1]#,  #attributes.qAddress.country[1]#</dd>
							</cfif>
							<dt>#rc.mmRBF.key('params.imservice')#:</dt>
							<dd>#attributes.userBean.getExternalUserBean().getimservice()# <cfif len(attributes.userBean.getExternalUserBean().getimname())>: #attributes.userBean.getExternalUserBean().getimname()#</cfif></dd>
						</cfif>
					</cfif>
				<dt>#rc.mmRBF.key('user.company','mura')#:</dt>
				<dd>#attributes.userBean.getExternalUserBean().getCompany()#</dd>
				<dt>#rc.mmRBF.key('user.jobtitle','mura')#:</dt>
				<dd>#attributes.userBean.getExternalUserBean().getJobTitle()#</dd>
				<cfif attributes.userBean.getIsConfirmed()>
				<dt>#rc.mmRBF.key('user.website','mura')#:</dt>
				<dd>#attributes.userBean.getExternalUserBean().getWebsite()#</dd>
				</cfif>
				<dt>#rc.mmRBF.key('user.interests','mura')#:</dt>
				<dd>#replace(attributes.userBean.getExternalUserBean().getInterests(),",",", ","all")#</dd>
			</dl>
			</cfif>
		</div>
	</div>
	<div class="col">
		<div class="avatarFull clearfix">
			<!---
			<cfif len(attributes.userBean.getAvatarID() )>
			<img src="#rc.MFBean.getSiteWebRoot()#/tasks/render/medium/?fileID=#attributes.userBean.getAvatarID()#"
				class="avatar" alt="#rc.mmRBF.key('avatar')#" />
			<cfelse>
			<img src="#rc.MFBean.getSiteWebRoot()#/tasks/render/medium/?fileID=#attributes.settingsBean.getAvatarID()#"
				class="avatar" alt="#rc.mmRBF.key('avatar')#" />
			</cfif>
			--->
		</div>	
	</div>
</div>
<div class="columns2 mf-profile clearfix">
	<div class="col">
		<div id="account" class="clearfix">
			<h3>#rc.mmRBF.key('status')#</h3>
			<dl class="profile">
				<dt>#rc.mmRBF.key('datejoined')#:</dt>
				<dd>#lsDateFormat(attributes.userBean.getDateCreate(),session.datekeyformat)#</dd>
				<dt>#rc.mmRBF.key('datelastlogin')#:</dt>
				<dd>#lsDateFormat(attributes.userBean.getDateLastLogin(),session.datekeyformat)#</dd>
				<dt>#rc.mmRBF.key('status')#:</dt>
				<dd><cfif rc.MFBean.getUserCache().IsOnline( attributes.userBean.getUserID() )>#rc.mmRBF.key('online')#<cfelse>#rc.mmRBF.key('offline')#</cfif></dd>
			</dl>
		</div>
	</div>
	<div class="col">
		<div id="statistics" class="clearfix">
			<h3>#rc.mmRBF.key('statistics')#</h3>
			<dl class="profile">
				<dt>#rc.mmRBF.key('postcount')#:</dt>
				<dd>#attributes.userBean.getPostCounter()#</dd>
				<dt>#rc.mmRBF.key('threadcount')#:</dt>
				<dd>#attributes.userBean.getThreadCounter()#</dd>
			<cfif not isSimpleValue(attributes.userBean.getThread())>
				<dt>#rc.mmRBF.key('lastThread')#:</dt>
				<dd><a href="#rc.MFBean.getThreadLink( attributes.userBean.getThread() )#/">#lsDateFormat( attributes.userBean.getThread().getDateCreate() ,session.datekeyformat)#, #lsTimeFormat( attributes.userBean.getThread().getDateCreate(),"short")#</a></dd>
			</cfif>
			<cfif not isSimpleValue(attributes.userBean.getPost())>
				<dt>#rc.mmRBF.key('lastpost')#:</dt>
				<dd><a href="#rc.MFBean.getLastPostLink( attributes.userBean.getPost() )#">#lsDateFormat( attributes.userBean.getPost().getDateCreate() ,session.datekeyformat)#, #lsTimeFormat( attributes.userBean.getPost().getDateCreate(),"short")#</a></dd>
			</cfif>
			</dl>
		</div>
	</div>
</div>
</cfif>
<table class="mf-page-block mf-buttonbar">
	<tr class="mf-page-actionbar">
		<td class="mf-buttonbar-left mf-buttonbar-lower" colspan="2">
		<div>
		<cfif rc.MFBean.UserHasFullPermissions()>
			#rc.MFBean.getModerateProfileButton(attributes.userBean.getUserID())#
		</cfif>
		<cfif len( local.eventContent['profilebuttonbarlowerleft'] )>
			#local.eventContent['profilebuttonbarlowerleft']#
		</cfif>
		</div>
		</td>
		<td class="mf-buttonbar-right mf-buttonbar-lower">
		<div>
		<cfif len( local.eventContent['profilebuttonbarlowerright'] )>
			#local.eventContent['profilebuttonbarlowerright']#
		</cfif>
		</div>
		</td>
	</tr>
</table>
</cfoutput>