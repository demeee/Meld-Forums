<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('forumBean',local.forumBean) />
<cfset local.event.setValue('columnsNew',0) />
<cfset local.event.setValue('context',"announcement" ) />

<cfset local.eventContent['announcementheader'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsAnnouncementHeaderRender",local.event ) />
<cfif not len(local.eventContent['announcementheader'])>
	<cfset local.eventContent['announcementdescription'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsAnnouncementDescriptionRender",local.event ) />
	<cfset local.eventContent['announcementcolumns'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsAnnouncementColumnsRender",local.event ) />
</cfif>

<cfset local.columns = iif( local.event.getValue('columnsNew') gt 0,de(local.event.getValue('columnsNew')),de(5) ) />
</cfsilent>