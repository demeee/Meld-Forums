<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('postBean',local.postBean) />
<cfset local.event.setValue('userBean',local.PostUserBean ) />
<cfset local.event.setValue('avatarSize',"small" ) />
<cfset local.event.setValue('context',"post" ) />

<cfset local.eventContent['threadpost'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostRender",local.event ) />
<cfif not len(local.eventContent['threadpost'])>
	<cfset local.eventContent['avatar'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsAvatarRender",local.event ) />
	<cfset local.eventContent['postinfo'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostInformationRender",local.event ) />

	<cfset local.eventContent['postinfo'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostInformationRender",local.event ) />
	<cfset local.eventContent['postdisabled'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostDisabledRender",local.event ) />
	<cfset local.eventContent['postmessage'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostMessageRender",local.event ) />
	<cfset local.eventContent['postupdated'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostUpdatedRender",local.event ) />
	<cfset local.eventContent['postmoderated'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostModeratedRender",local.event ) />
	<cfset local.eventContent['postsignature'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostSignatureRender",local.event ) />
	<cfif len( local.postBean.getAttachmentID() )>
		<cfset local.eventContent['postattachment'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostAttachmentRender",local.event ) />
	</cfif>

	<cfset local.eventContent['postposition'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostPositionRender",local.event ) />
	<cfset local.eventContent['postbuttonbarupperleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostButtonBarULRender",local.event ) />
	<cfset local.eventContent['postbuttonbarupperright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostButtonBarURRender",local.event ) />
	<cfset local.eventContent['postbuttonbarlowerleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostButtonBarLLRender",local.event ) />
	<cfset local.eventContent['postbuttonbarlowerright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostButtonBarLRRender",local.event ) />
</cfif>
</cfsilent>