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
	<cfset variables.framework=getFrameworkVariables()>

	<cffunction name="onApplicationLoad">
		<cfargument name="$">

		<cfset var appreloadKey = $.GlobalConfig().getValue('appreloadKey') />

		<cfif len( appreloadKey ) and structKeyExists(url,appreloadKey)> 
			<cfset url[variables.framework.reload] = true />
		</cfif>

		<!--- invoke onApplicationStart in the application.cfc so the framework can do its thing --->
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onApplicationStart" />

		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

	<cffunction name="onAdminModuleNav">
		<cfargument name="$">

		<cfif structKeyExists(session,"MeldForumsAppreinit")>
			<cfset structDelete(session,"MeldForumsAppreinit") />
			<cfif not StructKeyExists(url,"appreload")>
				<cflocation url="./?appreload&reload=appreload" addtoken="false">
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="onRenderStart">
		<cfargument name="$">

		<cfset var app 						= variables.pluginConfig.getApplication() />
		<cfset var beanFactory				= app.getValue('beanFactory') />
		<cfset var meldForumsEventManager	= beanFactory.getBean('MeldForumsEventManager') />
		<cfset var meldForumsManager		= beanFactory.getBean('MeldForumsManager') />
		<cfset var mmUtility 				= beanFactory.getBean('mmUtility') />
		<cfset var pluginEvent 				= meldForumsEventManager.createEvent($) />
		<cfset var aCrumbData				= ArrayNew( 1 ) />

		<cfif not $.getGlobalEvent().valueExists('MeldForumsCrumbData')>
			<cfreturn />
		</cfif>

		<cfset aCrumbData = $.getGlobalEvent().getValue('MeldForumsCrumbData')  />

		<cfif not arraylen(aCrumbData)>
			<cfreturn />
		</cfif>

		<cfset pluginEvent.setValue("aCrumbData",aCrumbData) />
		<cfset meldForumsEventManager.announceEvent($,"onMeldForumsAddBreadCrumbs",pluginEvent)>
		<cfset meldForumsManager.setCrumbData( $,aCrumbData ) />
	</cffunction>

	<cffunction name="onSiteRequestInit">
		<cfargument name="$">
		
		<cfset var app 					= variables.pluginConfig.getApplication() />
		<cfset var beanFactory			= app.getValue('beanFactory') />
		<cfset var cFileName			= $.event().getValue('currentfilename') />
		<cfset var filenameMarker		= refindNoCase("\/mf[$|/]",$.event().getValue('currentfilename')) />
		<cfset var pathMarker			= refindNoCase("\/mf[$|/]",$.event().getValue('path')) />

		<cfset var meldForumsManager	= "" />

		<cfset var aIntercept			= ArrayNew(1) />
		<cfset var sIntercept			= "" />

		<cfif not filenameMarker or isSimpleValue(beanFactory)>
			<cfreturn />
		</cfif>

		<cfset meldForumsManager		= beanFactory.getBean('MeldForumsManager') />
		
		<cfset $.event().setValue('currentfilename',left( cFileName,filenameMarker-1 )) />
		<cfset $.event().setValue('path', left( $.event().getValue('path'),pathMarker-1 ) & "/" ) />

		<cfif len( $.event().getValue('currentfilenameadjusted') )>
			<cfset $.event().setValue('currentfilenameadjusted',left( cFileName,filenameMarker-1 )) />
		</cfif>

		<cfset sIntercept = mid( cFileName,filenameMarker+4,len(cFileName) ) />
	
		<cfif len( sIntercept )>
			<cfset aIntercept = ListToArray( sIntercept,"/" ) />
		</cfif>

		<cfif ArrayLen( aIntercept )>
			<cfset meldForumsManager.processIntercept( $,aIntercept ) />
		</cfif>
	</cffunction>

	<cffunction name="getFrameworkVariables" output="false" access="private">
		<cfset var framework = StructNew() />

		<cfinclude template="../frameworkConfig.cfm" />

		<cfreturn framework />		
	</cffunction>
</cfcomponent>