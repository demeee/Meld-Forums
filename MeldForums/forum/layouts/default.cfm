<cfsilent>
	<!--- use 'local' to keep view-related data in-scope --->
	<cfset local.rc		= rc>
	<!--- headers --->
	<cfinclude template="../includes/headers/global.cfm">
	<cfif structkeyexists( rc,"headLoader" ) and arrayLen(rc.headLoader)>
		<cfloop from="1" to="#arrayLen(rc.headLoader)#" index="iiX">
			<cfhtmlhead text="#rc.headLoader[iiX]#">
		</cfloop>
	</cfif>
</cfsilent>
<cfoutput><div class="meld-forums">#body#</div></cfoutput>


