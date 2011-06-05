<cfsilent>
	<cfset rc = attributes.local.rc />
	<cfset local = StructNew() />

</cfsilent><cfoutput>
<table class="mf-buttonbar mf-buttonbar-forum">
	<tr>
		<td class="mf-buttonbar-left">
		</td>
		<td class="mf-buttonbar-right">
			<cfif not isSimpleValue(rc.MFBean)>
				<!---#rc.MFBean.getThreadSubscribeLink(rc.threadbean,"thread", rc.isSubscribed )#--->
				<div>
				#rc.MFBean.getNewPostLink( rc.threadbean )#
				#rc.MFBean.getEditThreadLink( rc.threadbean )#
				</div>
			</cfif>
		</td>
	</tr>
</table>
</cfoutput>