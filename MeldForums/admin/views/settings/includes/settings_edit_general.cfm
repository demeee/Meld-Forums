<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-General">
		<input type="hidden" name="themebean_blather" value="1">
		<input type="hidden" name="themebean_bla" value="1">
		<input type="hidden" name="themebean_ber" value="1">
		<h3>#local.rc.mmRBF.key('general')#</h3>
		<ul class="form">
			<li class="first">
				<label for="settingsbean_threadsperpage">#local.rc.mmRBF.key('threadsperpage')#<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('threadsperpage','tip')#</span>&nbsp;</a></label>
				<input class="text tiny" type="text" name="settingsbean_threadsperpage" id="settingsbean_threadsperpage" value="#form.settingsbean_threadsperpage#" size="10" maxlength="5" required="true" validate="numeric" message="#local.rc.mmRBF.key('threadsperpage','validation')#" />
			</li>
			<li>
				<label for="settingsbean_postsperpage">#local.rc.mmRBF.key('postsperpage')#<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('postsperpage','tip')#</span>&nbsp;</a></label>
				<input class="text tiny" type="text" name="settingsbean_postsperpage" id="settingsbean_postsperpage" value="#form.settingsbean_postsperpage#" size="10" maxlength="5" required="true" validate="numeric" message="#local.rc.mmRBF.key('postsperpage','validation')#" />
			</li>
			<li>
				<label for="settingsbean_searchmode">#local.rc.mmRBF.key('searchmode')#<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('searchmode','tip')#</span>&nbsp;</a></label>
				<cfif local.rc.pluginConfig.getSetting('dsntype') eq "mssql">
					<cfset loopList = "simple">
				<cfelse>
					<cfset loopList = "simple,fulltext">
				</cfif>
				<select name="settingsbean_searchmode" id="settingsbean_searchmode">
					<cfloop list=#loopList# index="iiX">
						<option value="#iiX#" <cfif form.settingsbean_searchmode eq iiX>selected</cfif>>#local.rc.mmRBF.key('searchmode_#iiX#')#</option>
					</cfloop>
				</select>
			</li>
			<!---
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="settingsbean_values_reindex" id="settingsbean_values_reindex" value="1" />
				<label for="settingsbean_values_reindex">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('reindex','tip')#</span>#local.rc.mmRBF.key('reindex')#</a>
				</label>
			</li>
			--->
		</ul>
	</div>
</cfoutput>