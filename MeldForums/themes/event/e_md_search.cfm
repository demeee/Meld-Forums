<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('columnsNew',0) />
<cfset local.event.setValue('context',"search" ) />

<cfset local.eventContent['searchheader'] = rc.mmEvents.renderEvent( rc.$,"onMeldsearchssearchHeaderRender",local.event ) />
<cfif not len(local.eventContent['searchheader'])>
	<cfset local.eventContent['searchcolumns'] = rc.mmEvents.renderEvent( rc.$,"onMeldsearchssearchColumnsRender",local.event ) />
</cfif>

<cfset local.columns = iif( local.event.getValue('columnsNew') gt 0,de(local.event.getValue('columnsNew')),de(5) ) />
</cfsilent>