<!---
||MELDMANAGERLICENSE||
--->
<cfcomponent Eventname="MuraEventHandlerManager" hint="Interfaces with PluginManager to add/remove/update Event Handlers">

	<cffunction name="init" access="public" output="false" returntype="MuraEventHandlerManager">
		<cfreturn this />
	</cffunction>

	<cffunction name="registerEventHandler" output="false" returntype="any" access="public" description="Adds a new Mura Event Handler object (checks to see if the Handler already exists)">
		<cfargument name="moduleID" type="string" required="true" />
		<cfargument name="event" type="string" required="false" />
		<cfargument name="runat" type="string" required="false" />
		<cfargument name="component" type="string" required="false" />
		<cfargument name="scriptfile" type="string" required="false" />
		<cfargument name="cache" type="boolean" required="false" />
		<cfargument name="persist" type="boolean" required="false" />
		
		<cfset var eventHandlerExists	= checkIfEventHandlerExists( argumentCollection=arguments ) />		
		<cfset var eventHandler			= "" />
		
		<!--- return if already exists --->
		<cfif eventHandlerExists>
			<cfreturn false>
		</cfif>

		<cfset eventHandler			= getMuraScope().getPluginManager().getScriptBean()>

		<cfset eventHandler.setModuleID( arguments.moduleID ) />
		<cfif isDefined("arguments.event")>
			<cfset eventHandler.setRunAt( arguments.event ) />
		<cfelseif isDefined("arguments.runat")>
			<cfset eventHandler.setRunAt( arguments.runat ) />
		</cfif>
		<cfif isDefined("arguments.component")>
			<cfset eventHandler.setScriptFile( arguments.component ) />
		<cfelseif isDefined("arguments.scriptfile")>
			<cfset eventHandler.setScriptFile( arguments.scriptfile ) />
		</cfif>


		<cfif isDefined("arguments.cache")>
			<cfset eventHandler.setDoCache( arguments.cache ) />
		<cfelseif isDefined("arguments.persist")>
			<cfset eventHandler.setDoCache( arguments.persist ) />
		<cfelse>
			<cfset eventHandler.setDoCache( false ) />
		</cfif>

		<cfset eventHandler.save() />
		
		<cfreturn eventHandler>
	</cffunction>

	<cffunction name="deleteEventHandlerByScript" output="false" returntype="void" access="public" description="deletes a Mura Event Handler">
		<cfargument name="moduleID" type="string" required="true" />
		<cfargument name="scriptfile" type="string" required="true" />
		
		<cfset var qDo			= "" />		
		
		<cfquery name="qDo" datasource="#getMuraScope().globalConfig().getDatasource()#" username="#getMuraScope().globalConfig().getDBUserName()#" password="#getMuraScope().globalConfig().getDBPassword()#">
			DELETE FROM
				tpluginscripts
			WHERE
				moduleID = <cfqueryparam value="#arguments.moduleID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				scriptfile = <cfqueryparam value="#arguments.scriptfile#" CFSQLType="cf_sql_varchar" maxlength="100" />
		</cfquery>
	</cffunction>

	<cffunction name="checkIfEventHandlerExists" output="false" returntype="boolean" access="public" description="checks to see if a Mura Event Handler exists">
		<cfargument name="moduleID" type="string" required="true" />
		<cfargument name="component" type="string" required="false" />
		<cfargument name="scriptfile" type="string" required="false" />
		
		<cfset var qCheck = "" />
		
		<cfquery name="qCheck" datasource="#getMuraScope().globalConfig().getDatasource()#" username="#getMuraScope().globalConfig().getDBUserName()#" password="#getMuraScope().globalConfig().getDBPassword()#">
			SELECT
			<cfif getMuraScope().globalConfig().getDBType() eq "MSSQL">
				TOP 1
			</cfif>
				scriptID
			FROM
				tpluginscripts
			WHERE
				moduleID = <cfqueryparam value="#arguments.moduleID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				<cfif structKeyExists(arguments,"component")>
					scriptfile = <cfqueryparam value="#arguments.component#" CFSQLType="cf_sql_varchar" maxlength="100" />
				<cfelse>
					scriptfile = <cfqueryparam value="#arguments.scriptfile#" CFSQLType="cf_sql_varchar" maxlength="100" />
				</cfif>
			<cfif getMuraScope().globalConfig().getDBType() eq "MYSQL">
				LIMIT 1
			</cfif>
		</cfquery>
		
		<cfif qCheck.recordcount>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="setMuraScope" access="public" returntype="any" output="false">
		<cfargument name="MuraScope" type="any" required="true">
		<cfset variables.MuraScope = arguments.MuraScope>
	</cffunction>
	<cffunction name="getMuraScope" access="public" returntype="any" output="false">
		<cfreturn variables.MuraScope>
	</cffunction>
</cfcomponent>