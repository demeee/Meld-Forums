<cfcomponent name="PageBean" extends="MeldForums.com.meldsolutions.core.MeldBean">

	<cfset variables.instance	= StructNew()>
	<cfset variables.MFBean		= "">

	<cffunction name="init" returntype="PageBean" >
		<cfargument name="$" required="true" type="any" />
		<cfargument name="size" required="false" type="numeric" default="-1" />
		<cfargument name="start" required="false" type="numeric" default="-1" />
		<cfargument name="count" required="false" type="numeric" default="-1" />
		<cfargument name="search" required="false" type="string" default="" />

		<cfset variables.$						= arguments.$ />
		
		<cfset setSize( arguments.size ) />
		<cfset setStart( arguments.start ) />
		<cfset setCount( arguments.count ) />
		<cfset setSearch( arguments.search) />
		
		<cfreturn this />
	</cffunction>

	<!--- url.s : page size --->
	<cffunction name="getSize" returntype="numeric" access="public" output="false">
		<cfreturn variables.instance['Size']>
	</cffunction>
	<cffunction name="setSize" returntype="void" access="public" output="false">
		<cfargument name="val" type="numeric" required="true">
		
		<cfif arguments.val gt 0>
			<cfset variables.instance.size = arguments.val />
		<cfelseif isNumeric( variables.$.event('s') )>
			<cfset variables.instance.size = variables.$.event('s') />
		<cfelse>
			<cfset variables.instance.size = 10 />
		</cfif>
	</cffunction>

	<!--- url.c : record count --->
	<cffunction name="getCount" returntype="numeric" access="public" output="false">
		<cfreturn variables.instance['count']>
	</cffunction>
	<cffunction name="setCount" returntype="void" access="public" output="false">
		<cfargument name="val" type="numeric" required="true">

		<cfif arguments.val gt 0>
			<cfset variables.instance.count = arguments.val />
		<cfelseif isNumeric( variables.$.event('c') )>
			<cfset variables.instance.count = variables.$.event('c') />
		<cfelse>
			<cfset variables.instance.count = 10 />
		</cfif>
	</cffunction>

	<!--- url.p : start position --->
	<cffunction name="getStart" returntype="numeric" access="public" output="false">
		<cfreturn variables.instance['start']>
	</cffunction>
	<cffunction name="getPos" returntype="numeric" access="public" output="false">
		<cfreturn variables.instance['start']>
	</cffunction>
	<cffunction name="setStart" returntype="void" access="public" output="false">
		<cfargument name="val" type="numeric" required="true">

		<cfif arguments.val gt 0>
			<cfset variables.instance.start = arguments.val />
		<cfelseif isNumeric( variables.$.event('p') )>
			<cfset variables.instance.start = variables.$.event('p') -1 />
		<cfelse>
			<cfset variables.instance.start = 0 />
		</cfif>
	</cffunction>

	<!--- url.k : search criteria --->
	<cffunction name="getSearch" returntype="string" access="public" output="false">
		<cfreturn variables.instance['search']>
	</cffunction>
	<cffunction name="setSearch" returntype="void" access="public" output="false">
		<cfargument name="val" type="string" required="true">

		<cfif len(arguments.val)>
			<cfset variables.instance.search = arguments.val />
		<cfelseif len( variables.$.event('k') )>
			<cfset variables.instance.search = variables.$.event('k') />
		<cfelse>
			<cfset variables.instance.search = "" />
		</cfif>
	</cffunction>
</cfcomponent>