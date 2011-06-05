<!---
||MELDMANAGERLICENSE||
--->
<cfcomponent displayname="MuraManager" output="false" hint="interfaces with Mura Service Factory">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MuraManager" access="public">
		<cfreturn this>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getServiceFactory" returntype="any" access="public">
		<cfreturn variables.instance.ServiceFactory>
	</cffunction>
	<cffunction name="setServiceFactory" returntype="void" access="public">
		<cfargument name="ServiceFactory" type="any" required="true">
		<cfset variables.instance.ServiceFactory = arguments.ServiceFactory>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getRBFactory" access="public" returntype="any" output="false">
		<cfreturn getServiceFactory().getBean("resourceBundleFactory")>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getBean" returntype="any" access="public">
		<cfargument name="beanID" type="string" required="true">
		<cfreturn getServiceFactory().getBean(arguments.beanID)>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getCacheFactory" access="public" returntype="any" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfreturn getSettingsManager(arguments.siteID).getCacheFactory()>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getSettingsManager" access="public" returntype="any" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfreturn getBean("settingsManager").getSite(arguments.siteID)>
	</cffunction>
</cfcomponent>