<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->
<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	Dim Right_num	: 	Right_num		= right(rid_idx,1)
	
	Dim SQL
	Dim MixDSN2		:	MixDSN2			= rServer
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	
	
	Dim qposition, qh_order, qm_type, qg_type, qname, qsex, qlevel, qmlevel, qstr, qdex, qami, qluck, qrace, qexp, qsp_move, qsp_att, qsp_skill, qap, qdp, qhc, qhd, qhp, qmp, qmxhp, qmxmp, Islot, H_item1, H_item2, H_item3
	
	
	if rGBN = "HI" Then
	SQL = "Select id_idx, hero_order, serial, position, hench_order, monster_type, name, sex, state, mixnum, baselevel, max_baselevel, exp, speed_move, speed_attack, " ' 14
	SQL = SQL & " speed_skill, str, dex, aim, luck, ap, dp, hc, hd, hp, mp, maxhp, maxmp, item0, item1, item2, growthtype, race_val, ign_att_cnt, add_defense_cnt, "	'15-34
	SQL = SQL & " enchant_grade, item_slot_total, item_idx_0, item_serial_0, item_duration_0, item_idx_1, item_serial_1, item_duration_1, item_idx_2, item_serial_2, "	'35-44
	SQL = SQL & " item_duration_2, duration, last_check_time From u_hench_"& Right_num &" Where id_idx = " & rid_idx &" And hero_order = "& rSocket &" And serial = " & rC_serial
	Else
	
	SQL = "Select id_idx, 0, serial, 2, hench_order, monster_type, name, sex, state, mixnum, baselevel, max_baselevel, exp, speed_move, speed_attack, " ' 14
	SQL = SQL & " speed_spell, str, dex, aim, luck, ap, dp, hc, hd, hp, mp, maxhp, maxmp, item0, item1, item2, growthtype, race_val, ign_att_cnt, add_defense_cnt, "	'15-34
	SQL = SQL & " enchant_grade, item_slot_total, item_idx_0, item_serial_0, item_duration_0, item_idx_1, item_serial_1, item_duration_1, item_idx_2, item_serial_2, "	'35-44
	SQL = SQL & " item_duration_2, duration, last_check_time From u_store_hench_"& Right_num &" Where id_idx = " & rid_idx &" And serial = " & rC_serial
	
	End if
	'SQL = " Select * From From u_hench_"& Right_num &" Where id_idx = " & rid_idx &" And hero_order = "& rSocket &" And serial = " & rC_serial
	
	DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
	DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt 
	
	
	qposition		= arrRSMix(3,0)
	qh_order		= arrRSMix(4,0)
	qm_type 		= arrRSMix(5,0)
	qname		  	= arrRSMix(6,0)
	qsex			= arrRSMix(7,0)
	qlevel			= arrRSMix(10,0)
	qmlevel			= arrRSMix(11,0)
	qexp			= arrRSMix(12,0)
	qsp_move		= arrRSMix(13,0)
	qsp_att			= arrRSMix(14,0)
	qsp_skill		= arrRSMix(15,0)
	qstr			= arrRSMix(16,0)
	qdex			= arrRSMix(17,0)
	qami			= arrRSMix(18,0)
	qluck			= arrRSMix(19,0)
	
	qap				= arrRSMix(20,0)
	qdp				= arrRSMix(21,0)
	qhc				= arrRSMix(22,0)
	qhd				= arrRSMix(23,0)
	qhp				= arrRSMix(24,0)
	qmp				= arrRSMix(25,0)
	qmxhp			= arrRSMix(26,0)
	qmxmp			= arrRSMix(27,0)
	
	qg_type			= arrRSMix(31,0)
	qrace			= arrRSMix(32,0)	
	Islot			= arrRSMix(36,0)
	H_item1			= arrRSMix(37,0)
	H_item2			= arrRSMix(40,0)
	H_item3			= arrRSMix(43,0)
	'Response.Write SQL
%>	
	
