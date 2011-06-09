<cfsilent>
	<cfset local.aThread	= rc.forumBean.getThreads() />
	<cfset local.aAnnounce	= rc.forumBean.getAnnouncements()>
	<cfset local.forumBean	= rc.forumBean />
	<cfset local.context	= "forum" />
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_global.cfm">
</cfsilent>
<cfoutput>

<cfmodule template="module/md_page_header.cfm" local="#local#">
<cfif len(local.eventContent['searchform'])>
	#local.eventContent['searchform']#
<cfelse>
	<cfmodule template="module/md_searchform.cfm" local="#local#">
</cfif>

<cfif ArrayLen(local.aAnnounce)>
	<table class="mf-forum-block mf-forum-announce" id="mf-forum-announce-#lcase(rereplace(rc.forumBean.getName(),"[^[:alnum:]]","","all"))#_announcements">
		<!--- announcements --->
		<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_announcement.cfm">
		<cfif len(local.eventContent['announcementheader'])>
			#local.eventContent['announcementheader']#
		<cfelse>
			<cfmodule template="module/md_announcement.cfm" local="#local#">
		</cfif>
		<cfloop from="1" to="#ArrayLen(local.aAnnounce)#" index="iiY">
			<cfset local.threadBean = local.aAnnounce[iiY] />
			<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_forum_announcement.cfm">
			<cfif len(local.eventContent['forumannouncement'])>
				#local.eventContent['forumannouncement']#
			<cfelse>
				<cfmodule template="module/md_forum_announcement.cfm" local="#local#" showPostCounter="false" count="#ArrayLen(local.aAnnounce)#" row="#iiY#">
			</cfif>
		</cfloop>
	</table>
</cfif>

<!--- page navigation --->

<!---<cfmodule template="module/forum_buttonbar.cfm" local="#local#" class="first">--->
<cfmodule template="module/md_forum_pagenav.cfm" local="#local#" class="first">

<table class="mf-forum-block mf-forum-threads" id="mf-forum-threads-#lcase(rereplace(rc.forumBean.getName(),"[^[:alnum:]]","","all"))#">
<!--- page navigation --->
	<!--- forum header --->
		<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_forum.cfm">
		<cfif len(local.eventContent['forumheader'])>
			#local.eventContent['forumheader']#
		<cfelse>
			<cfmodule template="module/md_forum.cfm" local="#local#">
		</cfif>
	<!--- threads --->
	<cfloop from="1" to="#ArrayLen(local.aThread)#" index="iiY">
		<cfif not local.aThread[iiY].getIsDisabled() or rc.MeldForumsBean.userHasModeratePermissions()>
			<cfset local.threadBean = local.aThread[iiY] />
			<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_forum_thread.cfm">
			<cfmodule template="module/md_forum_thread.cfm" local="#local#" count="#ArrayLen(local.aThread)#" row="#iiY#">
		</cfif>
	</cfloop>
</table>
<!--- page navigation --->
<cfmodule template="module/md_forum_pagenav.cfm" local="#local#" class="first">

<cfmodule template="module/md_page_footer.cfm" local="#local#">
</cfoutput>