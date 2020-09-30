<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim cn

%>
		<table class="tbl_type" cellspacing="0" summary="Hench List" > 
			<colgroup>
				<col width="220">
				<col width="150"><col width="80"><col width="100">	
				<col width="100"><col width="60">
				<col width="100"><col width="100">
				<col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<td colspan="9"><div class="item"><span class="btn_pack medium icon"><span class="add"></span><button type="button" id="CHench_add_<%=rGBN%>"><%=MsgExtract("Btn_ItemNEW")%></button></span></div>
					</td>
				</tr>
			</thead>
			<thead class="toolbar">
				<tr>
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
		</table>
		<div style=" height:395px; overflow:scroll; overflow-x:hidden;">
		<table class="tbl_type" cellspacing="0" summary="Hench List" >
			<colgroup>
				<col width="220"><col width="150">
				<col width="80"><col width="100">	
				<col width="100"><col width="60">
				<col width="100"><col width="100">
				<col width="*">
			</colgroup> 
			<tbody id="CHEN_List1_<%=rGBN%>">
				<tr><td align=center colspan=9 style="height:306px"><img src="/images/wait_fbisk.gif"></td></tr>
			</tbody>
		</table>
		</div>
		
<script>
		var common_url = '/Common/Class/GMTool/GMT_Character_Hench.class.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=<%=rGBN%>'
		$(function($){
			
			gen_hench_list();
			
		});
		
		function gen_hench_list(){
		
			$.getJSON(common_url,	function(data){
				var html="";
				$.each(data.List, function(i,C_Hench){
					html = html + '	<tr> ';
					html = html + '<td align=right>'+ unescape(C_Hench.N2) +' / '+ s_monster_search(C_Hench.N1) +'</td>';
					html = html + '<td align=center>'+ C_Hench.N3 +'</td>';
					html = html + '<td align=center>'+Enum_data.PositionType[parseInt(C_Hench.N4)].N2  +'</td>';
					html = html + '<td align=center><div class="item">'+ gen_selet_socket(data, C_Hench.N5);
					html = html + '<span class="btn_pack small"><button type="button" id="Sel_mod_btn" rel="'+ C_Hench.N5 +'" data="'+ C_Hench.N3 +'"><%=MsgExtract("Btn_Modify")%></button></span></div></td>';
					html = html + '<td align=center>'+C_Hench.N6 +'[ '+ +C_Hench.N9 +' ]</td>';
					html = html + '<td align=center>'+Enum_data.SEX[parseInt(C_Hench.N7)].N2 +'</td>';
					html = html + '<td align=center>'+Enum_data.HType[parseInt(C_Hench.N8)].N2 +'</td>';
					html = html + '<td align=center><span class="btn_pack small icon"><span class="delete"></span><button type="button" class="Qty_del_btn" ><%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr> ';
				
				});
				$('#CHEN_List1_<%=rGBN%>').html(html);
				list_color('CHEN_List1_<%=rGBN%>');
			});
			
		
		}
</script>