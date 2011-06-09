<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('threadBean',rc.threadBean) />
<cfset local.event.setValue('userBean',local.UserBean ) />
<cfset local.event.setValue('avatarSize',"small" ) />
<cfset local.event.setValue('context',"adminmessage" ) />

<cfset local.eventContent['threadadminmessage'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadAdminMessageRender",local.event ) />
<cfif not len(local.eventContent['threadadminmessage'])>
	<cfset local.eventContent['avatar'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsAvatarRender",local.event ) />
	<cfset local.eventContent['adminmessageinfo'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadAdminMessageInformationRender",local.event ) />

	<cfset local.eventContent['adminmessageinfo'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadAdminMessageInformationRender",local.event ) />
	<cfset local.eventContent['adminmessagemessage'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadAdminMessageMessageRender",local.event ) />
</cfif>
</cfsilent>