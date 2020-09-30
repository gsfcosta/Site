<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim rC_name		:	rC_name			= trim(unescape(Request("C_name")))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim cn
	
	Dim SQL
	Dim MixDSN2		:	MixDSN2		= rServer
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt

		SQL = "Select name, hero_type, now_zone_idx, now_zone_x,  now_zone_y, class, revive_zone_idx, baselevel , exp, abil_freepoint, avatar_head,avatar_body, avatar_foot, " 
		SQL = SQL & " gold, speed_move, speed_attack, speed_skill, skill_point,  str, dex, aim, luck, ap, dp," 
		SQL = SQL & " hc, hd, hp, mp, maxhp, maxmp, res_fire, res_water, res_earth, res_wind, res_devil,  cast(regdate as char(16)),serial"
		SQL = SQL & " From u_hero where id_idx = " & rid_idx &" and hero_order = " &rSocket
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
%>

<script>
	<%If rSocket <> "" Then%>
	$(function($){
		//캐릭터 수정버튼 클릭
		$('#Character_form').submit(function(){
			if (confirm('<%=MsgExtract("F6_Title001")%>')){
			$(this).ajaxSubmit({ beforeSubmit: validationForm, success: Chara_Reult_val });
			} 
			return false;
		});
		//캐릭터 삭제버튼 클릭
		$('#char_del_btn').click(function(){
			if (confirm('<%=MsgExtract("F1_Title044")%>')){
				$.ajax({  
					url: '/Common/class/GMTool/GMT_Character.class.asp?key=CHDEL&Server=<%=rServer%>&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>',  
					cache: false,  
					success: function(data){
						if (data == '0000'){
							alert('<%=MsgExtract("F6_Title011")%>');
							location.reload();
						}  
					}
				});
			
			}
		});
		
		function Chara_Reult_val(responseText, statusText, xhr, $form)  {     
			alert('<%=MsgExtract("F2_Title035")%>');
		} 
	
	
		var level_i = 1;
		var level_opt = '';
		$("#btn_mod").removeAttr("disabled");
		
	// 캐릭터 레벨 초기화.
		for( level_i; level_i < 201; level_i++){
			level_opt = level_opt + "<option value='"+ level_i +"'>"+level_i+"</option>";
		}
		$("#charname").val('<%=arrRSMix(0,0)%>');
		
		$("#charlevel").empty().append(level_opt);
		$("#charlevel option[value=<%=arrRSMix(7,0)%>]").attr('selected', 'selected');
		
		$("#charType").html("<img src='/images/icon_character_<%=arrRSMix(1,0)%>.gif' align='absmiddle' />");

		$("#charExp").val(<%=arrRSMix(8,0)%>);
		$("#EXP_Lavel1").text(Character_level($("#charlevel").val() - 1 ) + 1);
		$("#EXP_Lavel2").text(Character_level($("#charlevel").val())); 
		$("#zone_point").text(s_zone_search('<%=arrRSMix(2,0)%>') + ' (X : <%=arrRSMix(3,0)%>, Y : <%=arrRSMix(4,0)%>), Zone Number : <%=arrRSMix(2,0)%>');
		$("#charemp").val(<%=arrRSMix(9,0)%>); 
		$("#charadb").val('<%=arrRSMix(5,0)%>');
		$("#charhead").val('<%=arrRSMix(10,0)%>');
		$("#charbody").val('<%=arrRSMix(11,0)%>');
		$("#charfoot").val('<%=arrRSMix(12,0)%>');
		$("#charGP").val('<%=arrRSMix(13,0)%>');
		$("#charMoveS").val('<%=arrRSMix(14,0)%>');
		$("#charAttS").val('<%=arrRSMix(15,0)%>');
		$("#charSkillS").val('<%=arrRSMix(16,0)%>');
		$("#charSkillP").val('<%=arrRSMix(17,0)%>');
		$("#charStra").val('<%=arrRSMix(18,0)%>');
		$("#charDext").val('<%=arrRSMix(19,0)%>');
		$("#charAim").val('<%=arrRSMix(20,0)%>');
		$("#charLuck").val('<%=arrRSMix(21,0)%>');
		$("#charAP").val('<%=arrRSMix(22,0)%>');
		$("#charDP").val('<%=arrRSMix(23,0)%>');
		$("#charHC").val('<%=arrRSMix(24,0)%>');
		$("#charHD").val('<%=arrRSMix(25,0)%>');
		$("#charNHP").val('<%=arrRSMix(26,0)%>');
		$("#charNMP").val('<%=arrRSMix(27,0)%>');
		$("#charMHP").val('<%=arrRSMix(28,0)%>');
		$("#charMMP").val('<%=arrRSMix(29,0)%>');
		/*$("#charresfi").val('<%=arrRSMix(30,0)%>');
		$("#charreswa").val('<%=arrRSMix(31,0)%>');
		$("#charresea").val('<%=arrRSMix(32,0)%>');
		$("#charreswi").val('<%=arrRSMix(33,0)%>');
		$("#charresev").val('<%=arrRSMix(34,0)%>');*/
		$("#regdate").text('<%=arrRSMix(35,0)%>');
		$("#serial").text('<%=arrRSMix(36,0)%>');
	
		$("#charlevel").change(function(){
			if ($(this).val() >= $("#ori_level").val()){
				//현재레벨보다 큰 레벨을 선탁했을경우  현재 여유수치 + ((변경레벨 - 현제레벨) * 5) 해준다.
				$("#charemp").val( parseInt($("#ori_smp").val()) + ((parseInt($(this).val()) -  parseInt($("#ori_level").val())) * 5));
				$("#charStra").val('<%=arrRSMix(18,0)%>');
				$("#charDext").val('<%=arrRSMix(19,0)%>');
				$("#charAim").val('<%=arrRSMix(20,0)%>');
				$("#charLuck").val('<%=arrRSMix(21,0)%>');
			}else{
				//여유수치는 해당 레벨 * 5이다.
				$("#charemp").val( $(this).val() * 5);
				//현재 레벨보다 작은 값이면 해당 값(힘, 민 , 명중, 행운)을 초기화 시켜준다.
				$("#charStra").val('4');
				$("#charDext").val('4');
				$("#charAim").val('4');
				$("#charLuck").val('4');
			}
			$("#EXP_Lavel1").text(Character_level($(this).val() -1 ) + 1);
			$("#EXP_Lavel2").text(Character_level($(this).val()));
		});
		
	 });
	 
	 <%End if%>
