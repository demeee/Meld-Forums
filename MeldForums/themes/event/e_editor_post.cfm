<cfsilent>
<cfset attributes.eventContent = StructNew() />

<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />
<cfset local.event.setValue('postbean',rc.postbean) />
<cfset local.event.setValue('threadBean',rc.threadBean) />

<cfset local.content = StructNew() />

<cfset local.content.fields 		= StructNew() />
<cfset local.content.moderatefields	= StructNew() />

<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsDisplayPostEdit",local.event ) />

<cfif structCount( local.content.fields )>
	<cfset attributes.contentStruct = local.content.fields />
	<cfset attributes.aSort = structSort( attributes.contentStruct ) />
	<cfsavecontent variable="attributes.eventContent['fields']"><cfoutput>
	<cfloop from="1" to="#ArrayLen(attributes.aSort)#" index="attributes.iiX">
		#attributes.contentStruct[attributes.aSort[attributes.iiX]]#
	</cfloop>
	</cfoutput></cfsavecontent>
</cfif>

<cfif structCount( local.content.moderatefields )>
	<cfset attributes.contentStruct = local.content.moderatefields />
	<cfset attributes.aSort = structSort( attributes.contentStruct ) />
	<cfsavecontent variable="attributes.eventContent['moderatefields']"><cfoutput>
	<cfloop from="1" to="#ArrayLen(attributes.aSort)#" index="attributes.iiX">
		#attributes.contentStruct[attributes.aSort[attributes.iiX]]#
	</cfloop>
	</cfoutput></cfsavecontent>
</cfif>

</cfsilent>