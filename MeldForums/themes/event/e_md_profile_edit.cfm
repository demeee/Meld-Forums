<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 

<cfset local.event.setValue('context',local.context ) />
<cfset local.event.setValue('data',local ) />

<cfset local.eventContent['profilebuttonbarupperleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsProfileButtonbarULRender",local.event ) />
<cfset local.eventContent['profilebuttonbarupperright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsProfileButtonbarURRender",local.event ) />
<cfset local.eventContent['profilefooter'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPageFooterRender",local.event ) />
<cfset local.eventContent['profilebuttonbarlowerleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsProfileButtonbarLLRender",local.event ) />
<cfset local.eventContent['profilebuttonbarlowerright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsProfileButtonbarLRRender",local.event ) />
</cfsilent>
