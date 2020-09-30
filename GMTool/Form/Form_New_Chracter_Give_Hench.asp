<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->
<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
%>				
<form id="GiveHench" method="post" action="/Common/Class/GMTool/GMT_Character_Hench.class.asp?I_Pro=HENCHADD" >
	<input type=hidden name="Server" value="<%=rServer%>">
	<input type=hidden name="id_idx" value="<%=rid_idx%>">
	<input type=hidden name="Socket" value="<%=rSocket%>">
	<input type=hidden id="H_name" name="tH_name" value="">
	
	<div class="form_table" style="margin-top: 10px">
	<table border="1" cellspacing="0" summary="New Hench Insert Form">
	<colgroup>
		<col width="120"><col width="*">
	</colgroup>
	  <tr>
	    <th><%=MsgExtract("F7_Title001")%></th>
	    <td>
	      <div class="item">
		      <select id="H_kind" name="tH_kind"> </select>
		      <span id="F_MONSTER_DIV"></span>
	      </div>
	    </td>
	  </tr>
	  <tr>
	    <th><%=MsgExtract("F7_Title013")%></th>
	    <td>
	      <div class="item" >
				<select id="H_spc" name="tH_spc"> </select>
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
				&nbsp;&nbsp;<%=MsgExtract("F7_Title022")%> <input type="text" class="numer" size="4" maxlength="3" id="H_maxlevel" name="tH_maxlevel" value="26" readonly style='backgroundColor:buttonface'>
	      </div>
	    </td>
	  </tr>         
	  <tr>
	    <th><%=MsgExtract("F5_Title005")%></th>
	    <td>
	      <div class="item" style="margin-bottom:2px;padding-top:3px">
	      		<input type=text class="numer"  id="H_exp" name="tH_exp" value="1" style="margin-bottom:5px;">
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
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_spmove" name="tH_spmove" value=""></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_spattack" name="tH_spattack" value=""></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_spskill" name="tH_spskill" value=""></div></td>
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
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_str" name="tH_str" value="" readonly style='backgroundColor:buttonface'></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_dex" name="tH_dex" value="" readonly style='backgroundColor:buttonface'></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_ami" name="tH_ami" value="" readonly style='backgroundColor:buttonface'></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_luck" name="tH_luck" value="" readonly style='backgroundColor:buttonface'></div></td>
	      		<td style="border-bottom:0"> <div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_race_val" name="tH_race_val" value="" readonly style='backgroundColor:buttonface'></div></td>
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
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_ap" name="tH_ap" value=""></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_dp" name="tH_dp" value=""></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_hc" name="tH_hc" value=""></div></td>
	      		<td style="border-bottom:0"><div class="item"><input type="text" class="numer" size="4" maxlength="5" id="H_hd" name="tH_hd" value=""></div></td>
	      	</tr>
	      </table>
	    </td>
	  </tr>  
	 <tr>
	    <th>HP</th>
	    <td>
	      <div class="item">
	      	<input type="text" class="numer" size="4" maxlength="5" id="H_hp" name="tH_hp" value="">
	      	&nbsp;&nbsp;<%=MsgExtract("F7_Title022")%> <input type="text" class="numer" size="4" maxlength="5" id="H_maxhp" name="tH_maxhp" value="">
	      </div>
	    </td>
	  </tr>
	  <tr>
	    <th>MP</th>
	    <td>
	      <div class="item">
	      	<input type="text" class="numer" size="4" maxlength="5" id="H_mp" name="tH_mp" value="">
	      	&nbsp;&nbsp;<%=MsgExtract("F7_Title022")%> <input type="text" class="numer" size="4" maxlength="5" id="H_maxmp" name="tH_maxmp" value="">
	      </div>
	    </td>
	  </tr>
	
	</table>
	
	<div style="margin-top:20px"><center>
				<span class="btn_pack medium icon"><span class="saveas"></span><button type="submit" id="hench_add">&nbsp;<%=MsgExtract("Btn_Save")%></button></span>
				
		</center></div>
	</form>
			
	<script>
		// 전역변수 선언
		var u_str = 0, u_dex = 0, u_ami = 0, u_luck = 0, u_race_val = 0;
		var b_level = 0;
		
		
		$(function($){
			
			//Form initializing
			$(".numer").css({'ime-mode': 'disabled', 'text-align':'right','padding-right':'5px'}).numeric(); 		//모든 입력값은  숫자만 받는다.

			//select 관련 초기화.
			sel_option('H_kind',	Enum_data.HENCHType		,'');	//헨치종류
			sel_option('H_spc',		Enum_data.HType			,'');	//헨치특성
			sel_option('H_sex',		Enum_data.SEX			,'');	//헨치성별
			sel_option('H_position',Enum_data.PositionType	,'1');	//핸치위치
			
			$("#H_spc option[value='0']").remove();					//헨치 특성중 0은 제거한다.
			Get_Socket_N_Create(1);									//남은소캣을 가져온다. 초기값 - 포켓 : 1
			
			Get_Monster_N_Create('0');
			
			
			$('#H_position').change(function(){						//포켓, 전투, 창고
				Get_Socket_N_Create($(this).val());
			});
			
			$('#H_level').change(function(){						//헨치레벨
				var exp_val = Character_level($(this).val() -1 ) + 1 ;
				$("#H_exp").val(exp_val);
				$("#EXP_Lavel1").text(exp_val);
				$("#EXP_Lavel2").text(Character_level($(this).val()));
				
				Hlevel_Change();
				
				
			});
			
			$('#H_kind').change(function(){							// 헨치이름 select create
			
				Get_Monster_N_Create($(this).val());
			});
			
			$('#H_spc').change(function(){
				Hlevel_Change();
			});
			
			
			//헨치 추가
			$('#GiveHench').submit(function(){
				if (confirm('<%=MsgExtract("F7_Title023")%>')){
					$("#hench_add").attr("disabled","disabled");
					$(this).ajaxSubmit({ success: Addhanch_Reult_val });
				} 
				return false;
			});
			function Addhanch_Reult_val(responseText, statusText, xhr, $form)  {     
				
					alert('<%=MsgExtract("F7_Title024")%>');
					gen_hench_list();
					$('#ins_form').dialog('close');
					$('#ins_form').empty();
				
			} 
			
			
		});
		
		
		
		function Get_Socket_N_Create(GBN_Val){
			var Select_val = "";
			$.getJSON('/Common/Class/GMTool/GMT_Character_Hench.class.asp?I_Pro=HENHCSOCKET&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=' + GBN_Val ,	function(data){
				$('#F_ITem_Sock_DIV').html( gen_selet_socket(data, '') );
			});
		}
		
		function Get_Monster_N_Create(GBN_VAL){

			$('#F_MONSTER_DIV').html( gen_monster_Name_Select(GBN_VAL,'H_code') );
			Get_Monster_Default ();
			$("#H_name").val($("select[id=H_code] > option:selected").attr("rel"));
			
			$('#H_code').change(function(){
				Get_Monster_Default ();
				$("#H_name").val($("select[id=H_code] > option:selected").attr("rel"));
			});
			
		}
		
		function Hlevel_Change(){
		
			var mm_level = 0;
			var mm_stat	 = 1
			
			mm_level = parseInt($('#H_level').val()) - b_level;
			
			mm_stat = mm_stat * mm_level ;
			
			/*var x = 0;
			var y = 0;
			x =  parseFloat( parseInt($('#H_str').val()) / 5);
			y = GetRandom(x) - x /2;
			z = GetRandom(x) - x /2;
			*/
			$('#H_str').val(u_str + mm_stat);
			$('#H_dex').val(u_dex + mm_stat);
			$('#H_ami').val(u_ami + mm_stat);
			$('#H_luck').val(u_luck + mm_stat);
			$('#H_race_val').val(u_race_val + mm_stat );
			
			mm_stat = (mm_stat == 0) ? 1 : mm_stat;
			
			if ($('#H_spc').val() == 1){
				$('#H_str').val(parseInt($('#H_str').val()) + mm_stat );
			}else if ($('#H_spc').val() == 2){
				$('#H_dex').val(parseInt($('#H_dex').val()) +  mm_stat );
			}else if ($('#H_spc').val() == 3){
				$('#H_ami').val(parseInt($('#H_ami').val()) +  mm_stat );
			}else if ($('#H_spc').val() == 4){
				$('#H_luck').val(parseInt($('#H_str').val()) +  mm_stat );
			}else{
				$('#H_race_val').val(parseInt($('#H_race_val').val()) + mm_stat );
			}
			
			
			//alert(GetRandom( parseInt( parseFloat($('#H_str').val()) / 5)));
			$.getJSON('/Common/Class/GMTool/GMT_Character_Hench.class.asp?I_Pro=Level_CH&rType=' + $('#H_level').val() ,	function(data){
				
				$('#H_ap').val(data.Sel[0].N1);
				$('#H_dp').val(data.Sel[0].N2);
				$('#H_hc').val(data.Sel[0].N3);
				$('#H_hd').val(data.Sel[0].N4);
				$('#H_hp').val(data.Sel[0].N5);
				$('#H_maxhp').val(data.Sel[0].N7);
				$('#H_mp').val(data.Sel[0].N6);
				$('#H_maxmp').val(data.Sel[0].N8);
			
			});
		}
		
		function Get_Monster_Default (){
			$.getJSON('/Common/Class/GMTool/GMT_Character_Hench.class.asp?I_Pro=Hench_Base&growthType='+ $('#H_spc').val() + '&rType=' + $('#H_code').val() ,	function(data){
				var sel_limit_level = data.Sel[0].N2;
				var exp_val = Character_level(data.Sel[0].N1 -1 ) + 1 ;
				
				b_level = data.Sel[0].N1;					// start_base_level 	전역변수 저장	
				
				/*var x = 0;
				var y = 0;
				x =  parseFloat( parseInt($('#H_str').val()) / 5);
				y = GetRandom(x) - x /2;
				z = GetRandom(x) - x /2;
				alert (y);
				alert (z)
				*/
				
				if (sel_limit_level >= 200){
					sel_limit_level = 200;
				} 
				
				sel_option3('H_level', data.Sel[0].N1, sel_limit_level);
				$('#H_maxlevel').val(data.Sel[0].N2);
				$('#H_spmove').val(data.Sel[0].N3);
				$('#H_spattack').val(data.Sel[0].N4);
				$('#H_spskill').val(data.Sel[0].N5);
				
				$('#H_str').val(parseInt(data.Sel[0].N6));
				$('#H_dex').val(parseInt(data.Sel[0].N7));
				$('#H_ami').val(parseInt(data.Sel[0].N8));
				$('#H_luck').val(parseInt(data.Sel[0].N9));
				$('#H_race_val').val(data.Sel[0].N10);
				
				if ($('#H_spc').val() == 1){
					$('#H_str').val(data.Sel[0].N6 + data.Sel[0].N1);
				}else if ($('#H_spc').val() == 2){
					$('#H_dex').val(data.Sel[0].N7 + data.Sel[0].N1);
				}else if ($('#H_spc').val() == 3){
					$('#H_ami').val(data.Sel[0].N8 + data.Sel[0].N1);
				}else if ($('#H_spc').val() == 4){
					$('#H_luck').val(data.Sel[0].N9 + data.Sel[0].N1);
				}else{
					$('#H_race_val').val(data.Sel[0].N10 + data.Sel[0].N1);
				}
				
				
				// 5가지 능력치 전역변수 저장
				u_str = data.Sel[0].N6;							
				u_dex = data.Sel[0].N7;
				u_ami = data.Sel[0].N8;
				u_luck = data.Sel[0].N9;
				u_race_val = data.Sel[0].N10;
				
				$('#H_ap').val(data.Sel[0].N11);
				$('#H_dp').val(data.Sel[0].N12);
				$('#H_hc').val(data.Sel[0].N13);
				$('#H_hd').val(data.Sel[0].N14);
				$('#H_hp').val(data.Sel[0].N15);
				$('#H_maxhp').val(data.Sel[0].N17);
				$('#H_mp').val(data.Sel[0].N16);
				$('#H_maxmp').val(data.Sel[0].N18);
				
				
				
				$("#H_exp").val(exp_val);
				$("#EXP_Lavel1").text(exp_val);
				$("#EXP_Lavel2").text(Character_level(data.Sel[0].N1));
				
				//alert(GetRandom( parseFloat(b_level / 5)));
				
			});
		}
		
		
		function GetRandom(range){
			var random_range = 0
			random_range = (Math.floor(Math.random() * range) / (0x7fff & 1) )  ;
			random_range = random_range.toString(10).toUpperCase();
			return random_range;
		}
		
	</script>