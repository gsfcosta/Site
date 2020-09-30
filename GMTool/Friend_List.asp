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
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("TOOL_Mid3_Title")%></span></li><li class="on"><span><%=MsgExtract("TOOL_SM7_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("TOOL_SM7_Title")%></h3> 

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
				<col width="150"><col width="100"><col width="150">
				<col width="80"><col width="80">	
				<col width="80"><col width="100"><col width="80">
				<col width="*">
			</colgroup>

			<thead class="toolbar">
				<tr>
					<td colspan="9">
						<div class="fl2"><span id="spinner" style="padding-top:5px"></span>
						</div>
						<div class="fr2 item" style="float:left;"><% Server_Select %>
							<select id="s_gbn" name="s_gbn">
								<option value="C" selected><%=MsgExtract("F8_Title002")%></option>
							</select>
							<input type="text" id="s_item" name="s_item" value="" class="i_text" ><input type="hidden" id="I_Pro" name="I_Pro" value="SEARCH" >
							<span class="btn_pack medium icon"><span class="seach"></span><button type="submit" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
							<span class="btn_pack medium icon"><span class="calendar"></span><button type="button" id="i_list" disabled="disabled">List</button></span>
						</div>	
					</td>
				</tr> 
			</thead>
			<tbody id="Character_Info">
				<tr><td colspan=8  class="form_table" style="padding:0">
					<table  cellspacing="0" border="0">
						<colgroup>
							<col width="15%"><col width="15%"><col width="15%"><col width="15%"><col width="15%"><col width="15%">
						</colgroup>
						<tbody>
						<tr>
							<th style="border:0px"><%=MsgExtract("Lab_Server")%></th>
							<td style="border:0px" id="N_Server"></td>
							<th style="border:0px"><%=MsgExtract("F8_Title001")%></th>
							<td style="border:0px" id="N_Player"></td>
							<th style="border:0px"><%=MsgExtract("F8_Title002")%></th>
							<td style="border:0px" id="N_PlayerName"></td>
							
						</tr>
						</tbody>
					</table>
				</td><td></td></tr>
			</tbody>
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
			<tbody id="log_List">
				<tr><td colspan=7>&nbsp;</td><td></td></tr>
				<tr><td colspan=7 align=center valign=middle><%=MsgExtract("F7_Title009")%></td><td></td></tr>
				<tr><td colspan=7>&nbsp;</td><td></td></tr>
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
	var Json_url = "/common/class/GMTool/GMT_Character_Friend.class.asp";
	$(function($){
		menu_control(2, 1);
		
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
				html = html + '<td align=center class="f_gre" rel="'+unescape(Friend.N3)+'">'+ unescape(Friend.N1) +'</td>'; 
				html = html + '<td align=center>'+unescape(Friend.N3)+'</td>';
				html = html + '<td align=center><a href="/GMtool/Character_Info2.asp?id_idx='+unescape(Friend.N3)+'&PlayerID='+unescape(Friend.N1)+'&Server='+server_select.toLowerCase()+'&Name='+Friend.N4+'&Socket='+Friend.N7+'" class="link" target="_blank">'+unescape(Friend.N4) +'</a></td>';
				html = html + '<td align=center>'+Char_Type2(unescape(Friend.N8)) +'</td>';
				html = html + '<td align=center>'+ unescape(Friend.N5) +'</td>';
				html = html + '<td align=center>'+   Enum_data.ITEM_DB_YN[unescape(Friend.N6)].N2+'</td>';
				class_b = (unescape(Friend.N2) == 'ALLOW') ? 'class=f_blu' : 'class=f_red' ;
				html = html + '<td align=center '+ class_b +' rel="'+unescape(Friend.N1)+'">'+Block_Type(unescape(Friend.N2)) +'</td>';
				html = html + '<td><span class="btn_pack medium icon"><span class="delete"></span>';
				html = html + '<button TYPE=button id="btn_del" rel="'+ unescape(Friend.N3) +'" data="'+ unescape(Friend.N7) +'">&nbsp;<%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr>';
			
			});		
			
			$("#log_List").empty().html(html);
			log_list_color();
			$("#log_List > tr > td:nth-child(1)").click(function(){
			Player_view($(this).attr('rel'));
			});
			$("button[id^=btn_del]").click(function(){
				var id_idx = $(this).attr('rel');
				var Socket = $(this).attr('data');
				var del_url = "/Common/Class/GMTool/GMT_Character_Friend.class.asp?key=F_DEL&Server="+ server_select.toLowerCase() +"&id_idx="+data.N2 + "&Socket="+ data.N3 + "&Fid_idx="+id_idx + "&FSocket="+Socket ;
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
 
				html = html + '<tr><td colspan=8>&nbsp;</td><td></td></tr>';
				html = html + '<tr><td colspan=8 align=center valign=middle><%=MsgExtract("F7_Title009")%></td><td></td></tr>';
				html = html + '<tr><td colspan=8>&nbsp;</td><td></td></tr>';
				$("#log_List").empty().html(html);
				
		
		}
		$("#N_Player > div").click(function(){
			Player_view($(this).attr('rel'));
		});
		$("#spinner").empty();
		
	}
	
	
	//]]>
	</script>

</body>
</html>