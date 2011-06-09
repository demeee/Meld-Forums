<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('threadBean',local.threadBean) />
<cfset local.event.setValue('context',"thread" ) />

<cfset local.eventContent['threadheader'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadHeaderRender",local.event ) />
<cfif not len(local.eventContent['threadheader'])>
	<cfset local.eventContent['threaddescription'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadDescriptionRender",local.event ) />
	<cfset local.eventContent['threadadminmessage'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadAdministratorMessageRender",local.event ) />
	<cfset local.eventContent['threadclosed'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadClosedRender",local.event ) />
</cfif>
</cfsilent>