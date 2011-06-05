<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Options">
		<h3>#local.rc.mmRBF.key('options')#</h3>
		<ul class="form">
			<cfif not local.rc.configurationBean.getIsMaster()>
			<li class="first checkbox">
				<input class="checkbox" type="checkbox" name="configurationbean_isactive" id="configurationbean_isactive" value="1" <cfif form.configurationbean_isactive>CHECKED</cfif> />
				<label for="configurationbean_isactive">#local.rc.mmRBF.key('active')#</label>
			</li>
			<li class="checkbox padded">
			<cfelse>
			<input type="hidden" name="configurationbean_isactive" id="configurationbean_isactive" value="1" />
			<li class="checkbox first">
			</cfif>
				<input class="checkbox" type="checkbox" name="configurationbean_doavatars" id="configurationbean_doavatars" value="1" <cfif form.configurationbean_doavatars>CHECKED</cfif> />
				<label for="configurationbean_doavatars">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('AllowAvatars','tip')#</span>#local.rc.mmRBF.key('AllowAvatars')#</a>
				</label>
			</li>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="configurationbean_doattachments" id="configurationbean_doattachments" value="1" <cfif form.configurationbean_doattachments>CHECKED</cfif> />
				<label for="configurationbean_doattachments">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('Allowattachments','tip')#</span>#local.rc.mmRBF.key('Allowattachments')#</a>
				</label>
			</li>
			<li>
				<label for="configurationbean_allowattachmentextensions">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('allowedextensionslist','tip')#</span>#local.rc.mmRBF.key('allowedextensionslist')#</a>
				</label>
				<input class="text" type="text" name="configurationbean_allowattachmentextensions" id="configurationbean_allowattachmentextensions" value="#form.configurationbean_allowattachmentextensions#" size="100" maxlength="250" required="true" validate="string" message="#local.rc.mmRBF.key('allowedextensionslist','validation')#" />
				<div>(#local.rc.mmRBF.key('masterallowedextensions')#: #local.rc.settingsBean.getAllowedExtensions()#)</div>
			</li>
			<li class="last">
				<label for="configurationbean_filesizeLimit">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('filesizeLimit','tip')#</span>#local.rc.mmRBF.key('filesizeLimit')#</a>
				</label>
				<input class="text tiny" type="text" name="configurationbean_filesizeLimit" id="configurationbean_filesizeLimit" value="#form.configurationbean_filesizeLimit#" size="20" maxlength="5" required="true" validate="number" message="#local.rc.mmRBF.key('filesizeLimit','validation')#" />
			</li>
		</ul
		<ul class="form">
			<fieldset>
				<legend>#local.rc.mmRBF.key('imageattachments')#</legend>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="configurationbean_doInlineImageAttachments" id="configurationbean_doInlineImageAttachments" value="1" <cfif form.configurationbean_doInlineImageAttachments>CHECKED</cfif> />
				<label for="configurationbean_doInlineImageAttachments">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('InlineImageAttachments','tip')#</span>#local.rc.mmRBF.key('InlineImageAttachments')#</a>
				</label>
			</li>
			<li>
				<label for="configurationbean_ImageWidthLimit">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('ImageWidthLimit','tip')#</span>#local.rc.mmRBF.key('ImageWidthLimit')#</a>
				</label>
				<input class="text tiny" type="text" name="configurationbean_ImageWidthLimit" id="configurationbean_ImageWidthLimit" value="#form.configurationbean_ImageWidthLimit#" size="20" maxlength="5" required="true" validate="number" message="#local.rc.mmRBF.key('ImageWidthLimit','validation')#" />
			</li>
			<li class="last">
				<label for="configurationbean_ImageHeightLimit">
					<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('ImageHeightLimit','tip')#</span>#local.rc.mmRBF.key('ImageHeightLimit')#</a>
				</label>
				<input class="text tiny" type="text" name="configurationbean_ImageHeightLimit" id="configurationbean_ImageHeightLimit" value="#form.configurationbean_ImageHeightLimit#" size="20" maxlength="5" required="true" validate="number" message="#local.rc.mmRBF.key('ImageHeightLimit','validation')#" />
			</li>
			</fieldset>
		</ul>
	</div>
</cfoutput>