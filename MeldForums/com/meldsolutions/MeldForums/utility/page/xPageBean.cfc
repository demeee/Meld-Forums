<cfcomponent displayname="pageBean" hint="stores and manages data paging" output="false">
	<cfproperty name="pre" type="string" default="" />
	<cfproperty name="urlstring" type="string" default="" />
	<cfproperty name="count" type="numeric" default="0" />
	<cfproperty name="pos" type="numeric" default="0" />
	<cfproperty name="size" type="numeric" default="5" />
	<cfproperty name="search" type="string" default="" />
	<cfproperty name="orderby" type="string" default="" />
	<cfproperty name="navType" type="numeric" default="0" />

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="pageBean">
		<cfargument name="$" type="any" required="true"/>

		<cfset var meldForumsBean					= $.event().getValue("MeldForumsBean") />
		<cfset variables.mmRBF						= meldForumsBean.getValue("mmRBF") />

		<cfset variables.instance.navType			= $.event().getValue("navtype")>
		<cfset variables.instance.searchhint		= variables.mmRBF.key('hint')>		
		<cfset variables.instance.previous			= variables.mmRBF.key('previous')>		
		<cfset variables.instance.next				= variables.mmRBF.key('next')>
		<cfset variables.instance.first				= variables.mmRBF.key('first')>		
		<cfset variables.instance.last				= variables.mmRBF.key('last')>
		<cfset variables.instance.go				= variables.mmRBF.key('gosearch')>
		<cfset variables.instance.dosearch			= variables.mmRBF.key('dosearch')>
		<cfset variables.instance.clearsearch		= variables.mmRBF.key('clearsearch')>

		<cfset variables.instance.urlstring = stripHTML( $.event().getValue("urlstring") )>
		<cfset variables.instance.search = stripHTML( $.event().getValue("k") )>
		<cfset variables.instance.searchtype = stripHTML( $.event().getValue("st") )>
		<cfset variables.instance.orderby = stripHTML( $.event().getValue("o") )>
		<cfset variables.instance.pagingSize = 5>
		
		<cfif len( $.event().getValue("navType") )>
			<cfset variables.instance.navType = stripHTML( $.event().getValue("navType") )>
		<cfelse>
			<cfset variables.instance.navType = "event">
		</cfif>
		
		<cfif len(  $.event().getValue("pre") )>
			<cfset variables.instance.pre = stripHTML( $.event().getValue("pre") )>
		<cfelse>
			<cfset variables.instance.pre = stripHTML( $.event().getValue("event") )>
		</cfif>

		<cfif len(  $.event().getValue("c") )>
			<cfset variables.instance.count = stripHTML( $.event().getValue("c") )>
		<cfelse>
			<cfset variables.instance.count = 0>
		</cfif>

		<cfif len(  $.event().getValue("s") )>
			<cfset variables.instance.size = stripHTML( $.event().getValue("s") )>
		<cfelse>
			<cfset variables.instance.size = 5>
		</cfif>

		<cfif len(  $.event().getValue("p") )>
			<cfset variables.instance.pos = stripHTML( $.event().getValue("p") )>
		<cfelseif len( $.event().getValue("pg") )>
			<cfset setPage( stripHTML( $.event().getValue("pg") ) )>
			<cfset $.event().setValue("p",getPos())>
		<cfelse>
			<cfset variables.instance.pos = 0>
		</cfif>
		
		<cfset fixValues()>
		<cfreturn this>
	</cffunction>

	<cffunction name="getMemento" returntype="Any" access="public" output="false">
		<cfreturn variables.instance>
	</cffunction>

	<cffunction name="createNav" returntype="void" access="public" output="false">
		<cfset fixValues()>
		<cfif variables.instance.navType eq "ajax">
			<cfset createAjaxNav()>
		<cfelse>
			<cfset createNavHTML()>
		</cfif>
	</cffunction>

	<cffunction name="createNavHTML" returntype="void" access="public" output="false">
		<cfset var sNavPre		= "">
		<cfset var sNavFull		= "">
		<cfset var sNavString	= "">
		<cfset var sNavPiece	= "">
		<cfset var sNavBack		= "">
		<cfset var sNavNext		= "">
		<cfset var snavpage	= "">
		<cfset var sSearch		= "">
		<cfset var iiX			= "">
		<cfset var iPos			= 0>
		<cfset var iCurrentPage	= int(variables.instance.pos/variables.instance.size)+1>
		<cfset var iPageNumber	= 1>
		<cfset var iPageLimit	= getPageLimit()>
		<cfset var iPageCount	= 0>

		<cfset variables.instance.currentPage = iCurrentPage>

		<cfif variables.instance.navType eq "event">
			<cfset sNavPre		= "?event=" & variables.instance.pre & "&amp;">
		<cfelse>
			<cfset sNavPre		= variables.instance.pre>
		</cfif>

		<cfif len(variables.instance.search)>
			<cfset sSearch = "&amp;k=#urlEncodedFormat(variables.instance.search)#">
			<cfif len(variables.instance.searchtype)>
				<cfset sSearch = sSearch & "&amp;st=#variables.instance.searchType#">
			</cfif>
		</cfif>

		<cfif iPageLimit gt variables.instance.pagingSize>
			<cfif iCurrentPage lte 1>
				<cfset sNavBack = "<ul class='navlist navback off'><li class='first'>#variables.instance.first#</li><li class='previous'>#variables.instance.previous#</li></ul>">
			<cfelse>
				<cfset sNavBack = "<ul class='navlist navback'><li class='first'><a href='./?pg=1&amp;c=#getCount()##sSearch#'>#variables.instance.first#</a></li>">
				<cfset sNavBack = sNavBack & "<li class='previous'><a href='./?pg=#(iCurrentPage-1)#&amp;c=#getCount()##sSearch#'>#variables.instance.previous#</a></li></ul>">
			</cfif>
			<cfif iCurrentPage gte iPageLimit>
				<cfset sNavNext = "<ul class='navlist navnext off'><li class='next'>#variables.instance.next#</li><li class='last'>#variables.instance.last#</li></ul>">
			<cfelse>
				<cfset sNavNext = "<ul class='navlist navnext'><li class='next'><a href='./?pg=#(iCurrentPage+1)#&amp;c=#getCount()##sSearch#'>#variables.instance.next#</a></li>">
				<cfset sNavNext = sNavNext & "<li class='last'><a href='./?pg=#iPageLimit#&amp;c=#getCount()##sSearch#'>#variables.instance.last#</a></li></ul>">
			</cfif>	
		</cfif>

		<cfif iCurrentPage lte round(variables.instance.pagingSize/2)>
			<!--- iPageNumber 0 --->
			<cfset iPageNumber = 1>
			<cfset iPageCount = iPageNumber+variables.instance.pagingSize>
		<!--- position is less than the distance from the pagingSize to the top --->
		<cfelseif (iCurrentPage-int(variables.instance.pagingSize/2))+(variables.instance.pagingSize-1) lt iPageLimit>
			<cfset iPageNumber = iCurrentPage-int(variables.instance.pagingSize/2)>
			<cfset iPageCount = iPageNumber+variables.instance.pagingSize-1>
		<!--- position is within the page range to the top --->
		<cfelse>
			<cfset iPageNumber = iPageLimit-variables.instance.pagingSize+1>
			<cfset iPageCount = iPageLimit>
		</cfif>

		<!--- deals with pages that are less than the page range --->				
		<cfif iPageNumber lte 1>
			<cfset iPageNumber = 1>
			<cfset iPageCount = variables.instance.pagingSize>
		</cfif>
		<cfif iPageCount gt iPageLimit>
			<cfset iPageCount = iPageLimit>
		</cfif>

		<cfif iPageCount gt iPageNumber>
			<cfset sNavString = '<ul class="navlist navpages">'>
			<cfloop from="#iPageNumber#" to="#iPageCount#" index="iiX">
				<cfif iiX eq iCurrentPage>
					<cfset sNavPiece = "<li class='navpage current'>#iiX#</li>">
				<cfelse>
					<cfset sNavPiece = "<li class='navpage'><a href='./#sNavPre#p=#((iiX-1)*variables.instance.size)#&amp;c=#getCount()##variables.instance.urlstring##sSearch#'>#iiX#</a></li>">
				</cfif>
				<cfset sNavString = sNavString & sNavPiece>
			</cfloop>
			<cfset sNavString = sNavString & "</ul>">


			<cfsavecontent variable="snavpage"><cfoutput>
		<form class="forumsform navPageForm" id="||ID||" action="#sNavPre##variables.instance.urlstring##sSearch#" method="post" onchange="doNavViaSelector('||ID||','pp');">
		 <select name="pg" class="pageNav"><cfloop from="1" to="#iPageLimit#" index="iiX">
		 <option value="#iiX#"<cfif iCurrentPage eq iiX>SELECTED</cfif>>#iiX#</option>
		</cfloop></select>
