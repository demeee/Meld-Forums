<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Options">
		<h3>#local.rc.mmRBF.key('options')#</h3>
		<ul class="form">
			<li class="first">
				<label for="conferencebean_orderno">#local.rc.mmRBF.key('orderno')#<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('orderno','tip')#</span>&nbsp;</a></label>
				<input class="text tiny" type="text" name="conferencebean_orderno" id="conferencebean_orderno" value="#form.conferencebean_orderno#" size="30" maxlength="100" required="true" validate="string" message="#local.rc.mmRBF.key('conferencename','validation')#" />
			</li>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="conferencebean_isactive" id="conferencebean_isactive" value="1" <cfif form.conferencebean_isactive>CHECKED</cfif>/>
				<label for="conferencebean_isactive">#local.rc.mmRBF.key('isactive')#<a href="##" class="tooltip"><span>#local.rc.mmRBF.key('isactive','tip')#</span>&nbsp;</a></label>
			</li>
		</ul>
	</div>
</cfoutput>