</script>
	<style>
		.tbl_type th{border : 0px;height:20px;text-align:right; padding-right:10px; color:#444;}
		.tbl_type td{border : 0px;height:20px;}
	</style>
			<form id="Character_form" method="post" action="/Common/class/GMTool/GMT_Character.class.asp?key=CHMOD" >
			<div class="ui-widget-header char_title2"> <font class='f_blu'><%=MsgExtract("TOOL_SM1_1_Title")%></font></div>
			<input type="hidden" id="Server" name="Server" value="<%=rServer%>">
			<input type="hidden" id="id_idx" name="id_idx" value="<%=rid_idx%>">
			<input type="hidden" id="Socket" name="Socket" value="<%=rSocket%>">
			
			<table border="0" cellspacing="0" summary="New Character Form" class="tbl_type">
				<colgroup>
	 			 	<col width="150"><col width="250"><col width="150"><col width="250"><col width=*><input type="hidden" name="ori_smp" id="ori_smp"  value="<%=arrRSMix(9,0)%>"><input type="hidden" id="ori_level" name="ori_level" value="<%=arrRSMix(7,0)%>">
				</colgroup>
				<thead class="toolbar">
				<tr>
					<td colspan="5">
						<div class="fl2">
						<span class="btn_pack medium icon"><span class="modify"></span><button type="submit" id="btn_mod" disabled="disabled">&nbsp;<%=MsgExtract("Btn_Character")%> <%=MsgExtract("Btn_Modify")%></button></span>
						<%If rSocket <> "" Then%>
						<span class="btn_pack medium icon"><span class="delete"></span><button type="button" id="char_del_btn"><%=MsgExtract("Btn_Character")%> <%=MsgExtract("Btn_Delete2")%></button></span>
						<%End if%>
						</div>
					</td>
				</tr> 
			</thead>
				<tbody>
				<%If rSocket <> "" Then%>
				  <tr >
				    <th scope="row" style="padding-top:15px"><%=MsgExtract("F5_Title001")%></th>
				    <td colspan=3 style="padding-top:15px">
				      <div class="item" >
				      	<span id="charType" style="margin-right:5px;"></span><input type="text" id="charname" name="charname" value="" >
				      	
				      </div>
				    </td>
				    <td></td>
				  </tr>
				   <tr>
				    <th><%=MsgExtract("F5_Title008")%></th>
				    <td colspan=3>
				      <div class="item" id="serial"></div>
				    </td>
				    <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title030")%></th>
				    <td colspan=3>
				      <div class="item" id="regdate"></div>
				    </td>
				    <td></td>
				  </tr>
				  
				  <tr>
				    <th><%=MsgExtract("F5_Title002")%></th>
				    <td colspan=3>
				      <div class="item" id="zone_point"><!--접소위치--></div>
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
				      <div class="item"><input TYPE="text" id="charExp" name="charExp" value="0" style="margin-bottom:5px"><br><label id="EXP_Lavel1"></label>~ <label id="EXP_Lavel2"></label></div>
				    </td>
				    <td></td>
				  </tr>       
				  <tr>
				    <th><%=MsgExtract("F5_Title006")%></th>
				    <td colspan=3>
				      <div class="item"><input type="text" id="charemp" name="charemp" value="" size=4 maxlength=4></div>
				    </td>
				    <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title007")%></th>
				    <td>
				      <div class="item"><input type="text" id="charadb" name="charadb" value="" size=4 maxlength=3>&nbsp;&nbsp;<span class="f_blu"><%=MsgExtract("F5_Title038")%></span></div>
				    </td>
				    <th><%=MsgExtract("F5_Title013")%></th>
				    <td>
				      <div class="item"><input type="text" id="charGP" name="charGP" value=""  maxlength=10></div>
				    </td>
				    <td></td>
				  </tr>
				   <tr>
				    <th><%=MsgExtract("F5_Title017")%></th>
				    <td>
				      <div class="item"><input type="text" id="charSkillP" name="charSkillP" value="" size=4 maxlength=5></div>
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
				      <div class="item"><input type="text" id="charMoveS" name="charMoveS" value="" size=4 maxlength=5></div>
				    </td>
				    <th><%=MsgExtract("F5_Title015")%></th>
				    <td >
				      <div class="item"><input type="text" id="charAttS" name="charAttS" value="" size=4 maxlength=5></div>
				    </td>
				    <td></td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title016")%></th>
				    <td colspan=3>
				      <div class="item"><input TYPE="text" id="charSkillS" name="charSkillS" value="" size=4 maxlength=5></div>
				    </td>
				    
				    <td></td>
				  </tr>
					
					<tr>
				    <th><%=MsgExtract("F5_Title018")%></th>
				    <td>
				      <div class="item"><input type="text" id="charStra" name="charStra" value="" size=4 maxlength=5></div>
				    </td>
				  
				    <th><%=MsgExtract("F5_Title019")%></th>
				    <td>
				      <div class="item"><input type="text" id="charDext" name="charDext" value="" size=4 maxlength=5></div>
				    </td>
				      <td></td>
				  </tr>
				  
				  <tr>
				    <th><%=MsgExtract("F5_Title020")%></th>
				    <td>
				      <div class="item"><input type="text" id="charAim" name="charAim" value="" size=4 maxlength=5></div>
				    </td>
				  
				    <th><%=MsgExtract("F5_Title021")%></th>
				    <td>
				      <div class="item"><input type="text" id="charLuck" name="charLuck" value="" size=4 maxlength=5></div>
				    </td>
				    <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title022")%></th>
				    <td>
				      <div class="item"><input type="text" id="charAP" name="charAP" value="" size=4 maxlength=5></div>
				    </td>
				    <th><%=MsgExtract("F5_Title023")%></th>
				    <td>
				      <div class="item"><input type="text" id="charDP" name="charDP" value="" size=4 maxlength=5></div>
				    </td>
				    <td></td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title024")%></th>
				    <td>
				      <div class="item"><input type="text" id="charHC" name="charHC" value="" size=4 maxlength=5></div>
				    </td>

				    <th><%=MsgExtract("F5_Title025")%></th>
				    <td>
				      <div class="item"><input type="text" id="charHD" name="charHD" value="" size=4 maxlength=5></div>
				    </td>
				    <td></td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title026")%></th>
				    <td>
				      <div class="item"><input type="text" id="charNHP" name="charNHP" value="" size=4 maxlength=5></div>
				    </td>
				  
				    <th><%=MsgExtract("F5_Title027")%></th>
				    <td>
				      <div class="item"><input TYPE="text" id="charNMP" name="charNMP" value="" size=4 maxlength=5></div>
				    </td>
				      <td></td>
				  </tr>       
				  <tr>
				    <th><%=MsgExtract("F5_Title028")%></th>
				    <td>
				      <div class="item"><input type="text" id="charMHP" name="charMHP" value="" size=4 maxlength=5></div>
				    </td>
				  
				    <th style="padding-bottom:13px;"><%=MsgExtract("F5_Title029")%></th>
				    <td style="padding-bottom:13px;">
				      <div class="item"><input type="text" id="charMMP" name="charMMP" value="" size=4 maxlength=5></div>
				    </td>
				      <td style="padding-bottom:13px;"></td>
				  </tr>
				  <!--
				   <tr>
				    <th><%=MsgExtract("F5_Title031")%></th>
				    <td>
				      <div class="item"><input type="text" id="charresfi" name="charresfi" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title032")%></th>
				    <td>
				      <div class="item"><input type="text" id="charreswa" name="charreswa" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				            
				  <tr>
				    <th><%=MsgExtract("F5_Title033")%></th>
				    <td>
				      <div class="item"><input TYPE="text" id="charresea" name="charresea" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>       
				  <tr>
				    <th><%=MsgExtract("F5_Title034")%></th>
				    <td>
				      <div class="item"><input type="text" id="charreswi" name="charreswi" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title035")%></th>
				    <td>
				      <div class="item"><input type="text" id="charresev" name="charresev" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  -->
				  <%Else%>
				  <tr height="624">
				    <td colspan=4 align=center>
				      	<%=MsgExtract("F5_Title036")%>
				    </td>
				  </tr>
				  
				  <%End if%>
				 </tbody>  
				  
				
			</table>
	
