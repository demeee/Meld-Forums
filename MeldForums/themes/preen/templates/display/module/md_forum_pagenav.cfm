<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<!---<cfset attributes.user = attributes.userCache.getUser( attributes.threadbean.getUserID() )>--->
</cfsilent><cfoutput>
<table class="mf-paging">
	<tr>
		<td class="mf-paging-pages">
			#rc.pagebean.getNav()#
		</td>
	<cfif not isSimpleValue(rc.MFBean)>
		<td class="mf-buttonbar-right">
			<div>
			<!---#rc.MFBean.getForumSubscribeLink(rc.forumbean,"forum",rc.isSubscribed )#--->
			#rc.MFBean.getNewThreadLink(rc.forumbean)#
			</div>
		</td>
	</cfif>

	</tr>
</table>
</cfoutput>