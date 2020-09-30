<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
	
</head>
<style> td{height:24px; font-size:12px}</style> 
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
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("TOOL_Mid3_Title")%></span></li><li class="on"><span><%=MsgExtract("TOOL_SM6_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("TOOL_SM6_Title")%></h3> 

		<div class="tbl_top">
			<div class="fl"><%=MsgExtract("Lab_Total")%> : <span id="l_total">0</span> | <%=MsgExtract("Lab_Page")%> : [<span id="n_page">1</span>/<span id="t_page">1</span>]</div>
			<div class="fr">
				
				<div>
					<span><%=MsgExtract("Lab_List_View")%></span><br>
					<select id="pagesize" name="pagesize"><option value="20"> 20 </option><option value="30"> 30 </option><option value="40"> 40 </option><option value="50"> 50 </option></select>
				</div>
			</div>
		</div>


		<table class="tbl_type" cellspacing="0" summary="Player List"> 
			<colgroup>
				<col width="150">
				<col width="80"><col width="120">	
				<col width="150"><col width="80">
				<col width="150"><col width="150">
				<col width="80"><col width="*">
			</colgroup>

			<thead class="toolbar">
				<tr>
					<td colspan="9">
						<div class="fl2">
							<span id="spinner" style="padding-top:5px"></span>
						</div>
						<div class="fr2 item">
							<% Server_Select %>  
							<select id="s_gbn" name="s_gbn"> 
								<option value="G" selected><%=MsgExtract("F9_Title001")%></option></option>
							</select>
							<input type="text" id="s_item" name="s_item" value="" class="i_text" >
							<span class="btn_pack medium icon"><span class="seach"></span><button type="submit" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
							<span class="btn_pack medium icon"><span class="calendar"></span><button type="button" id="i_list" disabled="disabled">List</button></span>
						</div>	
					</td>
				</tr>
			</thead>

			<thead class="toolbar">
				<tr>
					 
					<th><%=MsgExtract("F9_Title001")%></th>
					<th><%=MsgExtract("F9_Title002")%></th>
					<th><%=MsgExtract("F9_Title003")%></th>
					<th><%=MsgExtract("F9_Title004")%></th>
					<th><%=MsgExtract("F9_Title005")%></th>
					<th><%=MsgExtract("F9_Title006")%></th>
					<th><%=MsgExtract("F9_Title007")%></th>
					<th><%=MsgExtract("F9_Title008")%></th>
					<th></th>
				</tr>
			</thead>
			<tbody id="log_List">
			
			</tbody>
			<tfoot>
				<tr><td colspan="9" style="border-top:1px solid #aaa"><div id="Pagination" class="pagination"></div></td></tr>
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
	var Json_url = "/common/class/GMTool/GMT_Guild.class.asp";
	$(function($){
		menu_control(2, 0);
		$("select[name=Server]").append("<option value='A'>ALL</option>");
	});
	
	function gen_table(data){
		
		var html="";
		var class_b = "";
		$("#l_total").html(data.CNT);
		$("#t_page").html(data.PG);
		
		var server_select = $("select[name=Server] > option:selected").text();
		$.each(data.List, function(i,Player){
		
			html = html + '	<tr> ';
			html = html + '<td align=center class="link" rel="'+unescape(Player.N1)+'"><a href="/GMTool/Guild_List_member.asp?Guild_code='+unescape(Player.N1)+'&Server='+server_select+'">'+unescape(Player.N2) +'</a></td>';
			html = html + '<td align=center><a href="/GMTool/Guild_List_member.asp?Guild_code='+unescape(Player.N1)+'&Server='+server_select+'">'+unescape(Player.N3) +'</a></td>';
			html = html + '<td align=right>'+formatNumber(unescape(Player.N4)) +'</td>';
			html = html + '<td align=center><a href="/GMtool/Character_Info2.asp?id_idx='+unescape(Player.N11)+'&PlayerID='+unescape(Player.N10)+'&Server='+server_select.toLowerCase()+'&Name='+Player.N5+'&Socket='+Player.N12+'" class="link" target="blank" >'+unescape(Player.N5) +'</a></td>';
			html = html + '<td align=center>'+Char_Type2(unescape(Player.N6)) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N7) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N8) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N9) +'</td>';
			html = html + '<td align=center></td></tr>';
		
		});		
		$("#log_List").empty().html(html); 
		log_list_color(); 
		$("#spinner").empty(); 
		/*$("#log_List > tr > td:nth-child(1)").click(function(){
			form_modal_load('/GMtool/Form/Form_Guild_Info.asp?Guild_code='+escape($(this).attr('rel'))+'&Server='+server_select, 'Character Information', 570, 335);
		});*/
	}
	
	
	//]]>
	</script>
</body>
</html>