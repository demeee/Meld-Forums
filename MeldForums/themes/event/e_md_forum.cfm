<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('forumBean',local.forumBean) />
<cfset local.event.setValue('columnsNew',0) />
<cfset local.event.setValue('context',"forum" ) />

<cfset local.eventContent['forumheader'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumHeaderRender",local.event ) />
<cfif not len(local.eventContent['forumheader'])>
	<cfset local.eventContent['forumdescription'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumDescriptionRender",local.event ) />
	<cfset local.eventContent['forumcolumns'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsForumColumnsRender",local.event ) />
</cfif>

<cfset local.columns = iif( local.event.getValue('columnsNew') gt 0,de(local.event.getValue('columnsNew')),de(5) ) />
</cfsilent>