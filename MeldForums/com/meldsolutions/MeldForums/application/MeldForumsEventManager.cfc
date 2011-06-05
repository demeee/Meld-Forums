<cfcomponent displayname="MeldForumsEventManager" hint="Meld Event" output="false">
	<cfset variables.values		= StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldForumsEventManager">
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="createEvent" access="public" returntype="any" output="false">
		<cfargument name="$" type="struct" required="false" default="#StructNew()#">

		<cfset var pluginEvent 		= createObject("component","mura.MuraScope") />
		<cfset var ident			= "" />

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />
		<cfset pluginEvent.setValue("siteID", $.event().getValue('siteID') ) />

		<cfreturn pluginEvent />
	</cffunction>	
	
	<cffunction name="announceEvent" access="public" returntype="void" output="false">
		<cfargument name="$" type="struct" required="false" default="#StructNew()#">
		<cfargument name="name" type="string" required="true">
		<cfargument name="event" type="any" required="true">

		<cfset $.getBean('pluginManager').announceEvent(arguments.name,arguments.event) />
	</cffunction>	
	
	<cffunction name="renderEvent" access="public" returntype="any" output="false">
		<cfargument name="$" type="struct" required="false" default="#StructNew()#">
		<cfargument name="name" type="string" required="true">
		<cfargument name="event" type="any" required="true">

		<cfreturn $.getBean('pluginManager').renderEvent(arguments.name,arguments.event) />
	</cffunction>	
</cfcomponent>