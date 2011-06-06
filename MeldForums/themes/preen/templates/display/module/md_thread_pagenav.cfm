<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<!---<cfset attributes.user = attributes.userCache.getUser( attributes.threadbean.getUserID() )>--->
</cfsilent><cfoutput>
<table class="pagingblock">
	<tr>
		<td class="paging">
			#rc.pagebean.getNav()#
		</td>
	<cfif not isSimpleValue(attributes.rc.MeldForumsBean)>
		<td class="servicelinks">
			#attributes.rc.MeldForumsBean.getThreadSubscribeLink(attributes.rc.threadbean,"thread", attributes.rc.isSubscribed )#
			#attributes.rc.MeldForumsBean.getNewPostLink(attributes.rc.threadbean)#
			#attributes.rc.MeldForumsBean.getEditThreadLink(attributes.rc.threadbean)#
		</td>
	</cfif>
	</tr>
</table>
</cfoutput>