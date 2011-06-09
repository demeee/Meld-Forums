<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
<cfset local.event.setValue('context',"thread" ) />

<cfset local.eventContent['forumannouncement'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumAnnouncementRender",local.event ) />
<cfif not len(local.eventContent['forumannouncement'])>
	<cfset local.eventContent['forumannouncementicon'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumAnnouncementIconRender",local.event ) />
	<cfset local.eventContent['forumannouncementbody'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumAnnouncementBodyRender",local.event ) />
	<cfset local.eventContent['forumannouncementstats'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumAnnouncementStatsRender",local.event ) />
	<cfset local.eventContent['forumannouncementlastpost'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumAnnouncementLastPostRender",local.event ) />
</cfif>

</cfsilent>