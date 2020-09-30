<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	
	
	Dim SQL

	Dim MixDSN2		
	
	if Host_Check = "gmtest" Then
		MixDSN2		= "MixSdata_t"
	else
		MixDSN2		= "MixSdata"
	end if
	
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt

%>

<script>
	
	$(function($){
		
		//캐릭터
		sel_option('charTYPE', Enum_data.CHAR_Type, '0');
		$('#charhead').val(Enum_data.CHAR_Type[0].N3[0].S1);
		$('#charbody').val(Enum_data.CHAR_Type[0].N3[1].S1);
		$('#charfoot').val(Enum_data.CHAR_Type[0].N3[2].S1);
		
		Char_Socket_CK();
		
		//해당 서버에 남는 캐릭터 소캣이 있는지 확인한다.
	
		$('#charname').blur(function(){
			var this_id = $(this).val();
			
			if (this_id.length > 2){
				$.ajax({  
					url: '/Common/Class/GMTool/GMT_Character.class.asp?key=CHRCK&Server='+ $("select[name=Server] > option:selected").val() +'&S_item='+escape(this_id),  
					cache: false,  
					success: function(data){
						if (data != '0'){
							$('#results').empty().append('<b>'+this_id +'</b> <%=MsgExtract("F5_Title040")%>').removeClass("f_gre").addClass("f_red");
							emp_char();
						}else{    
							$('#results').empty().append('<%=MsgExtract("F5_Title041")%>').removeClass("f_red").addClass("f_gre");
						}  
					}
				});
			}else if(this_id.length > 0){
				alert('<%=MsgExtract("F1_Title042")%>');
				$('#results').empty();
				emp_char();

			}else{
				$('#results').empty();
				emp_char();
			}
		});
		
		// 캐릭터 레벨 초기화.
		var level_i = 1;
		var level_opt = '';
		for( level_i; level_i < 201; level_i++){
			level_opt = level_opt + "<option value='"+ level_i +"'>"+level_i+"</option>";
		}
		$("#charlevel").empty().append(level_opt);
		$("#charlevel option[value=1]").attr('selected', 'selected');
		
		$("#charlevel").change(function(){
			var exp_val = Character_level($(this).val() -1 ) + 1 ;
			$("#charExp").val(exp_val);
			$("#EXP_Lavel1").text(exp_val);
			$("#EXP_Lavel2").text(Character_level($(this).val()));
			$("#charemp").val($(this).val() * 5);
			$("#charSkillP").val($(this).val() -1);
		});
		$("#charTYPE").change(function(){
		
			$('#charhead').val(Enum_data.CHAR_Type[parseInt($(this).val())].N3[0].S1);
			$('#charbody').val(Enum_data.CHAR_Type[parseInt($(this).val())].N3[1].S1);
			$('#charfoot').val(Enum_data.CHAR_Type[parseInt($(this).val())].N3[2].S1);
		
		});
		//캐릭터추가 버튼을 누르면
		$('#Character_Add_form').submit(function(){
			if (confirm('<%=MsgExtract("F1_Title043")%>')){
			$(this).ajaxSubmit({ beforeSubmit: validationForm2, success: Chara_Reult_val });
			} 
			return false;
		});
		function Chara_Reult_val(responseText, statusText, xhr, $form)  {     
			if ($.trim(responseText) == '1001'){ 
				alert('<%=MsgExtract("F1_Title013")%>');
			}else if ($.trim(responseText) == '0000'){ 
				alert('<%=MsgExtract("F1_Title019")%>');
				location.reload();
			}
		} 
		$("select[name=Server]").change(function(){
			Char_Socket_CK();
			emp_char();
			$("#results").empty();
		});
		
		//서버를 변경할때마다 남는 소캣을 가져온다.
		function Char_Socket_CK(){
			$.getJSON('/Common/Class/GMTool/GMT_Character.class.asp?key=CHEMSOCK&Server='+ $("select[name=Server] > option:selected").val() +'&id_idx='+ $("#Char_ID_IDX").val() ,	function(data){
				
				if (data.CNT == 0){
					$("#charSocket").empty();
					$("#a_message").empty().html("<%=MsgExtract("F5_Title037")%>");
					$("#btn_save").attr("disabled","disabled");
				}else{
					sel_option('charSocket', data.List, '');
					$("#a_message").empty();
					$("#btn_save").removeAttr("disabled");
				}
				
			});
		}
		
		
	 });
	 
	 function emp_char(){
			$('#charname').val('');
		}
