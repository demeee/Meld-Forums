<cfsilent>
	<cfset rc = attributes.local.rc />
	<cfset local = StructNew() />

	<cfset attributes.threadBean			= rc.threadBean />
	<cfset attributes.postBean				= rc.postBean />
	<cfset attributes.configurationBean		= rc.configurationBean />


	<cfparam name="form.action" default="">
	<cfparam name="form.title" default="#attributes.threadbean.getTitle()#">
	<cfparam name="form.message" default="#attributes.postBean.getMessage()#">
</cfsilent><cfoutput>

<cfdump var="#rc.postBean.getMemento()#">

<form class="forumsform" id="editthreadform" action="#rc.MFBean.getEditorAction( request.section,request.item,attributes.threadbean.getThreadID() )#" method="post" name="editthreadform" onsubmit="return validate(this);" enctype="multipart/form-data">
<div id="hiddenFields">
	<input type="hidden" id="threadID" name="threadID" value="#attributes.threadbean.getThreadID()#">
	<input type="hidden" id="forumID" name="forumID" value="#attributes.threadbean.getForumID()#">
</div>
<div id="formFields">
	<fieldset>
		<legend>#rc.mmRBF.key('moderate')#</legend>
	<ul>
		<li class="req">
			<label for="txtTitle">#rc.mmRBF.key('title')#</label>
			<input class="text" type="text" maxlength="100" id="txtTitle" name="title" value="#form.title#" required="true" message="#rc.mmRBF.key('title')# #rc.mmRBF.key('isrequired')#">
		</li>
		<li>
			<label for="threadType">#rc.mmRBF.key('ThreadType')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('ThreadType','tip')#</span></a></label><br />
			<select name="threadType" id="threadType" class="SELECT">
				<option value="0">#rc.mmRBF.key('none')#</option>
				<option value="1"<cfif attributes.threadbean.getTypeID() eq 1> selected</cfif>>#rc.mmRBF.key('sticky')#</option>
			</select>
		</li>
		<li id="iMessageContainer" class="checkbox">
			<input name="doAddAdminMessage" id="doAddAdminMessage" type="CHECKBOX" value="1" <cfif len(attributes.threadbean.getAdminMessage())>CHECKED</cfif>>
			<label for="txtMessage">
				#rc.mmRBF.key('adminmessage')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('adminmessage','tip')#</span></a>
			</label>
				<div class="messageblock" id="iMessage">
					<textarea id="txtMessage" name="message" rows="5" class="textarea" style="width: 95%"></textarea>
				</div>
		</li>
		<li class="checkbox">
			<input name="doSetClosed" class="checkbox" id="doSetClosed" type="CHECKBOX" value="1" <cfif attributes.threadbean.getisClosed()>CHECKED</cfif>>
			<label for="doSetClosed">
				#rc.mmRBF.key('Closed')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('threadClosed','tip')#</span></a>
			</label>
		</li>
		<li class="checkbox">
			<input class="checker" name="doSetActive" id="doSetActive" type="CHECKBOX" value="1" <cfif attributes.threadbean.getIsActive()>CHECKED</cfif>>
			<label for="doSetActive">
				#rc.mmRBF.key('active')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('threadactive','tip')#</span></a>
			</label>
		</li>
		<li class="checkbox">
			<input name="doSetAnnouncement" class="checkbox" id="doSetAnnouncement" type="CHECKBOX" value="1" <cfif attributes.threadbean.getIsAnnouncement()>CHECKED</cfif>>
			<label for="doSetAnnouncement">
				#rc.mmRBF.key('Announcement')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('threadAnnouncement','tip')#</span></a>
			</label>
		</li>
		<li class="checkbox">
			<input name="doSetDisabled" id="doSetDisabled" type="CHECKBOX" value="1" <cfif attributes.threadbean.getisDisabled()>CHECKED</cfif>>
			<label for="doSetDisabled">
				#rc.mmRBF.key('disabled')#<a href="##" class="tooltip">&nbsp;<span>#rc.mmRBF.key('threaddisabled','tip')#</span></a>
			</label>
		</li>
	</ul>
	</fieldset>
	<div class="buttonbar">
		<input id="submit" class="submit" name="btAction" type="button" value="#rc.mmRBF.key('cancel')#" onclick="history.go(-1);"/>
		<input id="submit" class="submit" name="btAction" type="submit" value="#rc.mmRBF.key('submit')#"/>
		<cfif rc.MFBean.userHasFullPermissions()>
			<input id="submit" class="delete" name="btAction" type="submit" value="#rc.mmRBF.key('delete')#" onclick="return doConfirmDelete('editthreadform','#rc.mmRBF.key('deletethreadmsg')#','btActionConfirm','confirm');"/>
			<input type="hidden" name="btActionConfirm" id="btActionConfirm" value="" />
		</cfif>
	</div>
</div>
</form>
</cfoutput>