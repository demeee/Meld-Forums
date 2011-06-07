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
			<!---#attributes.rc.MeldForumsBean.getThreadSubscribeLink(rc.threadbean,"thread", rc.isSubscribed )#--->
			<div>
			#rc.MFBean.getNewPostLink(rc.threadbean)#
			#rc.MFBean.getEditThreadLink(rc.threadbean)#
			</div>
		</td>
	</cfif>
	</tr>
</table>
</cfoutput>