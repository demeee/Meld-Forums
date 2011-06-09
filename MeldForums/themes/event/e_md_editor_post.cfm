<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('postBean',rc.postBean) />
<cfset local.event.setValue('context',"post" ) />

<cfset local.eventContent['editor'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsEditPostRender",local.event ) />
<cfif not len(local.eventContent['editor'])>
	<cfset local.eventContent['fields'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsEditPostFieldsRender",local.event ) />
</cfif>
</cfsilent>