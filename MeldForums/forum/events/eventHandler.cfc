<!---
This file is part of the Meld Forums application.

Meld Forums is licensed under the GPL 2.0 license
Copyright (C) 2010 2011 Meld Solutions Inc. http://www.meldsolutions.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, version 2 of that license..

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

--->
<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

	<cffunction name="renderPluginDisplayObject" access="private" returntype="any" output="false">
		<cfargument name="object" type="string" required="true" />
		<cfargument name="event" type="component" required="true" />
		
		<cfset var rValue = super(argumentCollection=arguments) />
		<cfreturn rValue /> 
	</cffunction>

	<cffunction name="onApplicationLoad">
		<cfargument name="$">
		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

	<cffunction name="onRenderStart">
		<cfargument name="$">

		<cfset var app 					= variables.pluginConfig.getApplication() />
		<cfset var beanFactory			= app.getValue('beanFactory') />
		<cfset var meldForumsManager	= "" />
		<cfset var isForums				= false />

		<cfif isSimpleValue(beanFactory)>
			<cfreturn />
		</cfif>

		<cfset meldForumsManager		= beanFactory.getBean('MeldForumsManager') />
		<cfset isForums					= meldForumsManager.hasForums( $,variables.pluginConfig.getModuleID(),$.content().getContentHistID() ) />

		<cfif not isForums>
			<cfreturn>
		</cfif>				
	</cffunction>

	<cffunction name="getFrameworkConfig" output="false">
		<cfset var framework = StructNew() />

		<cfinclude template="../../frameworkConfig.cfm" />
		<cfreturn framework />		
	</cffunction>

</cfcomponent>