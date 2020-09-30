<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim cn
	
	if rGBN = "I" Then
		cn = MsgExtract("Btn_Item_View")
	Else
		cn = MsgExtract("Btn_IStore_View")
	End if
	

%>
		<style>
		div.positionable {
			width: 250px;
			height: 90px;
			position: absolute;
			display: none;
			left:872px;
			background-color: #fff;
			text-align: center;
			border:1px solid #aaa;
			padding:3px;
			-moz-border-radius:4px;
			-webkit-border-radius:4px;
			border-radius:4px;
			-moz-box-shadow:0 0 5px #700;
			-webkit-box-shadow:0 0 5px #700;
			box-shadow:0 0 5px #700;
			
		}
			
		</style>
		<form id="form_item_list<%=rGBN%>" action="/Gmtool/Form/Form_Character_Item_Move.asp" method="post">
		<input type=hidden name="Server" value="<%=rServer%>">
		<input type=hidden name="id_idx" value="<%=rid_idx%>">
		<input type=hidden name="Socket" value="<%=rSocket%>">
		<input type=hidden name="GBN" value="<%=rGBN%>">
		
		<div class="ui-widget-header char_title2"> <font class='f_blu'><%=cn%></font></div>
			<table class="tbl_type" cellspacing="0" summary="item List" width="100%">  
			<colgroup>
				<col width="20"><col width="200"><col width="60"><col width="70"><col width="100"><col width="120"><col width="150">
				<col width="120"><col width="100"><col width="80"><col width="60"><col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<td colspan="12" valign="middle">
						<span class="btn_pack medium icon"><span class="add"></span><button type="button" id="CItem_add_<%=rGBN%>"><%=MsgExtract("Btn_ItemNEW")%></button></span>
						<span class="btn_pack medium icon"><span class="move"></span><button type="submit" id="CItem_move_<%=rGBN%>"><%=MsgExtract("Btn_Item_Move")%></button></span>
						<%if rGBN = "I" Then%>
						<span class="btn_pack medium"><button type="button" id="btn_CStore_<%=rGBN%>"><%=MsgExtract("Btn_IStore_View")%></button></span>
						<%else%>
						<span class="btn_pack medium"><button type="button" id="btn_CItem_<%=rGBN%>"><%=MsgExtract("Btn_Item_View")%></button></span>
						<span id="radio_f" style="font-size:85%;font-weight:none"><input type="checkbox" id="Char_GP" onclick="$(this).parent().next().toggle();" /><label for="Char_GP"><%=MsgExtract("F9_Title033")%></label></span>
						<div class="positionable" style="padding-top:15px">
							<p>현재 보유중인 창고 Gold Point</p>
							<p>
							<input type="text" value="" class="numer" name="GMoney" id="GMoney" style="margin-right:8px;text-align:right;">
							<span class="btn_pack medium icon"><span class="saveas"></span><button type="button" id="SGmoney_btn">&nbsp;<%=MsgExtract("Btn_Save")%></button></span>
							</p>
						</div>
						
						<%End If%>
						
					</td>
				</tr>
			</thead>
			<thead class="toolbar">
				<tr>
					<th><input type="checkbox" id="Check_All_Item" ></th>
					<th><%=MsgExtract("F6_Title002")%></th>
					<th><%=MsgExtract("F6_Title003")%></th>
					<th><%=MsgExtract("F6_Title014")%></th>
					<th><%=MsgExtract("F6_Title015")%></th>
					<th><%=MsgExtract("F6_Title004")%></th>
					<th><%=MsgExtract("F6_Title005")%></th>
					<th><%=MsgExtract("F6_Title006")%></th>
					<th><%=MsgExtract("F6_Title007")%></th>
					<th><%=MsgExtract("F6_Title008")%></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
		
			<tbody id="CItem_List_<%=rGBN%>">
			<tr><td align=center colspan="12" style="height:590px"><img src="/images/wait_fbisk.gif"></td></tr>
			</tbody>
		</table>
		</form>
		<div id="Char_Item_NEW_<%=rGBN%>" style="position:absolute; top:115px; left:300px ;display:none; ">
			
		</div>		
		
