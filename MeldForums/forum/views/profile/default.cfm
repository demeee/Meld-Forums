<cfsilent>
	<!--- headers --->
	<cfset local.sStr = "" />
</cfsilent><cfoutput>
<!--- begin content --->

<div id="meld-body">
	<cfdump var="#rc.action#">
	#createUUID()#
</div>	
<!--- end content --->
</cfoutput> 