<cfcomponent displayname="MeldDAO">

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 * 
			 * @param query 	 The query to work with. 
			 * @param row 	 Row number to check. Defaults to row 1. 
			 * @return Returns a structure. 
			 * @author Nathan Dintenfass (nathan@changemedia.com) 
			 * @version 1, December 11, 2001 
			 */
			var row = 1;
			var ii = 1;
			var cols = listToArray(qry.columnList);
			var stReturn = structnew();
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[lcase(cols[ii])] = qry[cols[ii]][row];
			}		
			return stReturn;
		</cfscript>
	</cffunction>
</cfcomponent>