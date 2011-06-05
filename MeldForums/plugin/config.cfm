<cfsilent>
	<cfif not isDefined("$")>
		<cfset $=application.serviceFactory.getBean('muraScope').init('default')>
	</cfif>

	<cfif not isDefined("pluginConfig")>
		<cfset variables.pluginConfig=$.getBean('pluginManager').getConfig('MeldForums')>
	</cfif>
</cfsilent>