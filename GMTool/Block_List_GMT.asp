<!--#include virtual="/common/Function/option_explicit.asp"-->
<%
	Dim rPID		:	rPID = Unescape(Request("Pid"))
%>
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
	<script language=javascript>
	//<![CDATA[	
	var Json_url = "/common/class/GMTool/GMT_Block_Player.class.asp";
	$(function($){
		menu_control(0, 1);
		<%If rPID <> "" Then %>
			Block_Player_form('<%=rPID%>');
			//form_modal_load('/GMtool/Form/Form_Block_Player.asp?rPid='+escape('<%=rPID%>'), 'Block Player Form', 620, 600);
		<%End if%>
		
		$("#Player_add").click(function(){
			
			form_modal_load('/GMtool/Form/Form_Block_Player.asp', 'Block Player Form', 620, 620);
			
		});
	});
	
	function gen_table(data){
		
		var html="";
		var class_b = "";
		
		$("#l_total").html(data.CNT);
		$("#t_page").html(data.PG);
		$.each(data.List, function(i,Player){
		
			html = html + '	<tr> ';
			html = html + '<td align=center class="link" rel="'+unescape(Player.N10)+'">'+unescape(Player.N1) +'</td>';
			class_b = (unescape(Player.N3) == 'ALLOW') ? 'class=f_blu' : 'class=f_red' ;
			html = html + '<td align=center '+class_b+'>'+Access_Type(unescape(Player.N3))+'['+Block_Type(unescape(Player.N2))+']</td>';
			html = html + '<td align=left>'+ unescape(Player.N4) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N5) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N6) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N7) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N8) +'</td><td></td></tr> ';
		
		});		
		$("#log_List").empty().html(html);
		log_list_color();
		$("#spinner").empty();
		$("#log_List > tr > td:nth-child(1)").click(function(){
			
			form_modal_load('/GMtool/Form/Form_Block_Player.asp?Pid='+$(this).attr("rel"), 'Block Player Infomation', 620, 650);
		});
	}
	
	
	//]]>
	</script>
	
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
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("TOOL_Mid1_Title")%></span></li><li class="on"><span><%=MsgExtract("TOOL_SM2_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("TOOL_SM2_Title")%></h3> 

		<div class="tbl_top">
			<div class="fl"><%=MsgExtract("Lab_Total")%> : <span id="l_total">0</span> | <%=MsgExtract("Lab_Page")%> : [<span id="n_page">1</span>/<span id="t_page">1</span>]</div>
			<div class="fr">
				
				<div>
					<span><%=MsgExtract("Lab_List_View")%></span><br>
					<select id="pagesize" name="pagesize"><option value="20"> 20 </option><option value="30"> 30 </option><option value="40"> 40 </option><option value="50"> 50 </option></select>
				</div>
			</div>
		</div>


		<table class="tbl_type" cellspacing="0" summary="Log List"> 
			<colgroup>
				<col width="150"><col width="170">
				<col width="250">	
				<col width="110"><col width="110">
				<col width="140"><col width="140">
				<col width="*">
			</colgroup>

			<thead class="toolbar">
				<tr>
					<td colspan="8">
						<div class="fl2">
							<span class="btn_pack medium icon"><span class="add" ></span><button id="Player_add" type="button"><%=MsgExtract("Btn_New")%></button></span>
							<span id="spinner" style="padding-top:5px"></span>
						</div>
						<div class="fr2 item">
							<select id="s_gbn" name="s_gbn">
								<option value="I" selected><%=MsgExtract("T_Player_ID")%></option><option value="N"><%=MsgExtract("T_Block_Ch")%></option><option value="C"><%=MsgExtract("T_Content")%></option>
							</select>
							<input type="text" id="s_item" name="s_item" value="" class="i_text" >
							<span class="btn_pack medium icon"><span class="seach"></span><button type="button" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
							<span class="btn_pack medium icon"><span class="calendar"></span><button id="i_list" disabled="disabled">List</button></span>
						</div>	
					</td>
				</tr>
			</thead>

			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("T_Player_ID")%></th>
					<th><%=MsgExtract("T_Block_St")%></th>
					<th><%=MsgExtract("T_Block_Ca")%></th>
					<th><%=MsgExtract("T_Block_Se")%></th>
					<th><%=MsgExtract("T_Block_Ch")%></th>
					<th><%=MsgExtract("T_Block_Regdate")%></th>
					<th><%=MsgExtract("T_Block_Candate")%></th>
					<th></th>
				</tr>
			</thead>
			<tbody id="log_List">
			
			</tbody>
			<tfoot>
				<tr><td colspan="8" style="border-top:1px solid #aaa"><div id="Pagination" class="pagination"></div></td></tr>
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