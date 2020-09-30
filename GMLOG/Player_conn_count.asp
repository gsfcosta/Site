<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
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
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("LOG_SM4_Title")%></span></li><li class="on"><span><%=MsgExtract("LOG_SM5_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 25px 0; padding:0"><%=MsgExtract("LOG_SM5_Title")%></h3> 

		
		<table class="tbl_type" border="1" cellspacing="0"> 
				<colgroup>
					<col width="120"><col width="80">
					<col width="60"><col width="40"><col width="50">
					<col width="60"><col width="40"><col width="50">
					<col width="60"><col width="40"><col width="50">
					<col width="60"><col width="40"><col width="40"><col width="50">
					<col width="100"><col width="*">
				</colgroup>
				<thead class="toolbar">
					<tr>
						<td colspan="17">
							<div class="fl2"></div>
							<div class="fr2">
								<input type="text" name="P_day" id="P_day" value="<%=DateFormat(now(), "yyyy-MM-dd")%>" class="i_text" style="width:110px">
								<span class="btn_pack medium icon"><span class="seach"></span><button type="button" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
							</div>	
						</td>
					</tr>
				</thead>
				<thead class="s_title">
					<tr>
						<th>Date</th>		<th>LGS</th>
						<th>GMS</th>	<th>ZS1</th> <th>ZS2</th>	<th>Total</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="P_List"><tr><td colspan="7" align="center" valign="middle" height="400"><img src="/images/wait_fbisk.gif"></td></tr></tbody>
			</table>
				
		</div>
	</div>
	<!-- footer -->
	<div id="footer">
	<!--#include virtual="/common/Include/Footer.asp"-->
	</div>
	<div id ="ins_form"></div>
	<!--//footer -->
	<script language=javascript>
	//<![CDATA[	
		var Json_url ="";
		$(function($){
			menu_control(1, 0);
			Get_conn('');
			
			$("#i_search_btn").click(function(){
				var str;
				str = $.trim($("#P_day").val());
				Get_conn(str);
			});
			
		});
		
		function Get_conn(str){
			$.getJSON("/Common/class/GMLog/Log_Player_conn.class.asp?P_day=" + str,	function(data){
				gen_table(data);
			}).error(function(){
				alert("error");
			});
		
		}
		
		function gen_table(data){
			var html = "";
			
			var sw = "c";
			
			$.each(data.IL, function(i,l_m){
				
				if ((l_m.I20) == 1){
				html = html + '	<tr class="od1"> ';
				}else{
				html = html + '	<tr> ';
				}
				html = html + '		<td align="center" height="17" style="border-right:1px solid #acacac">'+unescape(l_m.I1)+'</td>';
				html = html + '		<td align="center" style="border-right:1px solid #acacac">'+formatNumber(l_m.I2)+'</td>';
				html = html + '		<td align="center">'+formatNumber(l_m.I3)+'</td>';
				html = html + '		<td align="center">'+formatNumber(l_m.I4)+'</td>';
				html = html + '		<td align="center" style="border-right:1px solid #acacac">'+formatNumber(l_m.I5)+'</td>';
				html = html + '		<td align="center">'+formatNumber(l_m.I6)+'</td>';

				html = html + '		<td></td>';
				html = html + ' </tr>';
				
			});	
			$("#P_List").html(html);
			$("#P_List > tr").eq(imsi_row).addClass("od3");
		}
	//]]>
	</script>

</body>
</html>