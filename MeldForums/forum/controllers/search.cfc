<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doSearch( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doSearch" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var searchManager		= getBeanFactory().getBean("MeldForumsSearchManager") />
		<cfset var pageManager			= getBeanFactory().getBean("PageManager")>
		<cfset var pageBean				= pageManager.getPageBean( $,rc.MFBean.getValue("settingsBean").getThreadsPerPage() )>

		<cfset var criteria				= StructNew() />
		<cfset var sArgs				= StructNew() />
		<cfset var aThreads				= ArrayNew(1) />

		<cfset criteria.searchText		= rc['k'] />
		<cfset criteria.siteID			= rc.$.event('siteID') />

		<cfset sArgs.criteria			= criteria />
		<cfif structKeyExists(rc,"st")>
			<cfset sArgs.searchType			= rc['st'] />
		</cfif>
		<cfset sArgs.pageBean			= pageBean />
		<cfset sArgs.MFBean				= rc.MFBean />

		<cfset aThreads = searchManager.doSearch( argumentCollection=sArgs ) />
	</cffunction>


</cfcomponent>