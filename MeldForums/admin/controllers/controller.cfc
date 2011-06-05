<!---
||MELDFORUMSLICENSE||
--->
<!--- this central controller must be extended by all section controllers --->
<cfcomponent displayname="controller" output="false" extends="mura.cfobject">

	<!--- do not remove the init ... it is crucial --->
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="fw" type="struct" required="false" default="#StructNew()#">
		<cfset variables.fw = fw />
		
		<cfreturn this />
	</cffunction>

	<!--- runs before every controller request --->
	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var mmBreadCrumbs	= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle	= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var sInitArgs		= StructNew()>

		<cfset rc.mmBC	= mmBreadCrumbs />
		<cfset rc.mmRBF	= mmResourceBundle />

		<!--- headloader for head includes --->
		<cfset rc.headLoader = ArrayNew(1) />
		<!--- pluginConfig --->
		<cfset rc.pluginConfig = fw.getPluginConfig() />
		<!--- breadcrumbs --->
		<cfset rc.breadcrumbs	= ArrayNew(1) />

		<cfif not structKeyExists(session,"siteid")>
			<cflocation url="/#rc.$.globalConfig().getContext()#/admin/index.cfm?fuseaction=cLogin.logout" addtoken="false">
		<cfelse>
			<cfset rc.siteID = session.siteid />
		</cfif>
		
		<cfif isUserInRole("s2") or isUserInRole("Admin;#application.settingsManager.getSite(rc.getValue('siteID')).getPublicUserPoolID()#;0")>
			<cfset rc.isAdmin = true>
		<cfelse>
			<cfset rc.isAdmin = false>
		</cfif>

		<cfset rc.errors 		= getErrorManager() />
		<cfset rc.adminID		= rc.$.currentUser('userID')>
		<cfset rc.isAdmin		= rc.$.currentUser().isInGroup('admin') or rc.$.currentUser().isSuperUser()>
		<cfset rc.rbFactory		= rc.pluginConfig.getApplication().getValue( "rbFactory")>
		<cfset rc.directory		= rc.pluginConfig.getDirectory()>
		
		<cfset rc.mmBC.addCrumb( arguments.rc,"Dashboard","?" )>
	</cffunction>

	<!--- runs after every controller request --->
	<cffunction name="after" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset var mmBreadCrumbs	= getBeanFactory().getBean("mmBreadCrumbs") />

		<cfset rc.breadCrumbString = mmBreadCrumbs.printCrumb( rc.breadcrumbs )>
	</cffunction>

	<cffunction name="getErrorManager" access="public" returntype="any" output="false">
		<cfreturn getBeanFactory().getBean("mmErrorManager")>
	</cffunction>
	
	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.fw.getBeanFactory()>
	</cffunction>
</cfcomponent>