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

		<!--- headloader for head includes --->
		<cfset rc.headLoader = ArrayNew(1) />
		<!--- pluginConfig --->
		<cfset rc.pluginConfig = fw.getPluginConfig() />

		<!--- enable the Mura Scope --->
		<cfif not isDefined("$") and structKeyExists(session,"siteID")>
			<cfset $=$>
		</cfif>

		<cfif $.event().valueExists("ecode")>
			<cfset getErrorManager().addErrorByCode($.event(),$.event().getValue("ecode")) />
		</cfif>

		<cfset rc.isAdmin 	= false>
		<cfset rc.errors	= getErrorManager() />

		<cfset rc.subsystem	= fw.getSubSystem()>
		<cfset rc.userID	= $.currentUser('USERID')>
		<cfset rc.isAdmin	= $.currentUser().isInGroup('admin') eq true OR $.currentUser().isSuperUser() eq true>
		<cfset rc.rbFactory	= rc.pluginConfig.getApplication().getValue( "rbFactory")>
		<cfset rc.directory	= rc.pluginConfig.getDirectory()>
		<cfset rc.mmRBF		= fw.getBeanFactory().getBean("mmResourceBundle")>
	</cffunction>

	<!--- runs after every controller request --->
	<cffunction name="after" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		
	</cffunction>
	
	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.fw.getBeanFactory()>
	</cffunction>
	
	<cffunction name="getErrorManager" access="public" returntype="any" output="false">
		<cfreturn getBeanFactory().getBean("ErrorManager")>
	</cffunction>
</cfcomponent>