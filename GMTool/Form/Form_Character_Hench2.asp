<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim cn
	if rGBN = "HI" Then
		cn = MsgExtract("Btn_Hench_View")
	Else
		cn = MsgExtract("Btn_HStore_View")
	End if
%> 
		<form id="form_Hench_list<%=rGBN%>" action="/Gmtool/Form/Form_Character_Hench_Move.asp" method="post">
		<input type=hidden name="Server" value="<%=rServer%>">
		<input type=hidden name="id_idx" value="<%=rid_idx%>">
		<input type=hidden name="Socket" value="<%=rSocket%>">
		<input type=hidden name="GBN" value="<%=rGBN%>">
		
		<div class="ui-widget-header char_title2"> <font class='f_blu'><%=cn%></font></div>
		<table class="tbl_type" cellspacing="0" summary="Hench List" width=100%>  
			<colgroup>
				<col width="20"><col width="220">
				<col width="150"><col width="80"><col width="100">	
				<col width="100"><col width="60">
				<col width="100"><col width="100">
				<col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<td colspan="10">
						<div class="item">
							<span class="btn_pack medium icon"><span class="add"></span><button type="button" id="CHench_add_<%=rGBN%>"><%=MsgExtract("Btn_Hen_Ad")%></button></span>
							<span class="btn_pack medium icon"><span class="move"></span><button type="submit" id="CItem_move_<%=rGBN%>"><%=MsgExtract("Btn_Hench_Move")%></button></span>
							<%if rGBN = "HI" Then%>
							<span class="btn_pack medium"><button type="button" id="btn_CStore_<%=rGBN%>"><%=MsgExtract("Btn_HStore_View")%></button></span>
							<%else%>
							<span class="btn_pack medium"><button type="button" id="btn_CItem_<%=rGBN%>"><%=MsgExtract("Btn_Hench_View")%></button></span>
							<%End If%>
						</div>
					</td>
				</tr>
			</thead>
			<thead class="toolbar">
				<tr>
					<th><input type="checkbox" id="Check_All_Hench" ></th>
					<th><%=MsgExtract("F7_Title002")%></th>
					<th><%=MsgExtract("F6_Title005")%></th>
					<th><%=MsgExtract("F7_Title003")%></th>
					<th><%=MsgExtract("F7_Title004")%></th>
					<th><%=MsgExtract("F7_Title005")%>[Max]</th>
					<th><%=MsgExtract("F7_Title006")%></th>
					<th><%=MsgExtract("F7_Title007")%></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
		
			<tbody id="CHEN_List1_<%=rGBN%>">
				<tr><td align=center colspan=10 style="height:590px"><img src="/images/wait_fbisk.gif"></td></tr>
			</tbody>
		</table>
		</form>
		<div id="Char_Hench_NEW_<%=rGBN%>" style="position:absolute; top:115px; left:300px ;display:none; ">
			
		</div>
		
