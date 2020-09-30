<!--#include virtual="/common/Function/option_explicit.asp"-->

<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
	<script language=javascript>
	//<![CDATA[	
	var Json_url = "";
	$(function($){
		Json_url = "/common/class/GMLOG/Log_Movement.Class.asp";
		menu_control(0, 2);
		//argment_now(0);
	});
	
	function gen_table(data){
		var html="";
		var suc = 0;
		var item_create_type_name = "";
		var s_Server	= $("div.fr > div > select[name=Server] > option:selected").val();
		$("#l_total").html(data.CNT);
		$("#t_page").html(data.PG);
		$.each(data.List, function(i,LoginLog){
		
			html = html + '	<tr> ';
			html = html + '<td align=center ID="logD">'+unescape(LoginLog.N1) +'</td>';
			if (unescape(LoginLog.N2) == 0){
				html = html + '<td align=center>-</td>';
			}else{
				html = html + '<td align=center>'+s_zone_search(unescape(LoginLog.N2)) +'</td>';
			}
			html = html + '<td align=center class="link" rel="'+unescape(LoginLog.N12)+'">'+Enum_data.M_LogType[unescape(LoginLog.N3)].N2+'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N4) +'</td>';
			if ( parseInt(LoginLog.N3) == 1){  
			html = html + '<td align=center>'+unescape(LoginLog.N5) +'</td>';
			
			}else{
			html = html + '<td align=center><a href="/GMtool/Character_Info2.asp?id_idx='+unescape(LoginLog.N6)+'&Server='+s_Server+'&Name='+LoginLog.N5+'&Socket='+LoginLog.N7+'" class="link" target="blank" >'+unescape(LoginLog.N5) +'</a></td>';
			}
			html = html + '<td align=center class="f_gre" style="cursor:hand">'+unescape(LoginLog.N6) +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N7) +'</td>';
			if (unescape(LoginLog.N8) == "0"){
				html = html + '<td align=center>'+unescape(LoginLog.N8) +'</td>';
			}else{
				html = html + '<td align=center class="link">'+unescape(LoginLog.N8) +'</td>';
			}
			
			html = html + '<td align=center>'+Enum_data.M_LogType[unescape(LoginLog.N9)].N2 +'</td>';
			html = html + '<td align=center>'+Enum_data.M_LogType[unescape(LoginLog.N9)].N3[unescape(LoginLog.N10)].S2 +'</td>';
			html = html + '<td align=right>'+unescape(LoginLog.N11) +'</td><td></td></tr> ';
		
		});		
		
		$("#log_List").empty().html(html);
		log_list_color();
		$("#spinner").empty();
		
		$("#log_List > tr > td:nth-child(3)").click(function(){
			
			$("#R_Se").empty().html( $("div.fr > div > select[name=Server] > option:selected").val());
			$("#R_Ti").empty().html($(this).prev().prev().html());
			$("#R_Zo").empty().html($(this).prev().html());
			$("#R_Lt").empty().html($(this).html());
			$("#Detail_log_List1").empty();
			Item_log_detail($(this).attr("rel"));
		});
		$("#log_List > tr > td:nth-child(6)").click(function(){
			//alert($(this).text())
			Player_view($(this).text());
		});
		$("#log_List > tr > td:nth-child(8)").click(function(){
			var sp_rel = "";
			if ($(this).html() != "0"){

				$("#R_Se2").empty().html( $("div.fr > div > select[name=Server] > option:selected").val());
				$("#R_Oi2").empty().html(($(this).parent().children("td:eq(4)").html()));
				$("#R_Dt2").empty().html(($(this).parent().children("td:eq(5)").html()));
				$("#R_On2").empty().html(($(this).parent().children("td:eq(6)").html()));
				$("#R_Os2").empty().html($(this).html());

				Item_log_detail2($(this).html());
			}
		});
	}
	
	function Item_log_detail(log_serial){
		var html = "";
		var s_Server="";
		var s_period="";
		var s_Sdate="";
		var s_Edate="";
		var suc = "";
		var im_c_se = "";
		 
		s_Server	= $("div.fr > div > select[name=Server] > option:selected").val();
		s_period	= $("div.fr > div > select[name=s_period] > option:selected").val();
		
		if 	(s_period != "T"){
			s_Sdate = $.trim($("#s_Sdate").val());
			s_Edate = $.trim($("#s_Edate").val());
		}else{
			s_Sdate = "";
			s_Edate = "";
		}
		$.getJSON(Json_url +"?CN=LD1&Server="+s_Server+"&s_period="+s_period+"&LogSerial="+log_serial+"&s_Sdate="+s_Sdate+"&s_Edate="+s_Edate,	function(data){
		
			$.each(data.List, function(i,LoginLog){
				
				html = html + '	<tr> ';
				if (im_c_se != unescape(LoginLog.N5) ){
					im_c_se = unescape(LoginLog.N5);
					html = html + '<td align=center>'+unescape(LoginLog.N1) +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N2) +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N3) +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N4) +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N5) +'</td>';
				}else{
					html = html + '<td >&nbsp;</td>';
					html = html + '<td >&nbsp;</td>';
					html = html + '<td >&nbsp;</td>';
					html = html + '<td >&nbsp;</td>';
					html = html + '<td >&nbsp;</td>';
				}
					html = html + '<td align=center>'+Enum_data.M_LogType[unescape(LoginLog.N7)].N2 +'</td>';
					html = html + '<td align=center >'+Enum_data.M_LogType[unescape(LoginLog.N7)].N3[unescape(LoginLog.N8)].S2 +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N6) +'</td>';
					html = html + '<td align=center >'+Enum_data.RemarkType[unescape(LoginLog.N9)].N2 +'</td>';
					html = html + '<td align=right >'+unescape(LoginLog.N10) +'</td>';
					html = html + '<td align=right >'+unescape(LoginLog.N11) +'</td></tr> ';

			});		
			
			$("#Detail_log_List1").empty().html(html);
			
					
		});
		log_dialog_form($('#Log_Detail1'), 'Movement Detail Log');
		
	
	}
	function Item_log_detail2(char_serial){
		var html = "";
		var s_Server="";
		var s_period="";
		
		var suc = "";
		 
		s_Server	= $("div.fr > div > select[name=Server] > option:selected").val();
		
		$.getJSON(Json_url +"?CN=LD2&Server="+s_Server+"&char_serial="+char_serial,	function(data){
		
			$.each(data.List, function(i,LoginLog){
				
				html = html + '	<tr> ';
				html = html + '<td align=center>'+unescape(LoginLog.N1) +'</td>';
				html = html + '<td align=center>'+unescape(LoginLog.N2) +'</td>';
				if (unescape(LoginLog.N3) == 0){
					html = html + '<td align=center>-</td>';
				}else{
					html = html + '<td align=center>'+s_zone_search(unescape(LoginLog.N3)) +'</td>';
				}
				html = html + '<td align=center>'+Enum_data.M_LogType[unescape(LoginLog.N4)].N2 +'</td>';
				html = html + '<td align=center>'+Enum_data.M_LogType[unescape(LoginLog.N5)].N2 +'</td>';
				suc = unescape(LoginLog.N6);
				html = html + '<td>'+Enum_data.M_LogType[unescape(LoginLog.N5)].N3[suc].S2 +'</td>';
				html = html + '<td align=center >'+unescape(LoginLog.N7) +'</td></tr> ';

			});		
			
			$("#Detail_log_List2").empty().html(html);
			
					
		});
		log_dialog_form($('#Log_Detail2'), 'Item Trace Log');
		
	}
	//]]>
	</script>
	
