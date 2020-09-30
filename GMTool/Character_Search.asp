<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
	
</head>

<style> td{height:24px; font-size:12px;}</style>
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
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("TOOL_Mid2_Title")%></span></li><li class="on"><span><%=MsgExtract("TOOL_SM3_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("TOOL_SM3_Title")%></h3> 

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
				<col width="100"><col width="150">
				<col width="60"><col width="60">	
				<col width="100"><col width="80">
				<col width="150"><col width="80">
				<col width="80"><col width="*">
			</colgroup>

			<thead class="toolbar">
				<tr>
					<td colspan="10">
						<div class="fl2"><span id="spinner" style="padding-top:5px"></span>
						</div>
						<div class="fr2 item" style="float:left;"><% Server_Select %>
							<select id="s_gbn" name="s_gbn">
								<option value="C" selected><%=MsgExtract("T_Character")%></option><option value="I"><%=MsgExtract("T_Player_ID")%></option>
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
					<th><%=MsgExtract("Lab_Server")%></th>
					<th><%=MsgExtract("F3_Title002")%></th>
					<th><%=MsgExtract("F5_Title009")%></th>
					<th><%=MsgExtract("F7_Title005")%></th>
					<th><%=MsgExtract("T_Player_ID")%></th>
					<th><%=MsgExtract("T_IDX")%></th>
					<th><%=MsgExtract("F5_Title030")%></th>					
					<th><%=MsgExtract("T_Block")%></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody id="log_List">
				<tr><td colspan=9>&nbsp;</td><td></td></tr>
				<tr><td colspan=9 align=center valign=middle><img src="/images/wait_fbisk.gif"></td><td></td></tr>
				<tr><td colspan=9>&nbsp;</td><td></td></tr>
			</tbody>
			<tfoot>
				<tr><td colspan="10" style="border-top:1px solid #aaa"><div id="Pagination" class="pagination"></div></td></tr>
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
	var Json_url = "/common/class/GMTool/GMT_Character.class.asp";
	$(function($){
		menu_control(1, 0);
		
	});
	
	function gen_table(data){
		
		var html="";
		var class_b = "";
		$("#l_total").html(data.CNT);
		$("#t_page").html(data.PG);
		var server_select = $("select[name=Server] > option:selected").text();
		$.each(data.List, function(i,Player){
		
			html = html + '	<tr> ';
			html = html + '<td align=center>'+ server_select +'</td>'; 
			html = html + '<td align=center><a href="/GMtool/Character_Info2.asp?id_idx='+unescape(Player.N4)+'&PlayerID='+unescape(Player.N5)+'&Server='+server_select.toLowerCase()+'&Name='+Player.N1+'&Socket='+Player.N9+'" class="link" target="blank">'+unescape(Player.N1) +'</a></td>';
			html = html + '<td align=center>'+Char_Type2(unescape(Player.N2)) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N3) +'</td>';
			html = html + '<td align=center class="f_gre" style="cursor:pointer" rel="'+unescape(Player.N4)+'">'+unescape(Player.N5) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N4) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N7) +'</td>';
			class_b = (unescape(Player.N8) == 'ALLOW') ? 'class=f_blu style="cursor:pointer"' : 'class=f_red' ;
			html = html + '<td align=center '+ class_b +' rel="'+unescape(Player.N5)+'" >'+Block_Type(unescape(Player.N8)) +'</td>';

			html = html + '<td align=center><span class="btn_pack medium icon"><span class="delete"></span>';
			html = html + '<button type="button" id ="char_del_btn" class="chara_btn" rel="'+unescape(Player.N4)+'" data="'+ Player.N9 +'"><%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr> ';
		
		});		
		$("#log_List").empty().html(html);
		log_list_color();
		$("#spinner").empty();
		$("#log_List > tr > td:nth-child(5)").click(function(){
			Player_view($(this).attr('rel'));
		});
		
		$("#log_List > tr > td[class='f_blu']:nth-child(8) ").click(function(){
			Block_Player_form($(this).attr('rel'));
		});
		$("#log_List > tr > td[class='f_red']:nth-child(8) ").click(function(){
			
		});
		
		$('.chara_btn').click(function(){
			if (confirm('<%=MsgExtract("F1_Title044")%>')){
				var id_idx = $(this).attr("rel");
				var rSocket =  $(this).attr("data");
				
				$.ajax({  
					url: '/Common/class/GMTool/GMT_Character.class.asp?key=CHDEL&Server='+ server_select.toLowerCase() +'&id_idx='+ id_idx +'&Socket=' + rSocket,  
					cache: false,  
					success: function(data){
						if (data == '0000'){
							alert('<%=MsgExtract("F6_Title011")%>');
							argment_now(0);
						}  
					}
				});
				
			}
		});
		
		
	}
	
	
	//]]>
	</script>
</body>
</html>