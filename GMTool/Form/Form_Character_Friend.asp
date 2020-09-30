<!--#include virtual="/common/Function/option_explicit.asp"-->
<object runat="Server" progid="Scripting.FileSystemObject" id="fsc"></object>
<!--#include virtual="/Common/JSON_INI/Server_CONFIG.asp"-->
<% Now_Position ="GMTool"%>
<script language="javascript" runat="server" src="/common/function/json2.min.asp"></script>
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Common/Function/function.asp"-->
<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim cn

%>
<style>
	#friends_List td{height:22px}
</style>
<script>
	 $("select[name=Server]").val('<%=rServer%>');
	 $("select[name=Server]").hide();
	 
	 Json_url = "/common/class/GMTool/GMT_Character_Friend.class.asp";
	$(function($){
	argment_now(0);
		
	});
	function gen_table(data){
		 
		var html="";
		var class_b = "";
		var server_select = $("select[name=Server] > option:selected").text();
		var class_b = "";
		
			$("#l_total").html(data.CNT);
			$("#t_page").html(data.PG);
			$("#N_Server").html(server_select);
			$("#N_Player").html('<div class="f_gre" rel="'+ data.N2 +'">' + data.N4 + '</div>');
			$("#N_PlayerName").html(data.N1);
		if (data.List.length !=0 ){
			$.each(data.List, function(i,Friend){
			
				html = html + '<tr>';
				html = html + '<td align=center class="f_gre" style="cursor:pointer" rel="'+unescape(Friend.N3)+'">'+ unescape(Friend.N1) +'</td>'; 
				html = html + '<td align=center>'+unescape(Friend.N3)+'</td>';
				html = html + '<td align=center class="link"><a href="/GMtool/Character_Info2.asp?id_idx='+unescape(Friend.N3)+'&PlayerID='+unescape(Friend.N1)+'&Server='+server_select.toLowerCase()+'&Name='+Friend.N4+'&Socket='+Friend.N7+'" class="link" target="blank" >'+unescape(Friend.N4) +'</a></td>';
				html = html + '<td align=center>'+Char_Type2(unescape(Friend.N7))+'</td>';
				html = html + '<td align=center>'+ unescape(Friend.N5) +'</td>';
				html = html + '<td align=center>'+   Enum_data.ITEM_DB_YN[unescape(Friend.N6)].N2+'</td>';
				class_b = (unescape(Friend.N2) == 'ALLOW') ? 'class=f_blu style="cursor:pointer"' : 'class=f_red' ;
				html = html + '<td align=center '+ class_b +' rel="'+unescape(Friend.N1)+'">'+Block_Type(unescape(Friend.N2)) +'</td>';
				html = html + '<td><span class="btn_pack medium icon"><span class="delete"></span>';
				html = html + '<button TYPE=button id="btn_del" rel="'+ unescape(Friend.N3) +'" data="'+ unescape(Friend.N7) +'">&nbsp;<%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr>';
			});		
			
			$("#friends_List").empty().html(html);
			log_list_color();
			$("#friends_List > tr > td:nth-child(1)").click(function(){
			Player_view($(this).attr('rel'));
			});
			$("#friends_List > tr > td[class='f_blu']:nth-child(7) ").click(function(){
				Block_Player_form($(this).attr('rel'));
			});
			
			
			$("button[id^=btn_del]").click(function(){
				var id_idx = $(this).attr('rel');
				var Socket = $(this).attr('data');
				var del_url = "/Common/Class/GMTool/GMT_Character_Friend.class.asp?key=F_DEL&Server=<%=rServer%>&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Fid_idx="+id_idx + "&FSocket="+Socket ;
				if (confirm('<%=MsgExtract("F9_Title032")%>')){
					var id_idx = $(this).attr("rel");
					var rSocket =  $(this).attr("data");
					
					$.ajax({  
						url:del_url,  
						cache: false,  
						success: function(data){
							if (data == '0000'){
								alert('<%=MsgExtract("F2_Title029")%>');
								argment_now(0);
							}  
						}
					});
				}
			});
			
		}else{
 
				
				html = html + '<tr height=540><td colspan=7 align=center valign=middle><%=MsgExtract("F7_Title010")%></td><td></td></tr>';
				
				$("#friends_List").empty().html(html);
		
		}
		
		$("#spinner").empty();
		
	}
	
</script>
<div class="ui-widget-header char_title" rel="<%=rid_idx%>"> <font class='f_blu'><%=MsgExtract("TOOL_SM7_Title")%></font> <input type="hidden" id="s_item" name="s_item" value="<%=rC_serial%>" class="i_text" ><input type="hidden" id="I_Pro" name="I_Pro" value="SEARCH" ></div>
<div class="tbl_top">
	<div class="fl"><%=MsgExtract("Lab_Total")%> : <span id="l_total">0</span> | <%=MsgExtract("Lab_Page")%> : [<span id="n_page">1</span>/<span id="t_page">1</span>]<% Server_Select %></div>
	<div class="fr">
		
		<div style="display:none">
			<span><%=MsgExtract("Lab_List_View")%></span><br>
			<select id="pagesize" name="pagesize"><option value="20"> 20 </option><option value="30"> 30 </option><option value="40"> 40 </option><option value="50"> 50 </option></select>
		</div>
	</div>
</div>
<table class="tbl_type" cellspacing="0" summary="item List" width="100%"> 
	<colgroup>
		<col width="150"><col width="100"><col width="150">
		<col width="80"><col width="80">	
		<col width="80"><col width="100"><col width="80">
		<col width="*">
	</colgroup>
	<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("F8_Title001")%></th>
					<th><%=MsgExtract("T_IDX")%></th>
					<th><%=MsgExtract("F8_Title002")%></th>
					<th><%=MsgExtract("F8_Title003")%></th>
					<th><%=MsgExtract("F8_Title004")%></th>
					<th><%=MsgExtract("F9_Title010")%></th>
					<th><%=MsgExtract("T_Block")%></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
	<tbody id="friends_List">
		
		<tr height="540" ><td colspan=8 align=center valign=middle><img src="/images/wait_fbisk.gif"></td><td></td></tr>
		
	</tbody>
	<tfoot>
		<tr><td colspan="9" style="border-top:1px solid #aaa"><div id="Pagination" class="pagination"></div></td></tr>
	</tfoot>
</table>