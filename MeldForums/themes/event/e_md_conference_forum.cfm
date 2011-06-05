<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
<cfset local.event.setValue('forumBean',local.forumBean) />
<cfset local.event.setValue('context',"forum" ) />

<cfset local.eventContent['conferenceforum'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceForumRender",local.event ) />
<cfif not len(local.eventContent['conferenceforum'])>
	<cfset local.eventContent['conferenceforumicon'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceForumIconRender",local.event ) />
	<cfset local.eventContent['conferenceforumheading'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceForumHeadingRender",local.event ) />
	<cfset local.eventContent['conferenceforumcolumns'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceForumColumnsRender",local.event ) />
	<cfset local.eventContent['conferenceforumlastpost'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceForumLastPostRender",local.event ) />
</cfif>

</cfsilent>