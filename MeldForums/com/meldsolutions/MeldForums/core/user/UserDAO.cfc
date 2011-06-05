<!---||MELDFORUMSLICENSE||--->
<cfcomponent displayname="UserDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="UserDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="dsnusername" type="string" required="true">
		<cfargument name="dsnpassword" type="string" required="true">
		<cfargument name="dsnprefix" type="string" required="true">
		<cfargument name="dsntype" type="string" required="true">

		<cfset variables.dsn = arguments.dsn>
		<cfset variables.dsnusername = arguments.dsnusername>
		<cfset variables.dsnpassword = arguments.dsnpassword>
		<cfset variables.dsnprefix = arguments.dsnprefix>
		<cfset variables.dsntype = arguments.dsntype>

		<cfreturn this />
	</cffunction>
	
	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="UserBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_user
				(
				<!---^^SAVECOLUMNS-START^^--->
				UserID,
				SiteID,
				Screenname,
				AvatarID,
				RedoAvatar,
				ThreadCounter,
				LastPostID,
				LastThreadID,
				AdminMessage,
				IsConfirmed,
				IsPrivate,
				IsPostBlocked,
				IsBlocked,
				DoReplyNotifications,
				PostCounter,
				DateLastAction,
				DateLastLogin,
				DateIsNewFrom,
				RemoteID,
				DateCreate,
				DateLastUpdate
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.UserBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.UserBean.getSiteID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.UserBean.getSiteID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.UserBean.getScreenname()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.UserBean.getScreenname()))#" maxlength="50" />,
				<cfqueryparam value="#arguments.UserBean.getAvatarID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.UserBean.getAvatarID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.UserBean.getRedoAvatar()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.UserBean.getThreadCounter()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.UserBean.getLastPostID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.UserBean.getLastPostID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.UserBean.getLastThreadID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.UserBean.getLastThreadID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.UserBean.getAdminMessage()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.UserBean.getAdminMessage()))#" />,
				<cfqueryparam value="#arguments.UserBean.getIsConfirmed()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.UserBean.getIsPrivate()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.UserBean.getIsPostBlocked()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.UserBean.getIsBlocked()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.UserBean.getDoReplyNotifications()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.UserBean.getPostCounter()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.UserBean.getDateLastAction()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.UserBean.getDateLastAction()))#" />,
				<cfqueryparam value="#arguments.UserBean.getDateLastLogin()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.UserBean.getDateLastLogin()))#" />,
				<cfqueryparam value="#arguments.UserBean.getDateIsNewFrom()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.UserBean.getDateIsNewFrom()))#" />,
				<cfqueryparam value="#arguments.UserBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.UserBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		
		<cfset arguments.UserBean.setBeanExists( 1 ) />
		<cfset arguments.UserBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.UserBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="UserBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,true AS BeanExists
			FROM
				#variables.dsnprefix#mf_user
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND UserID = <cfqueryparam value="#arguments.UserBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.UserBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="UserBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_user
			SET
				<!---^^UPDATEVALUES-START^^--->
				SiteID = <cfqueryparam value="#arguments.UserBean.getSiteID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.UserBean.getSiteID()))#" maxlength="35" />,
				Screenname = <cfqueryparam value="#arguments.UserBean.getScreenname()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.UserBean.getScreenname()))#" maxlength="50" />,
				AvatarID = <cfqueryparam value="#arguments.UserBean.getAvatarID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.UserBean.getAvatarID()))#" maxlength="35" />,
				RedoAvatar = <cfqueryparam value="#arguments.UserBean.getRedoAvatar()#" CFSQLType="cf_sql_tinyint" />,
				ThreadCounter = <cfqueryparam value="#arguments.UserBean.getThreadCounter()#" CFSQLType="cf_sql_integer" />,
				LastPostID = <cfqueryparam value="#arguments.UserBean.getLastPostID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.UserBean.getLastPostID()))#" maxlength="35" />,
				LastThreadID = <cfqueryparam value="#arguments.UserBean.getLastThreadID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.UserBean.getLastThreadID()))#" maxlength="35" />,
				AdminMessage = <cfqueryparam value="#arguments.UserBean.getAdminMessage()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.UserBean.getAdminMessage()))#" />,
				IsConfirmed = <cfqueryparam value="#arguments.UserBean.getIsConfirmed()#" CFSQLType="cf_sql_tinyint" />,
				IsPrivate = <cfqueryparam value="#arguments.UserBean.getIsPrivate()#" CFSQLType="cf_sql_tinyint" />,
				IsPostBlocked = <cfqueryparam value="#arguments.UserBean.getIsPostBlocked()#" CFSQLType="cf_sql_tinyint" />,
				IsBlocked = <cfqueryparam value="#arguments.UserBean.getIsBlocked()#" CFSQLType="cf_sql_tinyint" />,
				DoReplyNotifications = <cfqueryparam value="#arguments.UserBean.getDoReplyNotifications()#" CFSQLType="cf_sql_tinyint" />,
				PostCounter = <cfqueryparam value="#arguments.UserBean.getPostCounter()#" CFSQLType="cf_sql_integer" />,
				DateLastAction = <cfqueryparam value="#arguments.UserBean.getDateLastAction()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.UserBean.getDateLastAction()))#" />,
				DateLastLogin = <cfqueryparam value="#arguments.UserBean.getDateLastLogin()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.UserBean.getDateLastLogin()))#" />,
				DateIsNewFrom = <cfqueryparam value="#arguments.UserBean.getDateIsNewFrom()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.UserBean.getDateIsNewFrom()))#" />,
				RemoteID = <cfqueryparam value="#arguments.UserBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.UserBean.getRemoteID()))#" maxlength="35" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND UserID = <cfqueryparam value="#arguments.UserBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.UserBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="UserBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_user
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND UserID = <cfqueryparam value="#arguments.UserBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.UserBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="UserBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_user
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND UserID = <cfqueryparam value="#arguments.UserBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.UserBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.UserBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	