<form id="GiveHench" method="post" action="/Common/Class/GMTool/GMT_Character_Hench.class.asp?I_Pro=HENCHEDIT" >
	<input type=hidden name="Server" value="<%=rServer%>">
	<input type=hidden name="id_idx" value="<%=rid_idx%>">
	<input type=hidden name="Socket" value="<%=rSocket%>">
	<input type=hidden name="GBN" value="<%=rGBN%>">
	<input type=hidden name="C_serial" value="<%=rC_serial%>">
	
	
	<div class="form_table" style="margin-top: 10px">
	<table border="1" cellspacing="0" summary="New Hench Insert Form">
	<colgroup>
		<col width="120"><col width="*">
	</colgroup>
	  <tr>
	    <th><%=MsgExtract("F7_Title001")%></th>
	    <td>
	      <div class="item">
		      <span id="H_kind" name="tH_kind" style="margin-right:15px"> </span>
		      <input type=text id="H_name" name="tH_name" value="<%=qname%>">
		      <span id="F_MONSTER_DIV"></span>
	      </div>
	    </td>
	  </tr>
	  <tr>
	    <th><%=MsgExtract("F7_Title013")%></th>
	    <td>
	      <div class="item" >
				<span id="H_spc" name="tH_spc" style="margin-right:15px"> </span>
				<select id="H_sex" name="tH_sex"> </select>
	      </div>
	    </td>
	  </tr>
	                   
	  <tr>
	    <th><%=MsgExtract("F7_Title014")%></th>
	    <td>
	      <div class="item">
	      		<select id="H_position" name="tH_position"> </select>
				<span id="F_ITem_Sock_DIV"></span>
	      </div>
	    </td>
	  </tr>
	   <tr>
	    <th><%=MsgExtract("F7_Title015")%></th>
	    <td>
	      <div class="item">
	      		<select id="H_level" name="tH_level"> </select>
				&nbsp;&nbsp;<%=MsgExtract("F7_Title022")%> <input type="text" class="numer" size="4" maxlength="3" id="H_maxlevel" name="tH_maxlevel" value="<%=qmlevel%>" readonly style='backgroundColor:buttonface'>
	      </div>
	    </td>
	  </tr>         
	  <tr>
	    <th><%=MsgExtract("F5_Title005")%></th>
	    <td>
	      <div class="item" style="margin-bottom:2px;padding-top:3px">
	      		<input type=text class="numer"  id="H_exp" name="tH_exp" value="<%=qexp%>" style="margin-bottom:5px;">
	      		<br><label id="EXP_Lavel1">1</label>~ <label id="EXP_Lavel2">14</label>
	      </div>
	    </td>
	  </tr> 
	  <tr>
	    <th><%=MsgExtract("F7_Title016")%></th>
	     <td style="padding:0">
	      <table  border="0" cellspacing="0">
	      	<tr>
	      		<th><%=MsgExtract("F7_Title019")%></th>
	      		<th><%=MsgExtract("F7_Title020")%></th>
	      		<th><%=MsgExtract("F7_Title021")%></th>
	      	</tr>
	      	<tr>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_spmove" name="tH_spmove" value="<%=qsp_move%>"></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_spattack" name="tH_spattack" value="<%=qsp_att%>"></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_spskill" name="tH_spskill" value="<%=qsp_skill%>"></div></td>
	      	</tr>
	      </table>
	    </td>
	  </tr>      
	  <tr>
	    <th><%=MsgExtract("F7_Title017")%></th>
	    <td style="padding:0">
	      <table  border="0" cellspacing="0">
	      	<tr>
	      		<th><%=MsgExtract("F5_Title018")%></th>
	      		<th><%=MsgExtract("F5_Title019")%></th>
	      		<th><%=MsgExtract("F5_Title020")%></th>
	      		<th><%=MsgExtract("F5_Title021")%></th>
	      		<th><%=MsgExtract("F7_Title007")%></th>
	      	</tr>
	      	<tr>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_str" name="tH_str"  value="<%=qstr%>"></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_dex" name="tH_dex"  value="<%=qdex%>"></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_ami" name="tH_ami"  value="<%=qami%>"></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_luck" name="tH_luck"  value="<%=qluck%>"></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_race_val" name="tH_race_val"  value="<%=qrace%>"></div></td>

	      	</tr>
	      </table>
	    </td>
	  </tr>
	  <tr>
	    <th><%=MsgExtract("F7_Title018")%></th>
	     <td style="padding:0">
	      <table  border="0" cellspacing="0">
	      	<tr>
	      		<th><%=MsgExtract("F5_Title022")%></th>
	      		<th><%=MsgExtract("F5_Title023")%></th>
	      		<th><%=MsgExtract("F5_Title024")%></th>
	      		<th><%=MsgExtract("F5_Title025")%></th>
	      	</tr>
	      	<tr>
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_ap" name="tH_ap" value="<%=qap%>"></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_dp" name="tH_dp" value="<%=qdp%>"></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_hc" name="tH_hc" value="<%=qhc%>"></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_hd" name="tH_hd" value="<%=qhd%>"></div></td>
	      	</tr>
	      </table>
	    </td>
	  </tr>  
	 <tr>
	    <th>HP</th>
	    <td>
	      <div class="item">
	      	<input type="text" class="numer" size="4" maxlength="5" id="H_hp" name="tH_hp" value="<%=qhp%>">
	      	&nbsp;&nbsp;<%=MsgExtract("F7_Title022")%> <input type="text" class="numer" size="4" maxlength="5" id="H_maxhp" name="tH_maxhp" value="<%=qmxhp%>">
	      </div>
	    </td>
	  </tr>
	  <tr>
	    <th>MP</th>
	    <td>
	      <div class="item">
	      	<input type="text" class="numer" size="4" maxlength="5" id="H_mp" name="tH_mp" value="<%=qmp%>">
	      	&nbsp;&nbsp;<%=MsgExtract("F7_Title022")%> <input type="text" class="numer" size="4" maxlength="5" id="H_maxmp" name="tH_maxmp" value="<%=qmxmp%>">
	      </div>
	    </td>
	  </tr>
	<tr>
	    <th>ITEM</th>
	     <td style="padding:0">
	      <table  border="0" cellspacing="0">
	      	<tr>
	      		<th>Slot CNT</th>
	      		<th>Item1</th>
	      		<th>Item2</th>
	      		<th>Item3</th>
	      		
	      	</tr>
	      	<tr>
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="2" maxlength="1" id="tH_Islot" name="tH_Islot" value="<%=Islot%>"></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" size="8" id="H_item1" name="H_item1" value="" readonly style='backgroundColor:buttonface'></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" size="8" id="H_item2" name="H_item2" value="" readonly style='backgroundColor:buttonface'></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" size="8" id="H_item3" name="H_item3" value="" readonly style='backgroundColor:buttonface'></div></td>
	      	</tr>
	      </table>
	    </td>
	  </tr>  
	</table>
	
	<div style="margin-top:20px"><center>
				<span class="btn_pack medium icon"><span class="saveas"></span><button type="submit" id="hench_add">&nbsp;<%=MsgExtract("Btn_Save")%></button></span>
				
		</center></div>
	</form>
			
	<script>
		
		$(function($){
			
			//Form initializing
			$(".numer").css({'ime-mode': 'disabled', 'text-align':'right','padding-right':'5px'}).numeric(); 		//모든 입력값은  숫자만 받는다.

			//select 관련 초기화.
			$("#H_kind").append(Enum_data.HENCHType[s_monster_group(<%=qm_type%>)].N2+",");	//헨치종류
			$('#F_MONSTER_DIV').append( s_monster_search(<%=qm_type%>) );
			$('#H_spc').append(Enum_data.HType[<%=qg_type%>].N2+",")
			
			sel_option('H_sex',		Enum_data.SEX			,'<%=qsex%>');	//헨치성별
			sel_option('H_position',Enum_data.PositionType	,'<%=qposition%>');	//핸치위치
			
			$("#H_item1").val(s_item_search(<%=H_item1%>));
			$("#H_item2").val(s_item_search(<%=H_item2%>));
			$("#H_item3").val(s_item_search(<%=H_item3%>));

			Get_Socket_N_Create(<%=qposition%>);									//남은소캣을 가져온다
			
			var sel_limit_level = <%=qmlevel%>;
			if (sel_limit_level >= 200){
				sel_limit_level = 200;
			} 
			sel_option3('H_level', sel_limit_level - 25, sel_limit_level);
			//$('#H_level').val(<%=qlevel%>);
			var exp_val = Character_level(<%=qlevel%> -1 ) + 1 ;
			$("#H_exp").val(exp_val);
			$("#EXP_Lavel1").text(exp_val);
			$("#EXP_Lavel2").text(Character_level(<%=qlevel%>));
			
			$('#H_position').change(function(){						//포켓, 전투, 창고
				Get_Socket_N_Create($(this).val());
			});
			
			$('#H_level').change(function(){						//헨치레벨
				exp_val = Character_level($(this).val() -1 ) + 1 ;
				$("#EXP_Lavel1").text(exp_val);
				$("#EXP_Lavel2").text(Character_level($(this).val()));
			});
			
			//헨치 추가
			$('#GiveHench').submit(function(){
				if (confirm('<%=MsgExtract("F6_Title001")%>')){
					$("#hench_add").attr("disabled","disabled");
					$(this).ajaxSubmit({ success: Addhanch_Reult_val });
				} 
				return false;
			});
			function Addhanch_Reult_val(responseText, statusText, xhr, $form)  {     
				
					alert('<%=MsgExtract("F2_Title035")%>');
					gen_hench_list();
					$('#ins_form').dialog('close');
					$('#ins_form').empty();
				
			} 
			
			
		});
		
		
		
		function Get_Socket_N_Create(GBN_Val){
			var Select_val = "";
			$.getJSON('/Common/Class/GMTool/GMT_Character_Hench.class.asp?I_Pro=HENHCSOCKET&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=' + GBN_Val ,	function(data){
				$('#F_ITem_Sock_DIV').html( gen_selet_socket(data, '<%=qh_order%>') );
			});
		}
		
	</script>