</head>

<style> td{height:20px}</style>
<body>
<div id="wrap">
	<div id="header">
		<!--#include virtual="/common/Include/Header.asp"-->
	</div>
	<div id="container" style="padding-bottom:10px;">
		<div class="snb">
			<!--#include virtual="/common/Include/GMLog_Left.asp"-->
		</div>
		<div id="content">
			
			<div class="progress">
				<strong class="tit"><%=MsgExtract("Lab_Home")%></strong> 
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("LOG_Mid1_Title")%></span></li><li class="on"><span><%=MsgExtract("LOG_SM3_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("LOG_SM3_Title")%></h3> 

		<div class="tbl_top">
			<div class="fl"><%=MsgExtract("Lab_Total")%> : <span id="l_total">0</span> | <%=MsgExtract("Lab_Page")%> : [<span id="n_page">1</span>/<span id="t_page">1</span>]</div>
			<div class="fr">
				<div>
					<span><%=MsgExtract("Lab_Period")%></span><br>
					<select id="s_period" name="s_period">
						<option value="T" selected>Today</option><option value="W">Week</option><option value="M">Month</option><option value="C">Custom</option>
					</select><div id="Period_form" style="display:none"><input type="text" id="s_Sdate" name="s_Sdate" value="<%=DateFormat(now(), "yyyy-MM-dd")%>" class="i_text" style="width:70px">-<input type="text" id="s_Edate" name="s_Edate" value="<%=DateFormat(now(), "yyyy-MM-dd")%>" class="i_text" style="width:70px"></div>
				</div>
				<div>
					<span><%=MsgExtract("Lab_Server")%></span><br>
					<% Server_Select %>
				</div>
				<div>
					<span><%=MsgExtract("Lab_List_View")%></span><br>
					<select id="pagesize" name="pagesize"><option value="30"> 30 </option><option value="50"> 50 </option><option value="80"> 80 </option><option value="100"> 100 </option><option value="300"> 300 </option><option value="500"> 500 </option><option value="1000"> 1000 </option></select>
				</div>
			</div>
		</div>


		<table class="tbl_type" cellspacing="0" summary="Item Log List"> 
			<colgroup>
				<col width="140"><col width="120">
				<col width="100"><col width="120">
				<col width="120"><col width="80">
				<col width="40"><col width="150">
				<col width="100"><col width="120">
				<col width="50"><col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<td colspan="12">
						<div class="fl2">
							
							
							<span id="spinner" style="padding-top:5px"></span>
						</div>
						<div class="fr2 item">
							<select id="s_gbn" name="s_gbn">
								<option value="IDX" selected><%=MsgExtract("T_Login_IDX")%></option><option value="OBJIDX"><%=MsgExtract("T_Login_Objidx")%></option><option value="HIdx"><%=MsgExtract("T_Login_IH")%></option><option value="Hname"><%=MsgExtract("T_Login_Ch")%></option><option value="IP"><%=MsgExtract("T_Login_IP")%></option>
							</select>
							<input type="text" id="s_item" name="s_item" value="" class="i_text" >
							<span class="btn_pack medium icon"><span class="seach"></span><button type="submit" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
							<span class="btn_pack medium icon"><span class="calendar"></span><button id="i_list" disabled="disabled">List</button></span>
						</div>	
					</td>
				</tr>
			</thead>

			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("T_Log_Time")%></th>
					<th><%=MsgExtract("T_Login_Zone")%></th>
					<th><%=MsgExtract("T_Log_Type")%></th>
					<th><%=MsgExtract("T_Login_IP")%></th>
					<th><%=MsgExtract("T_Login_Ch")%></th>
					<th><%=MsgExtract("T_Login_IDX")%></th>
					<th><%=MsgExtract("T_Login_Sock")%></th>
					<th><%=MsgExtract("T_Login_Serial")%></th>
					<th><%=MsgExtract("T_Log_Log_Type")%></th>
					<th><%=MsgExtract("T_Log_Detail")%></th>
					<th><%=MsgExtract("T_Value")%></th>
					<th></th>
				</tr>
			</thead>
			<tbody id=log_List>
				<tr>
					<td colspan="12" style="height: 600px; text-align:center">
						<%=MsgExtract("T_Default")%>
					</td>
				
				</tr>
			</tbody>
			<tfoot>
				<tr><td  colspan="12" style="border-top:1px solid #aaa"><div id="Pagination" class="pagination"></div></td></tr>
			</tfoot>
		</table>
				
		</div>
	</div>
	<!-- footer -->
	<div id="footer">
	<!--#include virtual="/common/Include/Footer.asp"-->
	</div>
	<!--//footer -->
	<div id="Log_Detail1" style="display:none">
		<table class="tbl_type" cellspacing="0" summary="Item Log Detail" style="margin-top:10px;margin-bottom:20px; width:600px" align="left"> 
			<colgroup>
				<col width="140"><col width="140"><col width="140"><col width="*">
			</colgroup>
		
			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("Lab_Server")%></th>
					<th><%=MsgExtract("T_Log_Time")%></th>
					<th><%=MsgExtract("T_Login_Zone")%></th>
					<th><%=MsgExtract("T_Log_Type")%></th>
				</tr>
		
			</thead>
			<tbody>
				<tr>
					<td id="R_Se"></td>
					<td id="R_Ti"></td>
					<td id="R_Zo"></td>
					<td id="R_Lt"></td>
				</tr>
			</tbody>
		</table>
		<table class="tbl_type" cellspacing="0" summary="Item Log Detail"> 
			
			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("T_Login_IP")%></th>
					<th><%=MsgExtract("T_Login_Ch")%></th>
					<th><%=MsgExtract("T_Login_IDX")%></th>
					<th><%=MsgExtract("T_Login_Sock")%></th>
					<th><%=MsgExtract("T_Login_Serial")%></th>
					<th><%=MsgExtract("T_Log_Log_Type")%></th>
					<th><%=MsgExtract("T_Log_Detail")%></th>
					<th><%=MsgExtract("T_Value")%></th>
					<th><%=MsgExtract("Lab_Change_Type")%></th>
					<th><%=MsgExtract("Lab_Change_Before")%></th>
					<th><%=MsgExtract("Lab_Change_After")%></th>
				</tr>
		
			</thead>
			<tbody  id="Detail_log_List1">

			</tbody>
		</table>
	</div>
	<div id="Log_Detail2" style="display:none">
		<table class="tbl_type" cellspacing="0" summary="Item Log Detail2" style="margin-top:10px;margin-bottom:20px; width:500px" align="left"> 
			<colgroup>
				<col width="100"><col width="100"><col width="100"><col width="100"><col width="100">
			</colgroup>
		
			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("Lab_Server")%></th>
					<th><%=MsgExtract("T_Login_Ch")%></th>
					<th><%=MsgExtract("T_Login_IDX")%></th>
					<th><%=MsgExtract("T_Login_Sock")%></th>
					<th><%=MsgExtract("T_Login_Serial")%></th>
					
				</tr>
		
			</thead>
			<tbody>
				<tr>
					<td id="R_Se2"></td>
					<td id="R_Oi2"></td>
					<td id="R_Dt2"></td>
					<td id="R_On2"></td>
					<td id="R_Os2"></td>
					
				</tr>
			</tbody>
		</table>
		<table class="tbl_type" cellspacing="0" summary="Item Log Detail"> 
			
			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("T_Log_Time")%></th>
					<th><%=MsgExtract("T_Login_IP")%></th>
					<th><%=MsgExtract("T_Login_Zone")%></th>
					<th><%=MsgExtract("T_Log_Type")%></th>
					<th><%=MsgExtract("T_Log_Log_Type")%></th>
					<th><%=MsgExtract("T_Log_Detail")%></th>
					<th><%=MsgExtract("T_Value")%></th>
				</tr>
		
			</thead>
			<tbody  id="Detail_log_List2">

			</tbody>
		</table>
	</div>
</div>
<div id ="ins_form"></div>
</body>
</html>