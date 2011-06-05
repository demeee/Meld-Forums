<cfsilent>
<cfset attributes.eventContent = StructNew() />

<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
<cfset local.content = StructNew() />

<cfset local.content.search	= StructNew() />
<cfset local.content.panel	= StructNew() />

<cfset local.event.setValue('content',local.content.search ) />
<cfset local.event.setValue('panel',local.content.panel ) />
<cfset local.event.setValue('renderDefaultPanel',true ) />

<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsDisplayServicePanel",local.event ) />

<cfif structCount( local.content.search )>
	<cfset attributes.contentStruct = local.content.search />
	<cfset attributes.aSort = structSort( attributes.contentStruct ) />
	<cfsavecontent variable="attributes.eventContent['search']"><cfoutput>
	<cfloop from="1" to="#ArrayLen(attributes.aSort)#" index="attributes.iiX">
		#attributes.contentStruct[attributes.aSort[attributes.iiX]]#
	</cfloop>
	</cfoutput></cfsavecontent>
</cfif>

<cfif structCount( local.content.panel )>
	<cfset attributes.contentStruct = local.content.panel />
	<cfset attributes.aSort = structSort( attributes.contentStruct ) />
	<cfsavecontent variable="attributes.eventContent['panel']"><cfoutput>
	<cfloop from="1" to="#ArrayLen(attributes.aSort)#" index="attributes.iiX">
		#attributes.contentStruct[attributes.aSort[attributes.iiX]]#
	</cfloop>
	</cfoutput></cfsavecontent>
</cfif>

</cfsilent>