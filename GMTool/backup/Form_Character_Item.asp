<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim cn

%>
		<table class="tbl_type" cellspacing="0" summary="Item List" > 
			<colgroup>
				<col width="30"><col width="200"><col width="60"><col width="120"><col width="150">
				<col width="120"><col width="100"><col width="80"><col width="60"><col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<td colspan="10"><div class="item"><span class="btn_pack medium icon"><span class="add"></span><button type="button" id="CItem_add_<%=rGBN%>"><%=MsgExtract("Btn_ItemNEW")%></button></span></div>
					</td>
				</tr>
			</thead>
			<thead class="toolbar">
				<tr>
					<th><input type="checkbox" id="check_all_<%=rGBN%>"></th>
					<th><%=MsgExtract("F6_Title002")%></th>
					<th><%=MsgExtract("F6_Title003")%></th>
					<th><%=MsgExtract("F6_Title004")%></th>
					<th><%=MsgExtract("F6_Title005")%></th>
					<th><%=MsgExtract("F6_Title006")%></th>
					<th><%=MsgExtract("F6_Title007")%></th>
					<th><%=MsgExtract("F6_Title008")%></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
		</table>
		<div style=" height:395px; overflow:scroll; overflow-x:hidden;">
		<table class="tbl_type" cellspacing="0" summary="Item List" > 
			<colgroup>
				<col width="30"><col width="200"><col width="60"><col width="120"><col width="150">
				<col width="120"><col width="100"><col width="80"><col width="60"><col width="*">
			</colgroup>
			<tbody id="CItem_List_<%=rGBN%>">
			<tr><td align=center colspan=10 style="height:366px"><img src="/images/wait_fbisk.gif"></td></tr>
			</tbody>
		</table>

		<div id="Char_Item_NEW_<%=rGBN%>" style="position:absolute; top:115px; left:300px ;display:none; ">
			
		</div>		
<script>
		var common_url = '/Common/Class/GMTool/GMT_Character_Item.class.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>';
		$(function($){
			gen_Item_Table();
		});
		function col_close(){
			$('#Char_Item_NEW_<%=rGBN%>').empty().hide();
			$('button[id^=Qty_mod_btn],button[id^=Sel_mod_btn],button[id^=Qty_del_btn],input[id^="iqty_"],input[id^="check_<%=rGBN%>"],select[id^="Sel_SO"]').attr("disabled",false);
		}
		function gen_Item_Table(){
			$.getJSON(common_url ,	function(data){
				var html="";
				var j = 0
				$.each(data.List, function(i,C_Item){
					//alert(C_Item.N1)
					j = parseInt(data.CNT) - (i -1 ) ;
					html = html + '	<tr> ';
					html = html + '<td align=right><input type="checkbox" id="check_<%=rGBN%>_'+j+'"></td>';
					html = html + '<td align=right>'+s_item_search(C_Item.N1) +'</td>';
					html = html + '<td align=center>'+s_item_GubunDU(C_Item.N1) +'</td>';
					html = html + '<td align=center>'+Item_GUBUN (s_item_GubunCD(C_Item.N1)) +'</td>';
					html = html + '<td align=center>'+C_Item.N2 +'</td>';
					if (parseInt(s_item_GubunLimit (C_Item.N1)) == 0 || parseInt(s_item_GubunLimit (C_Item.N1)) == 1){
						html = html + '<td align=center>'+C_Item.N4+'</td>';
					}else{
						html = html + '<td align=center><div class=item><input style="width:45px;" type="text" id="iqty_'+i+'" size=4 maxlangth="'+s_item_GubunLimit (C_Item.N1).length +'" value="'+C_Item.N4+'" min="1" max="'+ s_item_GubunLimit (C_Item.N1) +'">';
						html = html + '<span class="btn_pack small"><button type="button" id="Qty_mod_btn" rel="'+ C_Item.N5 +'" data="'+ C_Item.N3 +'"><%=MsgExtract("Btn_Modify")%></button></span></div></td>';
					}
					html = html + '<td align=center><div class="item">'+ gen_selet_socket(data, C_Item.N5) ;
					html = html + '<span class="btn_pack small"><button type="button" id="Sel_mod_btn" rel="'+ C_Item.N5 +'" data="'+ C_Item.N3 +'"><%=MsgExtract("Btn_Modify")%></button></span></div></td>';
					html = html + '<td align=center>'+Enum_data.ItemSocketType[C_Item.N3].N2 +'</td>';
					html = html + '<td align=center><span class="btn_pack small icon"><span class="delete"></span><button type="button" id="Qty_del_btn" rel="'+ C_Item.N5 +'" data="'+ C_Item.N3 +'"><%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr> ';
				
				});
				$('#CItem_List_<%=rGBN%>').html(html);
				list_color('CItem_List_<%=rGBN%>');
				
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
				
				$('#CItem_add_<%=rGBN%>').click(function(){
					$('#Char_Item_NEW_<%=rGBN%>').load('/Gmtool/Form/Form_New_Chracter_Give_Item.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>').show();
					$('button[id^=Qty_mod_btn],button[id^=Sel_mod_btn],button[id^=Qty_del_btn],input[id^="iqty_"],input[id^="check_<%=rGBN%>"],select[id^="Sel_SO"]').attr("disabled","disabled");
					//$('#CItem_List_<%=rGBN%> ~ input').attr("disabled","disabled");
				
				});

			});
		}
		
		
</script>