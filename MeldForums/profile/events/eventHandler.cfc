<!---
||MELDFORUMSELICENSE||
--->
<cfcomponent extends="mura.plugin.pluginGenericEventHandler">
	<cfset variables.framework=getFrameworkConfig() />

	<cffunction name="onApplicationLoad">
		<cfargument name="$">
		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>
	
	<cffunction name="onSiteRequestStart">
		<cfargument name="$">
		<cfargument name="event">
		<!--- 
		<cfset var beanFactory							= variables.pluginConfig.getApplication().getValue('beanFactory') />

		<cfif not StructKeyExists($,variables.framework.applicationKey)>
			<cfset $[variables.framework.applicationKey]	=  application[ variables.framework.applicationKey ] />
		</cfif>
		
		<cfif isSimpleValue( beanFactory )>
			<cfreturn>
		</cfif>
		 --->
	</cffunction>

	<cffunction name="getFrameworkConfig" output="false">
		<cfset var framework = StructNew() />

		<cfinclude template="../../frameworkConfig.cfm" />
		<cfreturn framework />		
	</cffunction>
</cfcomponent>