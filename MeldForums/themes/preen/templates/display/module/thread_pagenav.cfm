<cfsilent>
	<cfset attributes.rc = rc />
	<!---<cfset attributes.user = attributes.userCache.getUser( attributes.threadbean.getUserID() )>--->
</cfsilent><cfoutput>
<table class="pagingblock">
	<tr>
		<td class="paging">
			<div class="pageof"><ul class="navlist"><li>#attributes.rc.mmRBF.key('page')# #attributes.rc.pageBean.getPage()# #attributes.rc.mmRBF.key('of')# #attributes.rc.pageBean.getPageLimit()#</li></ul></div>
			<div class="back">#attributes.rc.pageBean.getBack()#</div>
			<div class="nav">#attributes.rc.pageBean.getNav()#</div>
			<div class="next">#attributes.rc.pageBean.getNext()#</div>
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