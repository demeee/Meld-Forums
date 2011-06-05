<cfsilent>
	<cfset rc = attributes.local.rc />
	<cfset local = StructNew() />

</cfsilent><cfoutput>
<table class="mf-buttonbar mf-buttonbar-forum">
	<tr class="mf-buttonbars">
		<td class="mf-buttonbar-left">
			<div></div>
		</td>
		<td class="mf-buttonbar-right">
			<div>
			<!---#rc.MFBean.getForumSubscribeLink(attributes.rc.forumbean,"forum",attributes.rc.isSubscribed )#--->
			#rc.MFBean.getNewThreadLink( rc.forumbean )#
			</div>
		</td>
	</tr>
</table>
</cfoutput>