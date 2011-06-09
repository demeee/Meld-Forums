<cfsilent>
	<cfset local.aThread	= rc.aThread />
	<cfset local.context	= "search" />
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_global.cfm">
</cfsilent>
<cfoutput>

<cfmodule template="module/md_page_header.cfm" local="#local#">
<cfif len(local.eventContent['searchform'])>
	#local.eventContent['searchform']#
<cfelse>
	<cfmodule template="module/md_searchform.cfm" local="#local#">
</cfif>
<!--- page navigation --->
<cfmodule template="module/md_search_pagenav.cfm" local="#local#" class="first">
<table class="mf-search-block mf-search-threads mf-search-search">
<!--- page navigation --->
	<!--- search header --->
		
		<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_search.cfm">
		<cfif len(local.eventContent['searchheader'])>
			#local.eventContent['searchheader']#
		<cfelse>
			<cfmodule template="module/md_search.cfm" local="#local#">
		</cfif>
		
	<!--- threads --->
	<cfloop from="1" to="#ArrayLen(local.aThread)#" index="local.iiY">
		<cfif not local.aThread[iiY].getIsDisabled()>
			<cfset local.threadBean = local.aThread[local.iiY] />
			<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_search_thread.cfm">
			<cfmodule template="module/md_search_thread.cfm" local="#local#" count="#ArrayLen(local.aThread)#" row="#local.iiY#">
		</cfif>
	</cfloop>
</table>
<cfmodule template="module/md_search_pagenav.cfm" local="#local#" class="first">

<cfmodule template="module/md_page_header.cfm" local="#local#">

</cfoutput>