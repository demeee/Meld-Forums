<cfcomponent extends="controller">

	<!--- 
		we need to establish the current theme for all requests
	 --->
	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />

		<cfset rc.meldForumsBean	= meldForumsBean />
		<cfset rc.settingsBean		= meldForumsBean.getValue("settingsBean") />
		<cfset rc.themeBean			= meldForumsBean.getValue("themeBean") />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />
	</cffunction>

	<cffunction name="panel" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />
	</cffunction>

</cfcomponent>