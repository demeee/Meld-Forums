<cfsilent>
	<cfset attributes.rc = rc />
	<cfparam name="attributes.class" default="">
</cfsilent><cfoutput>
<div class="pagingblock clearfix #attributes.class#">
	<div class="paging">
		<div class="pageof"><ul class="navlist"><li>#attributes.rc.mmRBF.key('page')# #attributes.rc.pageBean.getPage()# #attributes.rc.mmRBF.key('of')# #attributes.rc.pageBean.getPageLimit()#</li></ul></div>
		<div class="back">#attributes.rc.pageBean.getBack()#</div>
		<div class="nav">#attributes.rc.pageBean.getNav()#</div>
		<div class="next">#attributes.rc.pageBean.getNext()#</div>
	</div>
	<div class="links">
		#attributes.rc.meldForumsBean.getForumSubscribeLink(attributes.rc.forumbean,"forum",attributes.rc.isSubscribed )#
		#attributes.rc.meldForumsBean.getNewThreadLink(attributes.rc.forumbean)#
	</div>
</div>
</cfoutput>
