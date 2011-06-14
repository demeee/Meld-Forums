<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetConferences( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doGetConferences" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var forumService			= getBeanFactory().getBean("forumService") />
		<cfset var qConferenceTree		= "" />
		<cfset var aConferences			= ArrayNew(1) />
		<cfset var aForums				= ArrayNew(1) />
		<cfset var aForumSet			= ArrayNew(1) />
		<cfset var iiX					= "" />
		<cfset var sArgs				= StructNew() />
		<cfset var pluginEvent 			= createEvent(rc) />
		<cfset var idx					= 0 />

		<cfif len( rc.meldForumsBean.getIdent() )>
			<cfset idx = rereplace( rc.meldForumsBean.getIdent(),"[^\d]","","all" ) />
		</cfif>
		<!--- friendlyname ident --->
		<cfif len( rc.meldForumsBean.getIdent() ) and isNumeric(idx) >
			<cfset pluginEvent.setValue("ident",rc.meldForumsBean.getIdent() ) />
			<cfset pluginEvent.setValue("idx",idx ) />
			<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>

			<cfif pluginEvent.valueExists('aConferences')>
				<cfset aConferences	= pluginEvent.getValue('aConferences') />
			<cfelse>
				<cfset sArgs.idx = idx />
				<cfset sArgs.isActive = 1 />
				<cfset sArgs.doForums = 1 />
				<cfset sArgs.siteID = rc.siteID />
				<cfif StructKeyExists(rc.params,"conferenceID") and len( rc.params.conferenceID )>
					<cfset sArgs.conferenceID = conferenceID />
				</cfif>

				<cfset aConferences	= conferenceService.getConferences( argumentCollection=sArgs ) />
			</cfif>
		<cfelseif StructKeyExists(rc,"params")>
			<!--- id array --->
			<cfif StructKeyExists(rc.params,"conferenceIDList") and len( rc.params.conferenceIDList )>

				<cfset pluginEvent.setValue("conferenceIDList",rc.params.conferenceIDList) />
				<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>

				<cfif pluginEvent.valueExists('aConferences')>
					<cfset aConferences	= pluginEvent.getValue('aConferences') />
				<cfelse>
					<cfset sArgs.idList = rc.params.conferenceIDList />
					<cfset sArgs.isActive = 1 />
					<cfset sArgs.doForums = 1 />
					<cfset sArgs.siteID = rc.siteID />
					<cfset aConferences	= conferenceService.getConferences( argumentCollection=sArgs ) />
				</cfif>

			<!--- get conference --->
			<cfelseif StructKeyExists(rc.params,"conferenceID") and len( rc.params.conferenceID )>
				<cfset pluginEvent.setValue("conferenceID",rc.params.conferenceID) />
				<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>

				<cfif pluginEvent.valueExists('aConferences')>
					<cfset aConferences	= pluginEvent.getValue('aConferences') />
				<cfelse>
					<cfset aConferences	= conferenceService.getConference( rc.params.conferenceID ) />
				</cfif>
			<!--- get all --->
			<cfelse>
				<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>
				<cfif pluginEvent.valueExists('aConferences')>
					<cfset aConferences	= pluginEvent.getValue('aConferences') />
				<cfelse>
					<cfset sArgs.doForums = 1 />
					<cfset sArgs.siteID = rc.siteID />
					<cfset aConferences	= conferenceService.getConferences(argumentCollection=sArgs) />
				</cfif>
			</cfif>
			<!--- get all --->
		<cfelse>
			<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>

			<cfif pluginEvent.valueExists('aConferences')>
				<cfset aConferences	= pluginEvent.getValue('aConferences') />
			<cfelse>
				<cfset aConferences	= conferenceService.getConferences() />
			</cfif>
		</cfif>

		<cfset rc.aConferences = aConferences />
	</cffunction>
</cfcomponent>