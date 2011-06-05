<cfcomponent>
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="fw" type="struct" required="false" default="#StructNew()#">
		<cfset variables.fw = fw />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset rc.settingsBean		= getBeanFactory().getBean("MeldForumsSettingsManager").getSiteSettings( rc.$.event().getValue("siteID") ) />
		<cfset rc.themeBean			= rc.settingsBean.getThemeBean() />
		<cfset rc.pluginConfig 		= fw.getPluginConfig() />
		<cfset rc.mmEvents			= fw.getBeanFactory().getBean("MeldForumsEventManager")>
		<cfset rc.mmRBF				= fw.getBeanFactory().getBean("mmResourceBundle")>

		<cfset rc.themeDirectory	= getThemeWebRoot(rc)>

	</cffunction>

	<cffunction name="getThemeWebRoot" access="public" returntype="string" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfreturn getPluginWebRoot(rc) & "/themes/" & rc.themeBean.getPackageName() & "/">
	</cffunction>

	<cffunction name="getPluginWebRoot" access="public" returntype="string" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfreturn "#rc.$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#">
	</cffunction>

	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.fw.getBeanFactory()>
	</cffunction>
</cfcomponent>