</form></cfoutput>
			</cfsavecontent>
		</Cfif>


		<cfset sNavFull = sNavBack & sNavString & sNavNext & snavpage>
		<cfset variables.instance.navback = sNavBack>
		<cfset variables.instance.navnext = sNavNext>
		<cfset variables.instance.navpage = snavpage>
		<cfset variables.instance.nav = sNavString>
		<cfset variables.instance.navfull = sNavFull>
	</cffunction>

	<cffunction name="createAjaxNav" returntype="void" access="public" output="false">
		<!--- boy I bet you wish this was done --->

	</cffunction>

	<cffunction name="getPre" returntype="string" access="public" output="false">

		<cfreturn variables.instance.pre>
	</cffunction>
	<cffunction name="setPre" returntype="void" access="public" output="false">
		<cfargument name="val" type="string" required="true">
		<cfset variables.instance.pre = val>
	</cffunction>

	<cffunction name="getPos" returntype="numeric" access="public" output="false">
		<cfif variables.instance.pos lt 0 or variables.instance.pos gt getCount()>
			<cfset fixvalues()>
		</cfif>
		<cfreturn variables.instance.pos>
	</cffunction>
	<cffunction name="setPos" returntype="void" access="public" output="false">
		<cfargument name="val" type="numeric" required="true">
		<cfset variables.instance.pos = val>
	</cffunction>

	<cffunction name="setPage" returntype="void" access="public" output="false">
		<cfargument name="val" type="numeric" required="true">
		<cfset var pos = (val*variables.instance.size)-variables.instance.size>
		<cfset setPos( pos )>
	</cffunction>

	<cffunction name="getCount" returntype="numeric" access="public" output="false">
		<cfif variables.instance.count lt 0>
			<cfset fixvalues()>
		</cfif>
		<cfreturn variables.instance.count>
	</cffunction>
	<cffunction name="setCount" returntype="void" access="public" output="false">
		<cfargument name="val" type="numeric" required="true">
		<cfset variables.instance.count = val>
	</cffunction>

	<cffunction name="getSize" returntype="numeric" access="public" output="false">
		<cfif variables.instance.size lt 0>
			<cfset fixvalues()>
		</cfif>
		<cfreturn variables.instance.size>
	</cffunction>
	<cffunction name="setSize" returntype="void" access="public" output="false">
		<cfargument name="val" type="numeric" required="true">
		<cfset variables.instance.size = val>
	</cffunction>

	<cffunction name="getPage" returntype="numeric" access="public" output="false">
		<cfif not structKeyExists(variables.instance,"currentPage")>
			<cfset createNav()>
		</cfif>
		<cfreturn variables.instance.currentPage>
	</cffunction>

	<cffunction name="getPageLimit" returntype="numeric" access="public" output="false">

		<cfreturn int(variables.instance.count/variables.instance.size)+iif(variables.instance.count mod variables.instance.size,de(1),de(0))>
	</cffunction>

	<cffunction name="getSearch" returntype="string" access="public" output="false">
		<cfreturn variables.instance.search>
	</cffunction>

	<cffunction name="getSearchType" returntype="string" access="public" output="false">
		<cfreturn variables.instance.searchtype>
	</cffunction>

	<cffunction name="getBack" returntype="string" access="public" output="false">
		<cfif not structKeyExists(variables.instance,"navback")>
			<cfset createNav()>
		</cfif>
		<cfreturn variables.instance.navback>
	</cffunction>

	<cffunction name="getNext" returntype="string" access="public" output="false">
		<cfif not structKeyExists(variables.instance,"navnext")>
			<cfset createNav()>
		</cfif>
		<cfreturn variables.instance.navnext>
	</cffunction>

	<cffunction name="getNav" returntype="string" access="public" output="false">
		<cfif not structKeyExists(variables.instance,"nav")>
			<cfset createNav()>
		</cfif>
		<cfreturn variables.instance.nav>
	</cffunction>

	<cffunction name="getPageNav" returntype="string" access="public" output="false">
		<cfargument name="navID" type="string" required="false" default="nav#rereplace(createUUID(),"[^[:alnum:]]","","all")#">
		<cfset var pagenav = "">

		<cfif not structKeyExists(variables.instance,"navpage")>
			<cfset createNav()>
		</cfif>

		<cfset pagenav = replace(variables.instance.navpage,"||ID||",arguments.navid,"all")>

		<cfreturn pagenav>
	</cffunction>

	<cffunction name="getFull" returntype="string" access="public" output="false">
		<cfif not structKeyExists(variables.instance,"navfull")>
			<cfset createNav()>
		</cfif>
		<cfreturn variables.instance.navfull>
	</cffunction>

	<cffunction name="doNav" returntype="boolean" access="public" output="false">
		<cfreturn true>
		<cfif variables.instance.count gt variables.instance.size or len(variables.instance.search)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="stripHTML" access="public" returntype="string" output="false">
		<cfargument name="value" type="string" required="true">
	
		<cfset var sReturn = rereplace(trim(value),"<.[^<>]*>","","all")>
		<cfreturn sReturn>
	</cffunction>

	<cffunction name="fixValues" returntype="void" access="private" output="false">
		<cfset var nPos = 0>

		<cfif variables.instance.size lte 0>
			<cfset setSize( 10 )>
		<cfelseif variables.instance.size gt 100>
			<cfset setSize( 100 )>
		</cfif>
		<cfif variables.instance.count lt 0>
			<cfset setCount( 0 )>
		</cfif>
	
		<cfif variables.instance.pos lt 0>
			<cfset setPos( 0 )>
		<cfelseif variables.instance.count gt 0 and variables.instance.pos gt variables.instance.count>
			<cfset nPos = getCount() - (variables.instance.count mod variables.instance.size) - iif(variables.instance.count mod variables.instance.size,de(0),de(variables.instance.size))>
			<cfif nPos lt 0>
				<cfset setPos( 0 )>
			<cfelse>
				<cfset setPos( nPos )>
			</cfif>
		</cfif>
	</cffunction>
</cfcomponent>