<script>
		var common_url = '/Common/Class/GMTool/GMT_Character_Item.class.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>';
		$(function($){
			gen_Item_Table();
			$("#Char_GP").button(
				{
		            icons: {
		                primary: "ui-icon-gear",
		                secondary: "ui-icon-triangle-1-s"
		            }
		        }
			);
			//GMoney
			$(".numer").css({'ime-mode': 'disabled', 'text-align':'right','padding-right':'5px'}).numeric(); 
			// 창고보기 클릭시
			$('#btn_CStore_<%=rGBN%>').click(function(){
				$('#Player_char_Info').load('/GMTool/Form/Form_Character_Item2.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=S');
			});
			//아이템 보기 클릭시.
			$('#btn_CItem_<%=rGBN%>').click(function(){
				$('#Player_char_Info').load('/GMTool/Form/Form_Character_Item2.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=I');
			});
			
			$("#SGmoney_btn").click(function(){
			
				$.getJSON(common_url ,	function(data){
					$.ajax({
					  url: common_url + '&I_Pro=STORE_GP_MOD&GMoney='+$('#GMoney').val(),
					  success: function(data) {
						alert('<%=MsgExtract("F2_Title035")%>');
					  }
					});
				});
			});
			
			$('#form_item_list<%=rGBN%>').ajaxForm({
				target : '#item_hidden_form',
				beforeSubmit : Mcheck_form,
				success : function(){
					$('#item_hidden_form').dialog({
						modal:true, 
						title: 'Moving Item', 
						resizable: false,
						height:355,
						width:540,
						close: function(){
							
							$('#item_hidden_form').empty();
						}
					});
				}	
			});
			
		});
		
		function Mcheck_form (formData, jqForm, options) {
			var $oCheckSelected = $("#CItem_List_<%=rGBN%> tr td").find(":checkbox");
			if($oCheckSelected.is(":checked")){
				return true;
			}else{
				alert('<%=MsgExtract("F6_Title026")%>');
				return false;
			}
		}
		
		function col_close(){
			$('#Char_Item_NEW_<%=rGBN%>').empty().hide();
			$('button[id^=Qty_mod_btn],button[id^=Sel_mod_btn],button[id^=Qty_del_btn],input[id^="iqty_"],input[id^="check_<%=rGBN%>"],select[id^="Sel_SO"]').attr("disabled",false);
		}
		
		function gen_Item_Table(){
			$.getJSON(common_url ,	function(data){
				var html="";
				var j = 0;
				$('#GMoney').val(data.SG);
				
				if (data.List.length != 0) {
				
					$.each(data.List, function(i,C_Item){
						//alert(C_Item.N1)
						j = parseInt(data.CNT) - (i -1 ) ;
						html = html + '	<tr> ';
						html = html + '<td><input type="checkbox" class="cI" id="cI" name="cI" value="['+C_Item.N1+', '+C_Item.N5+', '+C_Item.N3+']"></td>';
						html = html + '<td align=right>'+s_item_search(C_Item.N1) +' ['+ C_Item.N1 +']</td>';
						html = html + '<td align=center>'+s_item_GubunDU(C_Item.N1) +'</td>';
						html = html + '<td align=center>'+C_Item.N6 +'</td>';
						html = html + '<td align=center>'+C_Item.N7 +'</td>';
						html = html + '<td align=center>'+Item_GUBUN (s_item_GubunCD(C_Item.N1)) +'</td>';
						html = html + '<td align=center>'+C_Item.N2 +'</td>';
						if (parseInt(s_item_GubunLimit (C_Item.N1)) == 0 || parseInt(s_item_GubunLimit (C_Item.N1)) == 1){
							html = html + '<td align=center>'+C_Item.N4+'</td>';
						}else{
							html = html + '<td align=center><div class=item><input style="width:45px;" type="text" id="iqty_'+i+'" size=4 maxlangth="'+s_item_GubunLimit (C_Item.N1).length +'" value="'+C_Item.N4+'" min="1" max="'+ s_item_GubunLimit (C_Item.N1) +'">';
							html = html + '<span class="btn_pack medium"><button type="button" id="Qty_mod_btn" rel="'+ C_Item.N5 +'" data="'+ C_Item.N3 +'"><%=MsgExtract("Btn_Modify")%></button></span></div></td>';
						}
						html = html + '<td align=center><div class="item">'+ gen_selet_socket(data, C_Item.N5) ;
						html = html + '<span class="btn_pack medium"><button type="button" id="Sel_mod_btn" rel="'+ C_Item.N5 +'" data="'+ C_Item.N3 +'"><%=MsgExtract("Btn_Modify")%></button></span></div></td>';
						html = html + '<td align=center>'+Enum_data.ItemSocketType[C_Item.N3].N2 +'</td>';
						html = html + '<td align=center><span class="btn_pack medium icon"><span class="delete"></span><button type="button" id="Qty_del_btn" rel="'+ C_Item.N5 +'" data="'+ C_Item.N3 +'"><%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr> ';
					
					});
					
					$('#CItem_List_<%=rGBN%>').html(html);
					list_color('CItem_List_<%=rGBN%>');
				}else{
					$('#CItem_List_<%=rGBN%>').html('<tr style="height:590px"><td colspan ="11" align=center><%=MsgExtract("F7_Title011")%></td><td></td></tr>');
				}
				//Modify Button Click Event
				$('button[id^=Qty_mod_btn]').click(function(){
					var conf_msg 	= "<%=MsgExtract("F6_Title001")%>";
					var Item_Qty 	= $(this).parent().prev().prev().val();
					var Item_So		= $(this).attr('rel');
					var Item_Type	= $(this).attr('data');
					var this_qty	= $(this)
					if (confirm(conf_msg)){
						$.ajax({
						  url: common_url + '&I_Pro=Q_MOD&Item_so='+Item_So +'&Item_Qty='+ Item_Qty + '&Item_Type=' + Item_Type,
						  success: function(data) {
							alert('<%=MsgExtract("F2_Title035")%>');
							this_qty.parent().prev().prev().css('border', '1px solid red');     
						  }
						});
					}
				});
				// 
				
				$('input[id^="iqty_"]').spinner();
				
				//Delete Button Click Event
				$('button[id^=Qty_del_btn]').click(function(){
					var conf_msg 	= "<%=MsgExtract("F6_Title010")%>";
					var Item_So		= $(this).attr('rel');
					var Item_Type	= $(this).attr('data');
					if (confirm(conf_msg)){
						$.ajax({
						  url: common_url + '&I_Pro=Q_DEL&Item_so='+Item_So + '&Item_Type=' + Item_Type,
						  success: function(data) {
							gen_Item_Table();
							alert('<%=MsgExtract("F6_Title011")%>');     
						  }
						});
					}
				});
				
				// 소캣을 변경후 수정 버튼 클릭시
				$('button[id^=Sel_mod_btn]').click(function(){
					var conf_msg 	= "<%=MsgExtract("F6_Title001")%>";
					var Item_So		= $(this).attr('rel');
					var Item_Type	= $(this).attr('data');
					var Item_So2	=$(this).parent().prev().val();
					if (confirm(conf_msg)){
						$.ajax({
						  url: common_url + '&I_Pro=Q_MOD_S&Item_so='+Item_So +'&Item_so2='+ Item_So2 + '&Item_Type=' + Item_Type,
						  success: function(data) {
							gen_Item_Table();
							alert('<%=MsgExtract("F2_Title035")%>');     
						  }
						});
					}
					
				});
				
				//체크박스 클릭
				$('#Check_All_Item').click(function(){
				
					if ($(this).is(":checked")){                
				    	$(".cI").attr("checked", true);
				    }else{
				   		$(".cI").attr("checked", false);
				    }
				});
				
				// 아이템 추가 클릭시
				$('#CItem_add_<%=rGBN%>').click(function(){
				
					form_modal_load('/Gmtool/Form/Form_New_Chracter_Give_Item.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>', 'Give Item', 470, 370);
				
				});
				
				// 아이템 이동 클릭시
				/*$('#CItem_move_<%=rGBN%>').click(function(){
					var $oCheckSelected = $("#CItem_List_<%=rGBN%> tr td").find(":checkbox");
					// 체크된 Item이 있는지 확인한다.
					if($oCheckSelected.is(":checked")){
						var params = $oCheckSelected.serialize();
						
						form_modal_load('/Gmtool/Form/Form_Character_Item_Move.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>&'+params, 'Moving Item', 500, 355);

					}else{
						
						alert('<%=MsgExtract("F6_Title026")%>');
					}
					
				});*/

			});
		}
		
		
</script>