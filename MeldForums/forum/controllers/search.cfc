<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />

	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif not structKeyExists(rc,"k") or not len(rc.k)>
			<cflocation url="#rc.MFBean.getForumWebRoot()#" addtoken="false" />
		</cfif>

		<cfset doSearch( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doSearch" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var searchManager		= getBeanFactory().getBean("MeldForumsSearchManager") />
		<cfset var pageManager			= getBeanFactory().getBean("PageManager")>
		<cfset var pageBean				= pageManager.getPageBean( $,rc.MFBean.getValue("settingsBean").getThreadsPerPage() )>

		<cfset var criteria				= StructNew() />
		<cfset var sArgs				= StructNew() />
		<cfset var aThread				= ArrayNew(1) />

		<cfset criteria.searchText		= pageBean.getSearch() />
		<cfset criteria.searchType		= pageBean.getSearchType() />
		<cfset criteria.siteID			= rc.$.event('siteID') />

		<cfset sArgs.criteria			= criteria />
		<cfset sArgs.pageBean			= pageBean />
		<cfset sArgs.MFBean				= rc.MFBean />

		<cfset aThread = searchManager.doSearch( argumentCollection=sArgs ) />
		<cfset rc.pageBean = pageBean />
		<cfset rc.aThread = aThread />
	</cffunction>


</cfcomponent>