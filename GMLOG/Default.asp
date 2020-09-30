<!--#include virtual="/common/Function/option_explicit.asp"-->
<%
'/**************************DEFINE CONSTANT HERE***************************
'*  /GMLog/index.asp
'*  Description: GmLog Login log 
'*  Date: 2011.10.10
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
	
		menu_control(0, 0);
		Json_url = "/common/class/GMLOG/LOG_Login.Class.asp";
	});
	
	function gen_table(data){
		
		var html="";
		var s_Server	= $("div.fr > div > select[name=Server] > option:selected").val();
		$("#l_total").html(data.CNT);
		$("#t_page").html(data.PG);
		$.each(data.List, function(i,LoginLog){
		
			html = html + '	<tr> ';
			html = html + '<td align=center>'+unescape(LoginLog.N1) +'</td>';
			html = html + '<td align=center>'+s_zone_search(unescape(LoginLog.N2)) +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N3) +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N4) +'</td>';
			html = html + '<td align=center><a href="/GMtool/Character_Info2.asp?id_idx='+unescape(LoginLog.N6)+'&Server='+s_Server+'&Name='+LoginLog.N5+'&Socket='+LoginLog.N7+'" class="link" target="blank" >'+unescape(LoginLog.N5) +'</a></td>';
			html = html + '<td align=center class="f_gre" style="cursor:hand">'+unescape(LoginLog.N6) +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N7) +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N8) +'</td>';
			html = html + '<td align=center>'+unescape(LoginLog.N9) +'</td><td></td></tr> ';
		
		});		
		$("#log_List").empty().html(html);
		log_list_color();
		$("#spinner").empty();
		
		$("#log_List > tr > td:nth-child(6)").click(function(){
			Player_view($(this).text());
		});
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
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("LOG_Mid1_Title")%></span></li><li class="on"><span><%=MsgExtract("LOG_SM1_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("LOG_SM1_Title")%></h3> 

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


		<table class="tbl_type" cellspacing="0" summary="Log List"> 
			<colgroup>
			 	<col width="120"><col width="180">
				<col width="120"><col width="120">	
				<col width="100"><col width="70">
				<col width="40"><col width="120">
				<col width="120"><col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<td colspan="10">
						<div class="fl2">
							<div id="spinner" style="padding-top:5px"></div>
						</div>
						<div class="fr2 item">
							<select id="s_gbn" name="s_gbn">
								<option value="IDX" selected><%=MsgExtract("T_Login_IDX")%></option><option value="Hname"><%=MsgExtract("T_Login_Ch")%></option><option value="IP"><%=MsgExtract("T_Login_IP")%></option>
							</select>
							<input type="text" id="s_item" name="s_item" value="" class="i_text" >
							<span class="btn_pack medium icon"><span class="seach"></span><button type="submit" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
							<span class="btn_pack medium icon"><span class="calendar"></span><button id="i_list" disabled="disabled">List</button></span>
							<!--span class="btn_pack medium icon"><span class="calendar"></span><button id="ClipBoard1" class="ClipBoard" >Copy Result</button></span-->
							
						</div>	
					</td>
				</tr>
			</thead>

			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("T_Login_IP")%></th>
					<th><%=MsgExtract("T_Login_Zone")%></th>
					<th><%=MsgExtract("T_Login_IDT")%></th>
					<th><%=MsgExtract("T_Login_ODT")%></th>
					<th><%=MsgExtract("T_Login_Ch")%></th>
					<th><%=MsgExtract("T_Login_IDX")%></th>
					<th><%=MsgExtract("T_Login_Sock")%></th>
					<th><%=MsgExtract("T_Login_Serial")%></th>
					<th><%=MsgExtract("T_Login_C_Time")%></th>
					<th></th>
				</tr>
			</thead>
			<tbody id=log_List>
				<tr>
					<td colspan="10" style="height: 600px; text-align:center">
						<%=MsgExtract("T_Default")%>
					</td>
				
				</tr>
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
</body>
</html>