</script>
	<style>
		.tbl_type th{height:20px;border : 0px;text-align:right; padding-right:10px; color:#444;}
		.tbl_type td{height:20px;border : 0px;}
	 	#char_table select{width : 80px;}
	</style>
			<form id="Character_Add_form" method="post" action="/Common/class/GMTool/GMT_Character.class.asp?key=CHADD" >
			<div class="ui-widget-header char_title2"> <font class='f_blu'><%=MsgExtract("F5_Title000")%></font></div>
			<input type="hidden" id="id_idx" name="id_idx" value="<%=rid_idx%>">
			
			<table border="0" cellspacing="0" summary="New Character Form" class="tbl_type" id="char_table">
				<colgroup>
	 			 	<col width="150"><col width="250"><col width="150"><col width="250"><col width=*>
				</colgroup>
				<thead class="toolbar">
				<tr>
					<td colspan="5">
						<div class="fl2">
						<span class="btn_pack medium icon"><span class="saveas"></span><button type="submit" id="btn_save">&nbsp;<%=MsgExtract("Btn_Character")%> <%=MsgExtract("Btn_Save")%></button></span>
						</div>
					</td>
				</tr> 
			</thead>
				<tbody>
				
				  <tr >
				    <th scope="row" style="padding-top:15px">서버선택</th>
				    <td colspan=3 style="padding-top:15px">
				      <div class="item" ><% Server_Select %><span id="a_message"  class='f_red'></span></div>
				    </td>
				    <td></td>
				  </tr>
				   <tr >
				    <th scope="row">캐릭터선택</th>
				    <td colspan=3>
				      <div class="item"><select id="charTYPE" name="charTYPE"></select>
				      </div>
				    </td>
				    <td></td>
				  </tr>
				  <tr >
				    <th scope="row">캐릭터 소켓선택</th>
				    <td colspan=3>
				      <div class="item"><select id="charSocket" name="charSocket"></select>
				      </div>
				    </td>
				    <td></td>
				  </tr>
				  <tr >
				    <th scope="row"><%=MsgExtract("F5_Title001")%></th>
				    <td colspan=3>
				      <div class="item"><input type="text" id="charname" name="charname" value="<%=rC_name%>" class="field required" title="<%=MsgExtract("F5_Title039")%>">&nbsp;&nbsp;<span id="results"></span></div>
				    </td>
				    <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title004")%></th>
				    <td colspan=3>
				      <div class="item"><select id="charlevel" name="charlevel"></select></div>
				    </td>
				    <td></td>
				  </tr>
				            
				  <tr>
				    <th><%=MsgExtract("F5_Title005")%></th>
				    <td colspan=3>
				      <div class="item"><input TYPE="text" id="charExp" name="charExp" value="1" style="margin-bottom:5px"><br><label id="EXP_Lavel1">1</label>~ <label id="EXP_Lavel2">14</label></div>
				    </td>
				    <td></td>
				  </tr>       
				  <tr>
				    <th><%=MsgExtract("F5_Title006")%></th>
				    <td colspan=3>
				      <div class="item"><input type="text" id="charemp" name="charemp" value="5" size=4 maxlength=4></div>
				    </td>
				    <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title007")%></th>
				    <td>
				      <div class="item"><input type="text" id="charadb" name="charadb" value="0" size=4 maxlength=2>&nbsp;&nbsp;<span class="f_blu"><%=MsgExtract("F5_Title038")%></span></div>
				    </td>
				    <th><%=MsgExtract("F5_Title013")%></th>
				    <td>
				      <div class="item"><input type="text" id="charGP" name="charGP" value="0"  maxlength=10></div>
				    </td>
				    <td></td>
				  </tr>
				   <tr>
				    <th><%=MsgExtract("F5_Title017")%></th>
				    <td>
				      <div class="item"><input type="text" id="charSkillP" name="charSkillP" value="0" size=4 maxlength=5></div>
				    </td>
				  
				  
				    <th><%=MsgExtract("F5_Title010")%></th>
				    <td>
				      <div class="item"><input type="text" id="charhead" name="charhead" value="" size=4 maxlength=5></div>
				    </td>
				      <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title011")%></th>
				    <td>
				      <div class="item"><input type="text" id="charbody" name="charbody" value="" size=4 maxlength=5></div>
				    </td>
				  
				    <th><%=MsgExtract("F5_Title012")%></th>
				    <td>
				      <div class="item"><input type="text" id="charfoot" name="charfoot" value="" size=4 maxlength=5></div>
				    </td>
				       <td></td>
				  </tr>
				   <tr>
				    
				 
				    <th><%=MsgExtract("F5_Title014")%></th>
				    <td>
				      <div class="item"><input type="text" id="charMoveS" name="charMoveS" value="4" size=4 maxlength=5></div>
				    </td>
				    <th><%=MsgExtract("F5_Title015")%></th>
				    <td >
				      <div class="item"><input type="text" id="charAttS" name="charAttS" value="1700" size=4 maxlength=5></div>
				    </td>
				    <td></td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title016")%></th>
				    <td colspan=3>
				      <div class="item"><input TYPE="text" id="charSkillS" name="charSkillS" value="5000" size=4 maxlength=5></div>
				    </td>
				    
				    <td></td>
				  </tr>
					
					<tr>
				    <th><%=MsgExtract("F5_Title018")%></th>
				    <td>
				      <div class="item"><input type="text" id="charStra" name="charStra" value="4" size=4 maxlength=5></div>
				    </td>
				  
				    <th><%=MsgExtract("F5_Title019")%></th>
				    <td>
				      <div class="item"><input type="text" id="charDext" name="charDext" value="4" size=4 maxlength=5></div>
				    </td>
				      <td></td>
				  </tr>
				  
				  <tr>
				    <th><%=MsgExtract("F5_Title020")%></th>
				    <td>
				      <div class="item"><input type="text" id="charAim" name="charAim" value="4" size=4 maxlength=5></div>
				    </td>
				  
				    <th><%=MsgExtract("F5_Title021")%></th>
				    <td>
				      <div class="item"><input type="text" id="charLuck" name="charLuck" value="4" size=4 maxlength=5></div>
				    </td>
				    <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title022")%></th>
				    <td>
				      <div class="item"><input type="text" id="charAP" name="charAP" value="3" size=4 maxlength=5></div>
				    </td>
				    <th><%=MsgExtract("F5_Title023")%></th>
				    <td>
				      <div class="item"><input type="text" id="charDP" name="charDP" value="3" size=4 maxlength=5></div>
				    </td>
				    <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title024")%></th>
				    <td>
				      <div class="item"><input type="text" id="charHC" name="charHC" value="1" size=4 maxlength=5></div>
				    </td>

				    <th><%=MsgExtract("F5_Title025")%></th>
				    <td>
				      <div class="item"><input type="text" id="charHD" name="charHD" value="4" size=4 maxlength=5></div>
				    </td>
				    <td></td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title026")%></th>
				    <td>
				      <div class="item"><input type="text" id="charNHP" name="charNHP" value="100" size=4 maxlength=5></div>
				    </td>
				  
				    <th><%=MsgExtract("F5_Title027")%></th>
				    <td>
				      <div class="item"><input TYPE="text" id="charNMP" name="charNMP" value="120" size=4 maxlength=5></div>
				    </td>
				      <td></td>
				  </tr>       
				  <tr>
				    <th style="padding-bottom:10px"><%=MsgExtract("F5_Title028")%></th>
				    <td>
				      <div class="item"><input type="text" id="charMHP" name="charMHP" value="100" size=4 maxlength=5></div>
				    </td>
				  
				    <th ><%=MsgExtract("F5_Title029")%></th>
				    <td >
				      <div class="item"><input type="text" id="charMMP" name="charMMP" value="120" size=4 maxlength=5></div>
				    </td>
				      <td ></td>
				  </tr>


				 </tbody>  
				  
				
			</table>
			</form>
