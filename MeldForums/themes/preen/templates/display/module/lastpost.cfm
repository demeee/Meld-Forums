<cfsilent>
	<cfset rc = attributes.rc />
	<cfset local = StructNew() />
	<cfset attributes.user = rc.MeldForumsBean.getUser( attributes.postbean.getUserID() )>

	<cfparam name="attributes.showPostTitle" default="true">
</cfsilent><cfoutput>
		<ul class="meta">
			<cfif attributes.showPostTitle><li><a href="#rc.meldForumsBean.getForumWebRoot()#viewthread/#attributes.postbean.getThreadID()#/?pp=#attributes.postbean.getPostPosition()###p#attributes.postbean.getPostPosition()#">#left(attributes.postbean.getTitle(),35)##iif(len(attributes.postbean.getTitle()) gt 35,de("..."),de(""))#</a></li></cfif>
			<li>#lsDateFormat(attributes.postbean.getDateLastUpdate(),session.datekeyformat)# #lsTimeFormat(attributes.postbean.getDateLastUpdate(),"short")# <a title="#rc.mmRBF.key('viewpost')#" href="#rc.meldForumsBean.getForumWebRoot()#viewthread/#attributes.postbean.getThreadID()#/?pp=#attributes.postbean.getPostPosition()###p#attributes.postbean.getPostPosition()#">&raquo;&raquo;</a></li>
			<li><span class="heading">#rc.mmRBF.key('author')#:</span>
				<cfif attributes.user.beanExists()><a href="#rc.meldForumsBean.getForumWebRoot()#viewprofile/#attributes.user.getUserID()#/">#attributes.user.getScreenName()#</a>
				<cfelse>#rc.mmRBF.key('nulluser')#</cfif>
			</li>
		</ul>
</cfoutput>