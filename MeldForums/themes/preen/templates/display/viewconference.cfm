<cfsilent>
	<cfset local.aConferences		= rc.aConferences />
	<cfset local.conferenceBean		= "" />
	<cfset local.aForums			= "" />
	<cfset local.forumBean			= "" />
	<cfset local.context			= "conference" />
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_global.cfm">
</cfsilent>
<cfoutput>

<cfmodule template="module/md_page_header.cfm" local="#local#">
<cfif len(local.eventContent['searchform'])>
	#local.eventContent['searchform']#
<cfelse>
	<cfmodule template="module/md_searchform.cfm" local="#local#">
</cfif>

<cfloop from="1" to="#ArrayLen(local.aConferences)#" index="local.iiX">
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_conference.cfm">
	<!--- current conference & forums to local --->
	<cfset local.conferenceBean	= local.aConferences[local.iiX] />
	<cfset local.aForums	= local.conferenceBean.getForums() />
	<cfif ArrayLen( local.aForums ) and rc.MeldForumsBean.getHasPermissions( local.conferenceBean.getActiveConfigurationID() )>
	<table class="mf-conference-block" id="mf-conference-#lcase(rereplace(local.conferenceBean.getName(),"[^[:alnum:]]","","all"))#">
		<cfif len(local.eventContent['conference'])>
			#local.eventContent['conference']#
		<cfelse>
			<cfmodule template="module/md_conference.cfm" local="#local#" count="#ArrayLen(local.aConferences)#" row="#local.iiX#">
		</cfif>
		<cfloop from="1" to="#ArrayLen(local.aForums)#" index="local.iiY">
			<!--- current forum to local --->
			<cfset local.forumBean	= local.aForums[local.iiY] />

			<cfif rc.MeldForumsBean.getHasPermissions( local.forumBean.getActiveConfigurationID() )>
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_conference_forum.cfm">
				<cfif len(local.eventContent['conferenceforum'])>
					#local.eventContent['conferenceforum']#
				<cfelse>
					<cfmodule template="module/md_conference_forum.cfm" local="#local#" count="#ArrayLen(local.aForums)#" row="#local.iiY#">
				</cfif>
			</cfif>
		</cfloop>
	</table>
	</cfif>
</cfloop>

<cfmodule template="module/md_page_footer.cfm" local="#local#">

</cfoutput>