<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%

	Dim SQL
	
	Dim MixDSN2		
	
	if Host_Check = "gmtest" Then
		MixDSN2		= "MixMember_t"
	else
		MixDSN2		= "MixMember"
	end if
	
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	
	Dim rPID		:	rPID = Request("Pid")
	Dim rPIDx		:	rPIDx = Request("Pidx")
	Dim PW_CNT		:	PW_CNT = 0
	
	SQL = " Select id_idx " 
	SQL = SQL & " From Member.ChangePassword Where id_idx = " & rPIDx
	 
	DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
	DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	If arrRSMixCnt > -1 Then
	 PW_CNT = 1
	End if
	
	SQL = " Select PlayerID, Name, JuminNo, Sex, nYear, nMonth, nDay, Email, Passwd_Q, Passwd_A, ZipCode, CONCAT(AddressDo,' ',AddressSi ,' ', AddressDong) , AddressEtc, "
	SQL = SQL & " Access, NewsLetter,  JobType, TelePhone1, TelePhone2, TelePhone3, CPhone1, CPhone2, CPhone3,   "
	SQL = SQL & "  ParentName,ParentJuminNo,ParentPhone1,ParentPhone2,ParentPhone3, cast(RegDate as char(19)), cast(LastLoginDate as char(19)), Block" 
	SQL = SQL & " From Member.Player Where id_idx = " & rPIDx 
	 
	DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
	DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
	If arrRSMixCnt > -1 Then