<script>
		var common_url = '/Common/Class/GMTool/GMT_Character_Hench.class.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>'
		$(function($){
			
			gen_hench_list();
			
			$('#btn_CStore_<%=rGBN%>').click(function(){
				$('#Player_char_Info').load('/GMTool/Form/Form_Character_Hench2.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=HS');
			});
			$('#btn_CItem_<%=rGBN%>').click(function(){
				$('#Player_char_Info').load('/GMTool/Form/Form_Character_Hench2.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=HI');
			});
			//체크박스 클릭
			$('#Check_All_Hench').click(function(){
			
				if ($(this).is(":checked")){                
			    	$(".check_Hench").attr("checked", true);
			    }else{
			   		$(".check_Hench").attr("checked", false);
			    }
			});
			
			$('#CHench_add_<%=rGBN%>').click(function(){
					form_modal_load('/Gmtool/Form/Form_New_Chracter_Give_Hench.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>', 'Give Hench', 550, 560);
			});
		
			$('#form_Hench_list<%=rGBN%>').ajaxForm({
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
			var $oCheckSelected = $("#CHEN_List1_<%=rGBN%> tr td").find(":checkbox");
			if($oCheckSelected.is(":checked")){
				return true;
			}else{
				alert('<%=MsgExtract("F6_Title026")%>');
				return false;
			}
		}
		
		function gen_hench_list(){
		
			$.getJSON(common_url,	function(data){
				var html="";
				if (data.List.length != 0) {
				$.each(data.List, function(i,C_Hench){
					html = html + '	<tr> ';
					html = html + '<td><input type="checkbox" class="check_Hench" id="check_Hench" name="check_Hench" value="['+C_Hench.N1+', '+C_Hench.N5+', '+C_Hench.N4+']"></td>';
					html = html + '<td align=right class=link rel="'+C_Hench.N3+'">'+ unescape(C_Hench.N2) +' / '+ s_monster_search(C_Hench.N1) +'['+ C_Hench.N1 +']</td>';
					html = html + '<td align=center>'+ C_Hench.N3 +'</td>';
					html = html + '<td align=center>'+Enum_data.PositionType[parseInt(C_Hench.N4)].N2  +'</td>';
					html = html + '<td align=center><div class="item">'+ gen_selet_socket(data, C_Hench.N5);
					html = html + '<span class="btn_pack medium"><button type="button" id="Sel_mod_btn" rel="'+ C_Hench.N5 +'" data="'+ C_Hench.N3 +'"><%=MsgExtract("Btn_Modify")%></button></span></div></td>';
					html = html + '<td align=center>'+C_Hench.N6 +'[ '+ C_Hench.N9 +' ]</td>';
					html = html + '<td align=center>'+Enum_data.SEX[parseInt(C_Hench.N7)].N2 +'</td>';
					html = html + '<td align=center>'+Enum_data.HType[parseInt(C_Hench.N8)].N2 +'</td>';
					html = html + '<td align=center><span class="btn_pack medium icon"><span class="delete"></span><button type="button" id="Qty_del_btn"  rel="'+ C_Hench.N5 +'" data="'+ C_Hench.N3 +'" ><%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr> ';
				
				});
				$('#CHEN_List1_<%=rGBN%>').html(html);
				list_color('CHEN_List1_<%=rGBN%>');
				
				$("#CHEN_List1_<%=rGBN%> > tr > td[class='link']:nth-child(2) ").click(function(){
					form_modal_load('/Gmtool/Form/Form_Chracter_Edit_Hench.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>&C_serial='+$(this).attr("rel"), 'Edit Hench', 550, 600);
				});
				
				
				}else{
				
					$('#CHEN_List1_<%=rGBN%>').html('<tr style="height:590px"><td colspan ="9" align=center><%=MsgExtract("F7_Title012")%></td><td></td></tr>');
				
				}
				//Delete Button Click Event
				$('button[id^=Qty_del_btn]').click(function(){
					var conf_msg 	= "<%=MsgExtract("F6_Title010")%>";
					var Item_So		= $(this).attr('rel');
					var Item_Type	= $(this).attr('data');
					if (confirm(conf_msg)){
						$.ajax({
						  url: common_url + '&I_Pro=Q_DEL&Item_so='+Item_So + '&Item_Type=' + Item_Type,
						  success: function(data) {
							gen_hench_list();
							alert('<%=MsgExtract("F6_Title011")%>');     
						  }
						});
					}
				});
				//소캣 수정 버튼 클릭시.
				$('button[id^=Sel_mod_btn]').click(function(){
					var conf_msg 	= "<%=MsgExtract("F6_Title001")%>";
					var Item_So		= $(this).attr('rel');
					var Item_Type	= $(this).attr('data');
					var Item_So2	=$(this).parent().prev().val();
					if (confirm(conf_msg)){
						$.ajax({
						  url: common_url + '&I_Pro=Q_MOD_S&Item_so='+Item_So +'&Item_so2='+ Item_So2 + '&Item_Type=' + Item_Type,
						  success: function(data) {
							gen_hench_list();
							alert('<%=MsgExtract("F2_Title035")%>');     
						  }
						});
					}
				});
				
			
			});
		}
</script>