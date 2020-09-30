<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->
<%
	Dim rid_idx		: rid_idx		= Request("id_idx") 
	Dim rPlayerID	: rPlayerID		= Request("PlayerID")
%>
<%
	Dim rs_gubun 	:	rs_gubun	= Request("s_gubun")
	Dim rs_item		:	rs_item		= trim(Request("s_item"))
	Dim cn
%>
	
	<script>
	
		//<![CDATA[	
		
		$(function($){
			$('#tabs').tabs();
		
			var html = '';
			$.getJSON('/Common/Class/GMTool/GMT_Character.class.asp?id_idx=<%=rid_idx%>',	function(data){
				
				$.each(data.LIST, function(i,Chara){
					
					$("#tab_"+Chara.N1).html('['+Chara.N2 +']');
					
					if (parseInt(Chara.N2) == 0){
					
						html = html + '<tr><td colspan=8>&nbsp;</td><td></td></tr>';
						html = html + '<tr><td colspan=8 align=center><%=MsgExtract("F4_Title001")%></td><td></td></tr>';
						html = html + '<tr><td colspan=8>&nbsp;</td><td></td></tr>';
						$("#td_"+Chara.N1).html(html);
						html = '';
					
					}else{
						$.each(Chara.N3, function(j,Chara2){
							html = html + '	<tr rel="'+Chara.N1+'" summary="'+unescape(Chara2.N7)+'" data="'+unescape(Chara2.N8)+'" title="'+unescape(Chara2.N3)+'"> ';
							html = html + '<td align=center><%=rPlayerID%></td>';
							html = html + '<td align=center><%=rid_idx%></td>';
							html = html + '<td align=center class="link" >'+unescape(Chara2.N3) +'</td>';
							html = html + '<td align=center>'+Char_Type2(unescape(Chara2.N4)) +'</td>';
							html = html + '<td align=center>'+unescape(Chara2.N8) +'</td>';
							html = html + '<td align=center>'+unescape(Chara2.N5) +'</td>';
							html = html + '<td align=center>'+unescape(Chara2.N6) +'</td>';
							html = html + '<td align=center><span class="btn_pack small icon"><span class="delete"></span><button type="button" class="chara_btn"><%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr> ';
						});
						$("#td_"+Chara.N1).html(html);
						html = '';
						
						$("#td_"+Chara.N1 + " > tr").click(function(){
							$("#Character_Info").load("/GMTool/Form/Form_Character_Detail.asp?id_idx=<%=rid_idx%>&Server="+$(this).attr('rel')+"&C_serial="+$(this).attr('summary') + "&C_name=" + escape($(this).attr('title')) + "&Socket="+$(this).attr("data"));
							$("#Character_Information").html("["+ $(this).attr('rel') + " - <font class=f_gre>"+ $(this).attr('title') +"</font>] ")
						});
						list_color("td_"+Chara.N1);
					}
				});	
				
			});
		}); 
		//]]>
	</script>
<style>
#tabs .ui-tabs-panel{ padding:0px}
</style>
	<div id="tabs"  style='height:165px'>
<%
		Call Server_Tab("")
		Dim obj_Ser
		Set obj_Ser = JSON.parse (Server_List)
		
		For cn = 0  to obj_Ser.length-1
			Response.Write "<div id='"& obj_Ser.get(cn).N2 &"'>"
			Char_Create_Table(obj_Ser.get(cn).N2)
			Response.Write "</div>"
		Next
			

%>
	</div>
	
<%

	
	Response.End

	Public Sub Char_Create_Table(trName)
%>
	<input type="hidden" name="Char_ID_IDX" id="Char_ID_IDX" value="<%=rid_idx%>">
	<table class="tbl_type" cellspacing="0" summary="Character list"> 
			<colgroup>
 			 	<col width="120"><col width="80">	
				<col width="150"><col width="80"><col width="60">
				<col width="80"><col width="150">
				<col width="60"><col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("T_Player_ID")%></th>
					<th><%=MsgExtract("T_IDX")%></th>
					<th><%=MsgExtract("T_Block_Ch")%></th>
					<th><%=MsgExtract("T_KIND")%></th>
					<th><%=MsgExtract("F4_Title011")%></th>
					<th><%=MsgExtract("T_Level")%></th>
					<th><%=MsgExtract("T_CHAR_DATE")%></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody id="td_<%=trName%>">
			
				<tr><td colspan=8>&nbsp;</td><td></td></tr>
				<tr><td colspan=8 align=center valign=middle><img src="/images/wait_fbisk.gif"></td><td></td></tr>
				<tr><td colspan=8>&nbsp;</td><td></td></tr>
			
			</tbody>
		</table>

<%
	End Sub
%>
