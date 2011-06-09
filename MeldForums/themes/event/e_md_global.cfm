<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 

<cfset local.event.setValue('context',local.context ) />
<cfset local.event.setValue('data',local ) />

<cfset local.eventContent['searchform'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsSearchRender",local.event ) />
<cfset local.eventContent['pageheader'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPageHeaderRender",local.event ) />
<cfset local.eventContent['pagebuttonbarupperleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPageButtonbarUpperLeftRender",local.event ) />
<cfset local.eventContent['pagebuttonbarupperright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPageButtonbarUpperRightRender",local.event ) />
<cfset local.eventContent['pagefooter'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPageFooterRender",local.event ) />
<cfset local.eventContent['pagebuttonbarlowerleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPageButtonbarLowerLeftRender",local.event ) />
<cfset local.eventContent['pagebuttonbarlowerright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPageButtonbarLowerRightRender",local.event ) />
</cfsilent>
