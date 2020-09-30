<!--#include virtual="/common/Function/option_explicit.asp"-->
<%
'/**************************DEFINE CONSTANT HERE***************************
'*  /Gmtool/Item_Log.asp
'*  Description: Item & Hench log 
'*  Date: 2011.10.12
'*  Author: Tae-Young Kim(tykim@auroragames.co.kr, geojangbi@naver.com)
'*  Params: 
'*  Last Modified: 
'*************************************************************************/
%>
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
	<script language=javascript>
	//<![CDATA[	
	var Json_url = "";
	$(function($){
		Json_url = "/common/class/GMLOG/LOG_Item.Class.asp";
		menu_control(0, 1);
		
		$( "#radio_f" ).buttonset();
		
		$("#radio1").click(function(){
			Json_url = "/common/class/GMLOG/LOG_Item.Class.asp";
			argment_now(0);

		});
		$("#radio2").click(function(){
			Json_url = "/common/class/GMLOG/LOG_Super.Class.asp";
			argment_now(0);
		});
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
			html = html + '<td align=center>'+s_zone_search(unescape(LoginLog.N2)) +'</td>';
			html = html + '<td align=center class="link" rel="'+unescape(LoginLog.N17)+'">'+Enum_data.LogType[unescape(LoginLog.N3)].N2 +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N4) +'</td>';
			html = html + '<td align=center><a href="/GMtool/Character_Info2.asp?id_idx='+unescape(LoginLog.N6)+'&Server='+s_Server+'&Name='+LoginLog.N5+'&Socket='+LoginLog.N7+'" class="link" target="blank" >'+unescape(LoginLog.N5) +'</a></td>';
			html = html + '<td align=center class="f_gre" style="cursor:pointer">'+unescape(LoginLog.N6) +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N7) +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N8) +'</td>';
			html = html + '<td align=center>'+Enum_data.DataType[unescape(LoginLog.N9)].N2 +'</td>';
			html = html + '<td align=center>'+Enum_data.LogType[unescape(LoginLog.N10)].N2 +'</td>';
			if (unescape(LoginLog.N16) == 1){
			suc = parseInt(unescape(LoginLog.N11)) + 3;
			}else{
			suc = unescape(LoginLog.N11);
			}
			html = html + '<td>'+Enum_data.LogType[unescape(LoginLog.N10)].N3[suc].S2 +'</td>';
			//html = html + '<td>'+unescape(LoginLog.N10) +','+ suc+'</td>';
			if (parseInt(unescape(LoginLog.N12)) == 0)
			{html = html + '<td>-</td>';}
			else
			{
				if (parseInt(unescape(LoginLog.N9)) == 2) {
					html = html + '<td>'+s_monster_search(unescape(LoginLog.N12)) +'</td>';
				}else{
					html = html + '<td>'+s_item_search(unescape(LoginLog.N12)) +'</td>';
				}
			}
			html = html + '<td align=center>'+unescape(LoginLog.N13) +'</td>';
			if (parseInt(unescape(LoginLog.N14)) == 0) {
				html = html + '<td align=center >'+unescape(LoginLog.N14) +'</td>';
			}else{
				data_type_name = (parseInt(unescape(LoginLog.N9)) == 1) ? Enum_data.ItemType[unescape(LoginLog.N21)].N2 : (parseInt(unescape(LoginLog.N9)) == 2) ? Enum_data.CoreType[unescape(LoginLog.N21)].N2 : unescape(LoginLog.N21);
				html = html + '<td align="center" class="link" rel="'+unescape(LoginLog.N18)+'|'+s_zone_search(unescape(LoginLog.N20))+'|'+data_type_name+'">'+unescape(LoginLog.N14) +'</td>';
			}
			html = html + '<td align=right>'+unescape(LoginLog.N15) +'</td><td></td></tr> ';
		
		});		
		
		$("#log_List").empty().html(html);
		log_list_color();
		$("#spinner").empty();
		
		$("#log_List > tr > td:nth-child(3)").click(function(){
			$("#Detail_log_List1").empty();
			
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
		$("#log_List > tr > td:nth-child(14)").click(function(){
		  	$("#Detail_log_List2").empty();
			var sp_rel = "";
			if ($(this).attr("rel") != ""){
				ap_rel = $(this).attr("rel").split('|');
				$("#R_Se2").empty().html( $("div.fr > div > select[name=Server] > option:selected").val());
				$("#R_Dt2").empty().html(($(this).parent().children("td:eq(8)").html()));
				$("#R_On2").empty().html(($(this).parent().children("td:eq(11)").html()));
				$("#R_Oi2").empty().html(($(this).parent().children("td:eq(12)").html()));
				$("#R_Os2").empty().html(($(this).parent().children("td:eq(13)").html()));
				$("#R_Ct2").empty().html((ap_rel[0]));
				$("#R_Cz2").empty().html((ap_rel[1]));
				$("#R_Cty2").empty().html((ap_rel[2]));
				Item_log_detail2($(this).html(),$(this).prev().html() );
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
				
				
				if (im_c_se != unescape(LoginLog.N5) )
				{
					if (parseInt(i) < 1){
					html = html + '	<tr> ';
					}else{ 
						
					html = html + '	<tr style="border-top:1px solid #efefef"> ';
					}
					im_c_se = unescape(LoginLog.N5);
					html = html + '<td align=center>'+unescape(LoginLog.N1) +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N2) +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N3) +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N4) +'</td>';
					html = html + '<td align=center>'+unescape(LoginLog.N5) +'</td>';
					html = html + '<td align=center>'+Enum_data.DataType[unescape(LoginLog.N6)].N2 +'</td>';
					html = html + '<td align=center>'+Enum_data.LogType[unescape(LoginLog.N7)].N2 +'</td>';
					if (unescape(LoginLog.N16) == 1){
					suc = parseInt(unescape(LoginLog.N8)) + 3;
					}else{
					suc = unescape(LoginLog.N8);
					}
					html = html + '<td>'+Enum_data.LogType[unescape(LoginLog.N7)].N3[suc].S2 +'</td>';
				}else{
					html = html + '	<tr> ';
					html = html + '<td >&nbsp;</td>';
					html = html + '<td >&nbsp;</td>';
					html = html + '<td >&nbsp;</td>';
					html = html + '<td >&nbsp;</td>';
					html = html + '<td >&nbsp;</td>';
					if (unescape(LoginLog.N16) == 1){
						html = html + '<td >&nbsp;</td>';
						html = html + '<td >&nbsp;</td>';
						html = html + '<td >&nbsp;</td>';
					}else{
						html = html + '<td align=center>'+Enum_data.DataType[unescape(LoginLog.N6)].N2 +'</td>';
						html = html + '<td align=center>'+Enum_data.LogType[unescape(LoginLog.N7)].N2 +'</td>';
						html = html + '<td>'+Enum_data.LogType[unescape(LoginLog.N7)].N3[unescape(LoginLog.N8)].S2 +'</td>';
					}					
				}
				html = html + '<td align=center>'+unescape(LoginLog.N9) +'</td>';
				if (parseInt(unescape(LoginLog.N10)) == 0)
				{html = html + '<td>-</td>';}
				else
				{
					if (parseInt(unescape(LoginLog.N6)) == 2) {
						html = html + '<td>'+s_monster_search(unescape(LoginLog.N10)) +'</td>';
					}else{
						html = html + '<td>'+s_item_search(unescape(LoginLog.N10)) +'</td>';
					}
				}
				html = html + '<td align=center >'+unescape(LoginLog.N11) +'</td>';
				html = html + '<td align=center >'+unescape(LoginLog.N12) +'</td>';
				html = html + '<td align=center ></td>';//2014.06.12
				html = html + '<td align=right >'+unescape(LoginLog.N14) +'</td>';
				html = html + '<td align=right>'+unescape(LoginLog.N15) +'</td></tr> ';
			});		
			$("#Detail_log_List1").empty().html(html);
		});
		log_dialog_form($('#Log_Detail1'), 'Item & Hench Log');
	}
	function Item_log_detail2(obj_serial, obj_id){
		var html = "";
		var s_Server="";
		var s_period="";
		
		var suc = "";
		 
		s_Server	= $("div.fr > div > select[name=Server] > option:selected").val();
		
		$.getJSON(Json_url +"?CN=LD2&Server="+s_Server+"&ObjSerial="+obj_serial+"&ObjIdx="+obj_id,	function(data){
		
			$.each(data.List, function(i,LoginLog){
				
				if (parseInt(i) < 1){
				html = html + '	<tr> ';
				}else{ 
					html = html + '	<tr style="border-top:1px solid #efefef"> ';
				}
				html = html + '<td align=center>'+unescape(LoginLog.N1) +'</td>';
				html = html + '<td align=center>'+unescape(LoginLog.N2) +'</td>';
				html = html + '<td align=center>'+unescape(LoginLog.N3) +'</td>';
				html = html + '<td align=center>'+unescape(LoginLog.N4) +'</td>';
				html = html + '<td align=center>'+unescape(LoginLog.N5) +'</td>';
				html = html + '<td align=center>'+unescape(LoginLog.N6) +'</td>';
				html = html + '<td align=center>'+s_zone_search(unescape(LoginLog.N7)) +'</td>';
				html = html + '<td>'+Enum_data.LogType[unescape(LoginLog.N8)].N2 +'</td>';
				html = html + '<td align=center>'+Enum_data.LogType[unescape(LoginLog.N9)].N2 +'</td>';
				if (unescape(LoginLog.N16) == 1){
				suc = parseInt(unescape(LoginLog.N10)) + 3;
				}else{
				suc = unescape(LoginLog.N10);
				}
				html = html + '<td>'+Enum_data.LogType[unescape(LoginLog.N9)].N3[suc].S2 +'</td>';
				html = html + '<td align=center >'+Enum_data.OptionType[unescape(LoginLog.N11)].N2 +'</td>';
				html = html + '<td align=center >'+unescape(LoginLog.N12) +'</td>';
				html = html + '<td align=center >'+Enum_data.SynergyType[unescape(LoginLog.N13)].N2 +'</td>';
				html = html + '<td align=center >'+unescape(LoginLog.N14) +'</td></tr> ';

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
			<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("LOG_Mid1_Title")%></span></li><li class="on"><span><%=MsgExtract("LOG_SM2_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("LOG_SM2_Title")%></h3> 

		<div class="tbl_top">
			<div class="fl"><%=MsgExtract("Lab_Total")%> : <span id="l_total">0</span> | <%=MsgExtract("Lab_Page")%> : [<span id="n_page">1</span>/<span id="t_page">1</span>]</div>
			<div class="fr">
				<div>
					<span><%=MsgExtract("Lab_Period")%></span><br>
					<div id="Period_form" style="display:none"><input type="text" id="s_Sdate" name="s_Sdate" value="<%=DateFormat(now(), "yyyy-MM-dd")%>" class="i_text" style="width:70px">-<input type="text" id="s_Edate" name="s_Edate" value="<%=DateFormat(now(), "yyyy-MM-dd")%>" class="i_text" style="width:70px"></div>
					<select id="s_period" name="s_period">
						<option value="T" selected>Today</option><option value="W">Week</option><option value="M">Month</option><option value="C">Custom</option>
					</select>
					
				</div>
				<div>
					<span><%=MsgExtract("Lab_Server")%></span><br>
					<% Server_Select %>
				</div>
				<div>
					<span><%=MsgExtract("Lab_List_View")%></span><br>
					<select id="pagesize" name="pagesize"><option value="30"> 30 </option><option value="50"> 50 </option><option value="80"> 80 </option><option value="100" selected> 100 </option><option value="300"> 300 </option><option value="500"> 500 </option><option value="1000"> 1000 </option></select>
				</div>
			</div>
		</div>


		<table class="tbl_type" cellspacing="0" summary="Item Log List"> 
			<colgroup>
				<col width="120"><col width="170">
				<col width="80"><col width="120">	
				<col width="100"><col width="70">
				<col width="40"><col width="130">
				<col width="80"><col width="80">
				<col style="txt-overflow:ellipsis;overflow:visible;width:150px"><col width="120">
				<col width="40"><col width="130">
				<col width="50"><col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<td colspan="16">
						<div class="fl2">
							
							<span id="radio_f" style="font-size:90%">
								<input type="radio" id="radio1" name="radio" checked="checked" /><label for="radio1"><%=MsgExtract("Lab_Item_Core")%></label>
								<input type="radio" id="radio2" name="radio" /><label for="radio2"><%=MsgExtract("Lab_Super")%></label>
							</span>
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
					<th><%=MsgExtract("T_Log_Data_Type")%></th>
					<th><%=MsgExtract("T_Log_Log_Type")%></th>
					<th><%=MsgExtract("T_Log_Detail")%></th>
					<th><%=MsgExtract("T_Log_Obj_name")%></th>
					<th><%=MsgExtract("T_Log_Obj_idx")%></th>
					<th><%=MsgExtract("T_Log_Obj_ser")%></th>
					<th><%=MsgExtract("T_Log_CNT")%></th>
					<th></th>
				</tr>
			</thead>
			<tbody id=log_List>
				<tr>
					<td colspan="16" style="height: 600px; text-align:center">
						<%=MsgExtract("T_Default")%>
					</td>
					
				</tr>
			</tbody>
			<tfoot>
				<tr><td  colspan="16" style="border-top:1px solid #aaa"><div id="Pagination" class="pagination"></div></td></tr>
			</tfoot>
		</table>
				
		</div>
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
					<th><%=MsgExtract("T_Log_Data_Type")%></th>
					<th><%=MsgExtract("T_Log_Log_Type")%></th>
					<th><%=MsgExtract("T_Log_Detail")%></th>
					<th><%=MsgExtract("T_Log_CNT")%></th>
					<th><%=MsgExtract("T_Log_Obj_name")%></th>
					<th><%=MsgExtract("T_Log_Obj_idx")%></th>
					<th><%=MsgExtract("T_Log_Obj_ser")%></th>
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
		<table class="tbl_type" cellspacing="0" summary="Item Log Detail2" style="margin-top:10px;margin-bottom:20px; width:800px" align="left"> 
			<colgroup>
				<col width="100"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100">
			</colgroup>
		
			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("Lab_Server")%></th>
					<th><%=MsgExtract("T_Log_Data_Type")%></th>
					<th><%=MsgExtract("T_Log_Obj_idx")%></th>
					<th><%=MsgExtract("T_Log_Obj_name")%></th>
					<th><%=MsgExtract("T_Log_Obj_ser")%></th>
					<th><%=MsgExtract("T_Login_Zone")%></th>
					<th><%=MsgExtract("T_Log_Time")%></th>
					<th><%=MsgExtract("T_Item_Cre_Type")%></th>
				</tr>
		
			</thead>
			<tbody>
				<tr>
					<td id="R_Se2"></td>
					<td id="R_Dt2"></td>
					<td id="R_Oi2"></td>
					<td id="R_On2"></td>
					<td id="R_Os2"></td>
					<td id="R_Cz2"></td>
					<td id="R_Ct2"></td>
					<td id="R_Cty2"></td>
				</tr>
			</tbody>
		</table>
		<table class="tbl_type" cellspacing="0" summary="Item Log Detail"> 
			
			<thead class="toolbar">
				<tr>
					
					<th><%=MsgExtract("T_Login_Ch")%></th>
					<th><%=MsgExtract("T_Login_IDX")%></th>
					<th><%=MsgExtract("T_Login_Sock")%></th>
					<th><%=MsgExtract("T_Login_Serial")%></th>
					<th><%=MsgExtract("T_Log_Time")%></th>
					<th><%=MsgExtract("T_Login_IP")%></th>
					<th><%=MsgExtract("T_Login_Zone")%></th>
					<th><%=MsgExtract("T_Log_Type")%></th>
					<th><%=MsgExtract("T_Log_Log_Type")%></th>
					<th><%=MsgExtract("T_Log_Detail")%></th>
					<th><%=MsgExtract("T_Item_Option")%></th>
					<th><%=MsgExtract("T_Option_Level")%></th>
					<th><%=MsgExtract("T_Synergy")%></th>
					<th><%=MsgExtract("T_Synergy_Level")%></th>
				</tr>
		
			</thead>
			<tbody  id="Detail_log_List2">

			</tbody>
		</table>
	</div>

<div id ="ins_form"></div>
</body>
</html>