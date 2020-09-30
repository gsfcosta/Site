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
	Dim arrRSMix, arrRSMixCnt, i
	
	Dim q_id_idx, q_Admin, q_Chri, q_Server, q_Block_P, q_Access, q_Subject, q_Content, q_Sdate, q_Edate, q_BlockType, q_PID, Block_m, key
	
	Dim rPID		:	rPID 	= Unescape(Request("Pid"))
	Dim rrPID		:	rrPID 	= unescape(Request("rPid"))
	
	If (trim(rPID) <> "") Then
	
		SQL = " Select id_idx, AdminID, CharName, ServerName, BlockType, Access, Subject, Content, "  
		SQL = SQL & " cast(StartDate as char(10)), cast(EndDate as char(10)), BlockTypeNum, PlayerID " 
		SQL = SQL & " From Member.Distraint Where num ="& rPID
		' Response.Write SQL
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then
			q_id_idx 		= arrRSMix(0,0)
			q_Admin 		= arrRSMix(1,0)
			q_Chri			= arrRSMix(2,0)
			q_Server 		= arrRSMix(3,0)
			q_Block_P 		= arrRSMix(4,0)
			q_Access	 	= arrRSMix(5,0)
			q_Subject 		= arrRSMix(6,0)
			q_Content 		= arrRSMix(7,0)
			q_Sdate 		= arrRSMix(8,0)
			q_Edate 		= arrRSMix(9,0)
			q_BlockType		= arrRSMix(10,0)
			q_PID			= arrRSMix(11,0)
			If(q_Edate = "2200-12-31" or q_Edate = "2222-12-31") Then
				Block_m = q_Edate
			Else
				Block_m = "0"
			End if
			key = "MOD"
		End If
	Else
		q_Sdate			= DateFormat(now(), "yyyy-MM-dd") 
		q_Edate 		= DateFormat(now(), "yyyy-MM-dd")
		Block_m = "0"	
		key = "NEW"
	End If
%>
<script>
	$(function($){
		if ('<%=q_Subject%>' != ''){
			$('#Subject').hide();
		}
		
		$('#Block_Player_form').submit(function(){
				$(this).ajaxSubmit({ beforeSubmit: validationForm, success: Check_val }); 
				return false;
			});
			
		function Check_val(responseText, statusText, xhr, $form)  {  
			if (responseText == '1002') {
				alert('<%=MsgExtract("F3_Title014")%>');
			}else{
				argment_now(0);
				alert('<%=MsgExtract("F1_Title019")%>');
				$('#ins_form').empty().dialog('close');
				
			}
		} 
		
		
		$("#ns_Edate").datepicker({dateFormat: 'yy-mm-dd',changeMonth: true,changeYear: true});
		// 블럭타입 초기화		
		sel_option('BlockType', Enum_data.BlockType2, '<%=q_Block_P%>');
		// 압류사유 초기화.	
		sel_option2('BlockTypeNum', Enum_data.BlockSUBType, '<%=q_Subject%>');
		sel_option('PServer', Enum_data.Server, '');
		//기간의 블럭 조회 초기화.
		$('input:radio[name=rdoDeny]').filter('input[value="<%=Block_m%>"]').attr('checked', 'checked');
		
		//압류사유를 선택하면.
		$('#BlockTypeNum').change(function(){
			if ($('#BlockTypeNum option:selected').attr('rel') =='etc'){
				$('#Subject').val('').show();
			}else{
				$('#Subject').val($('#BlockTypeNum option:selected').text()).hide();
			}
			
		});
		$('input:radio[name=rdoDeny]').click(function(){
			if ( $(this).val() == "0"){
				$('#ns_Edate').val('<%=q_Sdate%>');
			}
			else{
				
				$('#ns_Edate').val($(this).val());
			}
		});
		// 해당 회원이 존재하는지 조회함.
		$('#Player_id').blur(function(){
			var this_id = $(this).val();
			
			if (this_id.length > 3){
				$.ajax({  
					url: '/Common/class/GMTool/GMT_Player.class.asp?key=IDCK&S_item='+escape(this_id),  
					cache: false,  
					success: function(data){
						if (data == '0')
							$('#results').empty().append('<%=MsgExtract("F3_Title014")%>').removeClass("f_gre").addClass("f_red");
						else{    
							$('#results').empty().append('<%=MsgExtract("F1_Title014")%>').removeClass("f_red").addClass("f_gre");
						}  
					}
				});
			}else if(this_id.length > 0){
				alert('<%=MsgExtract("F1_Title016")%>');
				$('#results').empty();

			}else{
				$('#results').empty();
			}
		});
		$('#Btn_ret').click(function(){
				$.ajax({  
					url: '/Common/class/GMTool/GMT_Block_Player.class.asp?key=RET&Player_id=<%=escape(q_PID)%>&PNUM=<%=rPID%>',  
					cache: false,  
					success: function(data){
						if (data == '0000'){
							alert('<%=MsgExtract("F3_Title015")%>');
							argment_now(0);
							$('#ins_form').empty().dialog('close');
						}else{    
							alert('<%=MsgExtract("F3_Title014")%>');
						}  
					}
				});
		});
		
		$('#Btn_block').click(function(){
				//alert($('#BlockType').val());
				$.ajax({  
					url: '/Common/class/GMTool/GMT_Block_Player.class.asp?key=BLOC&Player_id=<%=escape(q_PID)%>&PNUM=<%=rPID%>&BlockType='+$('#BlockType').val(),  
					cache: false,  
					success: function(data){
						if (data == '0000'){
							alert('<%=MsgExtract("F3_Title016")%>');
							argment_now(0);
							$('#ins_form').empty().dialog('close');
						}else{    
							alert('<%=MsgExtract("F3_Title014")%>');
						}  
					}
				});
		});
	});
