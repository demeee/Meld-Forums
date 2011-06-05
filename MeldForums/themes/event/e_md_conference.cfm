<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('conferenceBean',local.conferenceBean) />
<cfset local.event.setValue('columnsNew',0) />
<cfset local.event.setValue('context',"conference" ) />

<cfset local.eventContent['conference'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceRender",local.event ) />
<cfif not len(local.eventContent['conference'])>
	<cfset local.eventContent['description'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceDescriptionRender",local.event ) />
	<cfset local.eventContent['columns'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceColumnsRender",local.event ) />
</cfif>

<cfset local.columns = iif( local.event.getValue('columnsNew') gt 0,de(local.event.getValue('columnsNew')),de(6) ) />
</cfsilent>