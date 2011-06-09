<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('threadBean',rc.threadBean) />
<cfset local.event.setValue('context',"thread" ) />

<cfset local.eventContent['editor'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsEditThreadRender",local.event ) />
<cfif not len(local.eventContent['editor'])>
	<cfset local.eventContent['fields'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsEditThreadFieldsRender",local.event ) />
</cfif>
</cfsilent>