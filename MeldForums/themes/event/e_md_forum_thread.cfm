<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 

<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
<cfset local.event.setValue('threadBean',local.threadBean) />
<cfset local.event.setValue('context',"thread" ) />

<cfset local.eventContent['forumthread'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumThreadRender",local.event ) />

<cfif not len(local.eventContent['forumthread'])>
	<cfset local.eventContent['forumthreadicon'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumThreadIconRender",local.event ) />
	<cfset local.eventContent['forumthreadbody'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumThreadBodyRender",local.event ) />
	<cfset local.eventContent['forumthreadbodyextra'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumThreadBodyExtraRender",local.event ) />
	<cfset local.eventContent['forumthreadstats'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumThreadStatsRender",local.event ) />
	<cfset local.eventContent['forumthreadlastpost'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumThreadLastPostRender",local.event ) />
</cfif>

</cfsilent>