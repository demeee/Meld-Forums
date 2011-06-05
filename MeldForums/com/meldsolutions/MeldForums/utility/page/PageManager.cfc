<cfcomponent displayname="PageManager" output="false">

	<cffunction name="init" returntype="PageManager" access="public" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction name="getPageBean" returntype="any" output="false">
		<cfargument name="$" required="true" type="any" />
		<cfargument name="size" required="false" type="numeric" default="-1" />
		<cfargument name="start" required="false" type="numeric" default="-1" />
		<cfargument name="count" required="false" type="numeric" default="-1" />
		<cfargument name="search" required="false" type="string" default="" />

		<cfreturn createObject("component","PageBean").init( argumentCollection=arguments )>
	</cffunction>
</cfcomponent>