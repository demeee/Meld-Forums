<cffile action="read" file="#expandPath('.\')#\..\resourceBundles\en.properties" variable="rb" >

<cfset rb = rereplaceNoCase(rb,"\t\t\##\##\##.[^\##\##\##]*\##\##\##\n","","all") />

<cffile action="write" file="#expandPath('.\')#\..\resourceBundles\en.properties" output="#rb#" >