</script>
<form id="Block_Player_form" method="post" action="/Common/class/GMTool/GMT_Block_Player.class.asp" >
	<div class="form_table" style="margin-top: 10px"><input type="hidden" name="key" value="<%=key%>"> <input type="hidden" name="PNUM" value="<%=rPID%>">
		<table border="1" cellspacing="0" summary="Player Info Form">
			<tbody>
				<%If rPID = "" Then%>
					<tr>
						<th scope="row" ><%=MsgExtract("F3_Title001")%> </th>
						<td><div class="item"><input class="field required i_text" title="<%=MsgExtract("F1_Title010")%>"  type="text" name="Player_id" id="Player_id" value="<%=rrPID%>">&nbsp;<span id="results"></span></DIV></td>
					</tr>
					<tr>
						<th scope="row"><%=MsgExtract("F3_Title002")%></span> </th>
						<td><div class="item"><input class="i_text" type="text" name="Pchname" id="Pchname" value=""></DIV></td>
					</tr>
					<tr>
						<th scope="row"><%=MsgExtract("F3_Title003")%> </th>
						<td><select name="PServer" id="PServer"></select></td>
					</tr>
				
				<%Else%>
					<tr>
						<th scope="row"><%=MsgExtract("F3_Title011")%></th>
						<td><%=q_Admin%></td>
					</tr>
					<tr>
						<th scope="row"><%=MsgExtract("F3_Title001")%></th>
						<td><%=q_PID%><input type="hidden" name="Player_id" id="Player_id" value="<%=q_PID%>"></td>
					</tr>
					<tr>
						<th scope="row"><%=MsgExtract("F3_Title003")%></th>
						<td><%=q_Server%></td>
					</tr>
					<tr>
						<th scope="row"><%=MsgExtract("F3_Title002")%></th>
						<td><%=q_Chri%></td>
					</tr>
				
				<%End If%>
				<tr>
					<th scope="row"><%=MsgExtract("F3_Title004")%> </th>
					<td><div class="item"><select id="BlockType" name="BlockType"></select></div></td>
				</tr>
				<tr>
					<th scope="row"><%=MsgExtract("F3_Title005")%></th>
					<td><div class="item"><select id="BlockTypeNum" name="BlockTypeNum"></select><input class="i_text" type="text" name="Subject" id="Subject" value="<%=q_Subject%>" style="width:250px"></div></td>
				</tr>
				<tr>
					<th scope="row" style="width:150px"><%=MsgExtract("F3_Title006")%></th>
					<td><textarea class="i_text" name="Pcontent" style="width:450px;height:250px;"><%=q_Content%></textarea></td>
				</tr>
				<tr>
					<th scope="row" rowspan=2><%=MsgExtract("F3_Title007")%></th>
					<td ><div class="item">
							<input type="text" id="ns_Sdate" name="ns_Sdate" value="<%=q_Sdate%>" class="i_text" style="width:70px">-<input type="text" id="ns_Edate" name="ns_Edate" value="<%=q_Edate%>" class="i_text" style="width:70px">
					</DIV></td>
				</tr>
				<tr>
					
					<td ><div class="item">
						<input class="i_text" type="radio" name="rdoDeny" id="N_Block" value="0" selected><label for="N_Block"><%=MsgExtract("F3_Title008")%></label> 
						<input class="i_text" type="radio" name="rdoDeny" id="F_Block" value="2200-12-31"><label for="F_Block"><%=MsgExtract("F3_Title009")%></label>
						<input class="i_text" type="radio" name="rdoDeny" id="C_Del" value="2222-12-31"><label for="C_Del"><%=MsgExtract("F3_Title010")%></label>
					</DIV></td>
				</tr>				
			</tbody>
		</table>
	</div>
	<div style="margin-top:20px"><center>
			<%if rPID = "" Then%>
			<span class="btn_pack medium icon"><span class="saveas"></span><button type="submit">&nbsp;<%=MsgExtract("Btn_Save")%></button></span>&nbsp;&nbsp;
			<%else%>
			<span class="btn_pack medium icon"><span class="modify"></span><button type="submit">&nbsp;<%=MsgExtract("Btn_Modify")%></button></span>&nbsp;&nbsp;
				<%if q_Access = "ALLOW" Then%>
					<span class="btn_pack medium icon"><span class="block"></span><button type="button" id="Btn_block">&nbsp;<%=MsgExtract("Btn_Block")%></button></span>&nbsp;&nbsp;
				<%Else%>	
					<span class="btn_pack medium icon"><span class="ref"></span><button type="button" id="Btn_ret">&nbsp;<%=MsgExtract("Btn_Ret_Block")%></button></span>&nbsp;&nbsp;
				<%End if%>
			<%End if%>
			
	</center></div>
</form>