%>
<script>

	$(function($){
	
			$('#Player_form').submit(function(){
				$(this).ajaxSubmit({ beforeSubmit: validationForm, success: Check_val }); 
				return false;
			});
			
			function Check_val(responseText, statusText, xhr, $form)  {     
				alert('<%=MsgExtract("F2_Title035")%>');
			} 
	
			$('#id_idx').val('<%=rPIDx%>');
			$('#Player_id').val('<%=arrRSMix(0,0)%>');
			$('#Pname').val('<%=arrRSMix(1,0)%>');
			$('#Pjumin').val('<%=arrRSMix(2,0)%>');
			$('input:radio[name=sex]').filter('input[value="<%=arrRSMix(3,0)%>"]').attr('checked', 'checked');
			$('#Pyear').val('<%=arrRSMix(4,0)%>');
			$('#Pmonth').val('<%=arrRSMix(5,0)%>');
			$('#Pday').val('<%=arrRSMix(6,0)%>');
			$('#Pemail').val('<%=arrRSMix(7,0)%>');
			sel_option('Ppwrost', Enum_data.M_Question, '<%=arrRSMix(8,0)%>');
			$('#Ppw_lost_ans').val('<%=arrRSMix(9,0)%>');
			$('#Pzipcode').val('<%=arrRSMix(10,0)%>');
			$('#Paddress1').val('<%=trim(arrRSMix(11,0))%>');
			$('#Paddress2').val('<%=arrRSMix(12,0)%>');
			$('#Plevel').val('<%=arrRSMix(13,0)%>');
			$('input:radio[name=Pnewletter]').filter('input[value="<%=arrRSMix(14,0)%>"]').attr('checked', 'checked');
			sel_option('Pjob', Enum_data.JobType, '<%=arrRSMix(15,0)%>');
			$('#Ptel1').val('<%=arrRSMix(16,0)%>');
			$('#Ptel2').val('<%=arrRSMix(17,0)%>');
			$('#Ptel3').val('<%=arrRSMix(18,0)%>');
			$('#Ppon1').val('<%=arrRSMix(19,0)%>');
			$('#Ppon2').val('<%=arrRSMix(20,0)%>');
			$('#Ppon3').val('<%=arrRSMix(21,0)%>');
			$('#Ppname').val('<%=arrRSMix(22,0)%>');
			$('#Ppjumin').val('<%=arrRSMix(23,0)%>');
			$('#Pptel1').val('<%=arrRSMix(24,0)%>');
			$('#Pptel2').val('<%=arrRSMix(25,0)%>');
			$('#Pptel3').val('<%=arrRSMix(26,0)%>');
			$('#Pregdate').val('<%=arrRSMix(27,0)%>');
			$('#Plastdate').val('<%=arrRSMix(28,0)%>');
			
			if ('<%=arrRSMix(29,0)%>' == 'ALLOW'){
				$('#Pret').hide();
			}else{
				$('#Pdel').hide();
			}
			
		$( '.this_win_close' ).click( function() {
			
			$('#ins_form').dialog('close');
			$('#ins_form').empty();
			
		});
		$("#Pw_imsi_save").click(function(){
			var sw_pw_val = $(this).attr('rel');
				$.ajax({
				  url: '/common/class/GMTool/GMT_Player.class.asp?key=REPW&Pidx=<%=rPIDx%>&CK='+sw_pw_val,
				  success: function(data) {
				    if (sw_pw_val == "1")
				    {
				    	$("#Pw_imsi_save").html('&nbsp;<%=MsgExtract("Btn_ImSi")%>');
				    	$("#Pw_imsi_save").attr('rel', '2');
				    	alert('<%=MsgExtract("F2_Title028")%>');
				    	
				    }else{
				    	$("#Pw_imsi_save").html('&nbsp;<%=MsgExtract("Btn_RePW")%>');
				    	$("#Pw_imsi_save").attr('rel', '1');
				    	alert('<%=MsgExtract("F2_Title027")%>');
				    }
				  }
				});
		});
		
		$("#btn_ref, #btn_del").click(function(){
			
			var conf_msg = "";
			var sw_SP_val = $(this).attr('rel');
			
			if(sw_SP_val =='1'){
				conf_msg = '<%=MsgExtract("F2_Title031")%>'; 
			}else{
				conf_msg = '<%=MsgExtract("F2_Title032")%>'; 
			}
			
			if (confirm(conf_msg)){
				$.ajax({
				  url: '/common/class/GMTool/GMT_Player.class.asp?key=PLSP&Pid='+escape('<%=arrRSMix(0,0)%>')+'&Pidx=<%=rPIDx%>&CK='+sw_SP_val,
				  success: function(data) {
				    if (sw_SP_val == "1")
				    {
				    	$('#Pdel').hide();
				    	$('#Pret').show();
				    	alert('<%=MsgExtract("F2_Title029")%>');
				    }else{
				    	$('#Pret').hide();
				    	$('#Pdel').show();
				    	alert('<%=MsgExtract("F2_Title030")%>');
				    }
				    argment_now(0);
				  }
				});
			}
		});
		
		$('#btn_block').click(function(){
			if (confirm('<%=MsgExtract("F2_Title038")%>')){
				window.open('/GMTool/Block_List_GMT.asp?Pid='+escape('<%=arrRSMix(0,0)%>'),'_blank');
			}
		});
		
		$('#find_zipcode').click(function(){
		
			$('#find_zipcode_form').show();
		
		});
		
		$('#zip_select_btn').click(function(){
		
			if ($("#select_zipcode").val() != ""){
				var zip1 = $("#select_zipcode").val();
				var addr = $("#select_zipcode option:selected").attr('rel');
				$('#Pzipcode').val(zip1);
				$('#Paddress1').val(addr);
				$('#Paddress2').focus();
				$('#find_zipcode_form').hide();
			}
			
		});
		
		$('#find_zipcode_btn').click(function(){
			
			var txt_zip = $('#txt_zip_search').val();
			var s_option = "";
			
			if (($.trim(txt_zip) != '') && ($.trim(txt_zip).length >= 2)){
				
				$.getJSON('/common/class/GMTool/GMT_Player.class.asp?key=ZIPCODE&txt_zipSearch='+ $.trim(escape(txt_zip)),	function(data){
					$.each(data.List, function(i,zipcode){
						s_option = s_option + "<option value='"+ unescape(zipcode.N1)+"' rel='"+unescape(zipcode.N2)+"'>"+unescape(zipcode.N3)+"</option>";
					});
					$("#select_zipcode").empty().append(s_option);
				});
				
			}
			
		});
	});
	
	</script>
		<form id="Player_form" method="post" action="/Common/class/GMTool/GMT_Player.class.asp?key=PLMOD" >
			<div class="form_table" style="margin-top: 10px">
				<table border="1" cellspacing="0" summary="Player Info Form">
					<tbody>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title001")%> </th>
							<td colspan=2><div class="item"><input class="field required i_text" title="<%=MsgExtract("F1_Title010")%>" type="text" name="Player_id" id="Player_id" value="" style="width:120px">&nbsp;(<%=rPIDx%>)
							<input type="hidden" id="id_idx" name="id_idx" value="">
							</span></DIV></td>
							<td><%if (PW_CNT > 0) Then%>
								<span class="btn_pack medium icon"><span class="saveas"></span><button TYPE=button id="Pw_imsi_save" rel="1">&nbsp;<%=MsgExtract("Btn_RePW")%></button>
							<%Else%>
								<span class="btn_pack medium icon"><span class="saveas"></span><button TYPE=button id="Pw_imsi_save" rel="2">&nbsp;<%=MsgExtract("Btn_ImSi")%></button>
							<%End If%></td>
						</tr>
						<tr>
							<th scope="row"><%=MsgExtract("F2_Title002")%> *</span> </th>
							<td><div class="item"><input class="field required i_text" title="<%=MsgExtract("F1_Title009")%>" type="text" name="Pname" id="Pname" value="" style="width:120px"></DIV></td>
							<th scope="row"> * <%=MsgExtract("F2_Title003")%></th>
							<td><div class="item"><input class="i_text" type="text" name="Pjumin" id="Pjumin" value=""></div></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title004")%> </th>
							<td><div class="item">
								<input class="i_text" type="radio" name="sex" id="m_sex" value="1"><label for="m_sex"><%=MsgExtract("F2_Title005")%></label> 
								<input class="i_text" type="radio" name="sex" id="f_sex" value="2"><label for="f_sex"><%=MsgExtract("F2_Title006")%></label></DIV>
							</td>
							<th scope="row"> <%=MsgExtract("F2_Title007")%></th>
							<td><div class="item">
								<input class="i_text" type="text" name="Pyear" id="Pyear" value="" size=4 Title="Year">
								<input class="i_text" type="text" name="Pmonth" id="Pmonth" value="" size=2 Title="Month">
								<input class="i_text" type="text" name="Pday" id="Pday" value="" size=2 Title="Day">
							</div></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title008")%> </th>
							<td colspan=3><div class="item"><input class="i_text" type="text" name="Pemail" id="Pemail" value="" style="width:450px"></DIV></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title009")%> </th>
							<td colspan=3><div class="item">
							<select name="Ppwrost" id="Ppwrost">
							</select>
							</DIV></td>
						</tr>
						<tr>
							<th scope="row">  </th>
							<td colspan=3><div class="item"><input class="i_text" type="text" name="Ppw_lost_ans" id="Ppw_lost_ans" value="" style="width:450px"></DIV></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title011")%> *</th>
							<td colspan=3><div class="item"><input class="i_text" type="text" name="Pzipcode" id="Pzipcode" value="" readonly style="width:80px">
								<span class="btn_pack medium icon"><span class="seach"></span><button TYPE=button id="find_zipcode">&nbsp;<%=MsgExtract("Btn_ZipCode")%></button></span></DIV></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title012")%> </th>
							<td colspan=3><div class="item"><input class="i_text" type="text" name="Paddress1" id="Paddress1" value="" readonly style="width:450px"></DIV></td> 
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title013")%> </th>
							<td colspan=3><div class="item"><input class="i_text" type="text" name="Paddress2" id="Paddress2" value="" style="width:450px"></DIV></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title014")%> * </th>
							<td colspan=3><div class="item"><input class="i_text" type="text" name="Plevel" id="Plevel" value="" size="3"></div><br>
							<font class="f_red"><%=MsgExtract("F2_Title015")%></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title016")%> </th>
							<td colspan=3><div class="item">
								<input class="i_text" type="radio" name="Pnewletter" id="m_Pnewletter" value="0"><label for="m_Pnewletter"><%=MsgExtract("F2_Title017")%></label> 
								<input class="i_text" type="radio" name="Pnewletter" id="f_Pnewletter" value="1"><label for="f_Pnewletter"><%=MsgExtract("F2_Title018")%></label></DIV>
							</td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title019")%> </th>
							<td colspan=3><div class="item"><select name="Pjob" id="Pjob">
								</select></DIV></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title020")%> </th>
							<td colspan=3><div class="item">
								<input class="i_text" type="text" name="Ptel1" id="Ptel1" value="">
								<input class="i_text" type="text" name="Ptel2" id="Ptel2" value="" size=4>
								<input class="i_text" type="text" name="Ptel3" id="Ptel3" value="" size=4>
							</DIV></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title021")%> </th>
							<td colspan=3><div class="item">
								<input class="i_text" type="text" name="Ppon1" id="Ppon1" value="">
								<input class="i_text" type="text" name="Ppon2" id="Ppon2" value="" size=4>
								<input class="i_text" type="text" name="Ppon3" id="Ppon3" value="" size=4>
							</DIV></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title022")%></th>
							<td><div class="item"><input class="i_text" type="text" name="Ppname" id="Ppname" value=""></DIV></td>
							<th scope="row"> <%=MsgExtract("F2_Title023")%></th>
							<td><div class="item"><input class="i_text" type="text" name="Ppjumin" id="Ppjumin" value=""></div></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title024")%> </th>
							<td colspan=3><div class="item">
								<input class="i_text" type="text" name="Pptel1" id="Pptel1" value="">
								<input class="i_text" type="text" name="Pptel2" id="Pptel2" value="" size=4>
								<input class="i_text" type="text" name="Pptel3" id="Pptel3" value="" size=4>
							</DIV></td>
						</tr>
						<tr>
							<th scope="row"> <%=MsgExtract("F2_Title025")%></th>
							<td><div class="item"><input class="i_text" type="text" name="Pregdate" id="Pregdate" value="" readonly></DIV></td> 
							<th scope="row"> <%=MsgExtract("F2_Title026")%></th>
							<td><div class="item"><input class="i_text" type="text" name="Plastdate" id="Plastdate" value="" readonly></div></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div style="margin-top:20px"><center>
					<span class="btn_pack medium icon"><span class="modify"></span><button type="submit">&nbsp;<%=MsgExtract("Btn_Modify")%></button></span>&nbsp;&nbsp;
					<span class="btn_pack medium icon" id="Pret"><span class="ref"></span><button TYPE=button id="btn_ref" rel="2">&nbsp;<%=MsgExtract("Btn_Ret")%></button></span>
					<span class="btn_pack medium icon" id="Pdel"><span class="delete"></span><button TYPE=button id="btn_del"  rel="1">&nbsp;<%=MsgExtract("Btn_Delete")%></button></span>&nbsp;&nbsp;
					<span class="btn_pack medium icon"><span class="block"></span><button TYPE=button id="btn_block"  rel="1">&nbsp;<%=MsgExtract("Btn_Block")%></button></span>
			</center></div>
			</form>
			
			<div id="find_zipcode_form" style="position:absolute; top: 234px; left: 130px; display:none;">
				<div class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable" style=" border:2px solid #459e00">
				<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
				   <span id="ui-dialog-title-dialog" class="ui-dialog-title"><%=MsgExtract("F2_Title033")%></span>
				   <a class="ui-dialog-titlebar-close ui-corner-all" href="#"><span class="ui-icon ui-icon-closethick" onclick="javascript:$('#find_zipcode_form').hide()">close</span></a>
				</div>
				<div style="height: 220px; min-height: 109px; width: auto;" class="ui-dialog-content ui-widget-content" id="dialog_zipcode">
				  <center><p><%=MsgExtract("F2_Title034")%></p>
				  <div class="item"><input class="i_text" type="text" name="txt_zip_search" id="txt_zip_search" value="" style="width:178px;"> 
				  <span class="btn_pack medium icon"><span class="seach"></span><button type="button" id="find_zipcode_btn"><%=MsgExtract("Lab_Search")%></button></span>
				 <p></p>
				  <div class="item">
				  		<select name="select_zipcode" id="select_zipcode" style="width:250px;" size=7 class="i_text">
				  			<option><%=MsgExtract("F2_Title036")%></option>
						</select> 
						<br>
				  		<span class="btn_pack medium icon"><span class="sel"></span><button type="button" id="zip_select_btn"><%=MsgExtract("Btn_select")%></button></span>
				  </DIV>
				  </center>
				</div>
				 </div>
			</div>
		</div>
	<%
		End if
	%>
