<cfsilent>
	<cfset rc = attributes.local.rc />
	<cfset local = StructNew() />
	<cfset attributes.eventContent = StructNew() />

</cfsilent><cfoutput>
	<table class="navsearchblock">
	<form class="forumsform" id="navSearchForm" action="#rc.MFBean.getForumWebRoot()#searchresults/" method="post">
	<tr>
		<th class="searchcriteria">
			<input class="input" id="k" name="k" size="25" maxlength="25" />
		</th>
		<th class="searchtype">
			<select class="select" name="st">
				<option value="OR">#rc.mmRBF.key('searchany')#</option>
				<option value="AND">#rc.mmRBF.key('searchall')#</option>
				<option value="EXACT">#rc.mmRBF.key('searchexact')#</option>
			</select>
		</th>
		<th class="searchsubmit">
			<input type="submit" class="submit" name="#rc.mmRBF.key('search')#" value="#rc.mmRBF.key('search')#" />
		</th>
	</tr>
	</form>
</table>
</cfoutput>