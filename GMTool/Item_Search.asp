<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
	
</head>

<style> td{height:24px;font-size:12px;}</style>
<body>
<div id="wrap">
	<div id="header">
		<!--#include virtual="/common/Include/Header.asp"-->
	</div>
	<div id="container" style="padding-bottom:10px;">
		<div class="snb">
			<!--#include virtual="/common/Include/GMTool_Left.asp"-->
		</div>
		<div id="content">
		
		<div class="progress">
				<strong class="tit"><%=MsgExtract("Lab_Home")%></strong> 
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("TOOL_Mid2_Title")%></span></li><li class="on"><span><%=MsgExtract("TOOL_SM5_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("TOOL_SM5_Title")%></h3> 

		<div class="tbl_top">
			<div class="fl"><%=MsgExtract("Lab_Total")%> : <span id="l_total">0</span> | <%=MsgExtract("Lab_Page")%> : [<span id="n_page">1</span>/<span id="t_page">1</span>]</div>
			<div class="fr">
				
				<div>
					<span><%=MsgExtract("Lab_List_View")%></span><br>
					<select id="pagesize" name="pagesize"><option value="30"> 30 </option><option value="50"> 50 </option><option value="80"> 80 </option><option value="100"> 100 </option></select>
				</div>
			</div>
		</div>


		<table class="tbl_type" cellspacing="0" summary="Player List"> 
			<colgroup>
				<col width="100"><col width="150">
				<col width="60"><col width="60">	
				<col width="80"><col width="150">
				<col width="80"><col width="80">
				<col width="80"><col width="150"><col width="*">
			</colgroup>

			<thead class="toolbar">
				<tr>
					<td colspan="11">
						<div class="fl2"><span id="spinner" style="padding-top:5px"></span>
						</div>
						<div class="fr2 item" style="float:left;"><% Server_Select %>
							<select id="s_gbn" name="s_gbn">
								<option value="S" selected><%=MsgExtract("F9_Title012")%></option>
							</select>
							<input type="text" id="s_item" name="s_item" value="" class="i_text" >
							<input type="hidden" id="I_Pro" name="I_Pro" value="SEARCH" >
							<span class="btn_pack medium icon"><span class="seach"></span><button type="submit" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
							<span class="btn_pack medium icon"><span class="calendar"></span><button type="button" id="i_list" disabled="disabled">List</button></span>
						</div>	
					</td>
				</tr> 
			</thead>

			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("F8_Title001")%></th>
					<th><%=MsgExtract("F8_Title002")%></th>
					<th><%=MsgExtract("F8_Title003")%></th>
					<th><%=MsgExtract("F8_Title004")%></th>
					<th><%=MsgExtract("F8_Title005")%></th>
					<th><%=MsgExtract("F9_Title013")%></th>
					<th><%=MsgExtract("F8_Title007")%></th>					
					<th><%=MsgExtract("F8_Title008")%></th>
					<th><%=MsgExtract("F8_Title009")%></th>
					<th><%=MsgExtract("F8_Title010")%></th>
					<th></th>
				</tr>
			</thead>
			<tbody id="log_List">
				<tr><td colspan=10>&nbsp;</td><td></td></tr>
				<tr><td colspan=10 align=center valign=middle><%=MsgExtract("F7_Title009")%></td><td></td></tr>
				<tr><td colspan=10>&nbsp;</td><td></td></tr>
			</tbody>
			<tfoot>
				<tr><td colspan="11" style="border-top:1px solid #aaa"><div id="Pagination" class="pagination"></div></td></tr>
			</tfoot>
		</table>
		</div>
	</div>
	<!-- footer -->
	<div id="footer">
	<!--#include virtual="/common/Include/Footer.asp"-->
	</div>
	<!--//footer -->
	<div id ="ins_form"></div>
</div>

<script language=javascript>
	//<![CDATA[	
	var Json_url = "/Common/Class/GMTool/GMT_Character_Item.class.asp";
	$(function($){
		menu_control(1, 2);
		
	});
	function gen_table(data){
		
		var html="";
		var class_b = "";
		if (data.List.length !=0 ){
			$("#l_total").html(data.CNT);
			$("#t_page").html(data.PG);
			var server_select = $("select[name=Server] > option:selected").text();
			
			$.each(data.List, function(i,Item){
			//s_item_search
				html = html + '<tr>';
				html = html + '<td align=center class="f_gre" rel="'+unescape(Item.N1)+'">'+ unescape(Item.N11) +'</td>'; 
				html = html + '<td align=center><a href="/GMtool/Character_Info2.asp?id_idx='+unescape(Item.N1)+'&PlayerID='+unescape(Item.N11)+'&Server='+server_select.toLowerCase()+'&Name='+Item.N2+'&Socket='+Item.N5+'" class="link" target="blank">'+ unescape(Item.N2) +'</a></td>';
				html = html + '<td align=center>'+ Char_Type2(unescape(Item.N3)) +'</td>';
				html = html + '<td align=center>'+ unescape(Item.N4) +'</td>';
				html = html + '<td align=center>'+ unescape(Item.N5) +'</td>';
				html = html + '<td align=center>'+ s_item_search(unescape(Item.N6)) +'</td>';
				html = html + '<td align=center>'+ unescape(Item.N7) +'</td>';
				html = html + '<td align=center>'+ unescape(Item.N8) +'</td>';
				html = html + '<td align=center>'+ unescape(Item.N9) +'</td>';
				html = html + '<td align=center>'+ unescape(Item.N10) +'</td><td></td></tr> ';
			
			});		
			
			$("#log_List").empty().html(html);
			log_list_color();
			$("#log_List > tr > td:nth-child(1)").click(function(){
			Player_view($(this).attr('rel'));
			});
		}
		$("#spinner").empty();
		
	}
	
	
	//]]>
	</script>

</body>
</html>