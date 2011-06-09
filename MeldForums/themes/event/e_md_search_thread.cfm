<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 

<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
<cfset local.event.setValue('threadBean',local.threadBean) />
<cfset local.event.setValue('context',"thread" ) />

<cfset local.eventContent['searchthread'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsSearchThreadRender",local.event ) />

<cfif not len(local.eventContent['searchthread'])>
	<cfset local.eventContent['searchthreadicon'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsSearchThreadIconRender",local.event ) />
	<cfset local.eventContent['searchthreadbody'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsSearchThreadBodyRender",local.event ) />
	<cfset local.eventContent['searchthreadbodyextra'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsSearchThreadBodyExtraRender",local.event ) />
	<cfset local.eventContent['searchthreadstats'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsSearchThreadStatsRender",local.event ) />
	<cfset local.eventContent['searchthreadlastpost'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsSearchThreadLastPostRender",local.event ) />
</cfif>

</cfsilent>