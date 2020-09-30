<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
<%

	Dim s_gbn		: s_gbn = Request("s_gbn")
	Dim s_item		: s_item = Request("s_item")
	Dim s_Server	: s_Server = Request("Server")
	
%>
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
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("TOOL_Mid1_Title")%></span></li><li class="on"><span><%=MsgExtract("TOOL_SM1_Title")%></span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0"><%=MsgExtract("TOOL_SM1_Title")%></h3> 

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
				<col width="150"><col width="120">
				<col width="120"><col width="120">	
				<col width="200"><col width="130">
				<col width="150"><col width="80">
				<col width="40"><col width="*">
			</colgroup>

			<thead class="toolbar">
				<tr>
					<td colspan="10">
						<div class="fl2">
							<span class="btn_pack medium icon"><span class="add"></span><button type="button" id="Player_add"><%=MsgExtract("Btn_New")%></button></span>
							<span id="spinner" style="padding-top:5px"></span>
						</div>
						<div class="fr2 item">
							<select id="s_gbn" name="s_gbn">
								<option value="I" selected><%=MsgExtract("T_Player_ID")%></option><option value="X"><%=MsgExtract("T_IDX")%></option><option value="C"><%=MsgExtract("T_Character")%></option><option value="N"><%=MsgExtract("T_Player_Name")%></option><option value="J"><%=MsgExtract("T_JUMIN")%></option>
							</select>
							<% Server_Select %>
							<input type="text" id="s_item" name="s_item" value="" class="i_text" >
							<span class="btn_pack medium icon"><span class="seach"></span><button type="submit" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
							<span class="btn_pack medium icon"><span class="calendar"></span><button type="button" id="i_list" disabled="disabled">List</button></span>
						</div>	
					</td>
				</tr>
			</thead>

			<thead class="toolbar">
				<tr>
					<th><%=MsgExtract("T_Player_ID")%></th>
					<th><%=MsgExtract("T_Player_Name")%></th>
					<th><%=MsgExtract("T_JUMIN")%></th>
					<th><%=MsgExtract("T_IDX")%></th>
					<th><%=MsgExtract("T_Email")%></th>
					<th><%=MsgExtract("T_LastLogin")%></th>
					<th><%=MsgExtract("T_Reg_Date")%></th>
					<th><%=MsgExtract("T_Block")%></th>
					<th><%=MsgExtract("F1_Title021")%></th>
					<th></th>
				</tr>
			</thead>
			<tbody id="log_List">
			
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
		<%if s_item <> "" Then%>
		$("#Server").val("<%=s_Server%>");
		$("#s_gbn").val("<%=s_gbn%>");
		$("#s_item").val("<%=s_item%>");
		<%End if%>
	var Json_url = "/common/class/GMTool/GMT_Player.class.asp";
	$(function($){
		
		menu_control(0, 0);
		
		$("#Player_add").click(function(){
			
			form_modal_load('/GMtool/Form/Form_NEW_Player.asp', 'New Player', 520, 350);
			
		});
		if ($("#s_gbn").val() !='C'){
			$("select[name=Server]").hide();
		}
		
		$("#s_gbn").change(function(){
		
			if ($(this).val() == 'C'){
				$("select[name=Server]").show();
			}else{
				$("select[name=Server]").hide();
			}
			$("#s_item").focus();
		});
		
	});
	
	function gen_table(data){
		
		var html="";
		var class_b = "";
		$("#l_total").html(data.CNT);
		$("#t_page").html(data.PG);
		$.each(data.List, function(i,Player){
		
			html = html + '	<tr> ';
			html = html + '<td align=center class="link" rel="'+unescape(Player.N1)+'">'+unescape(Player.N2) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N3) +'</td>';
			html = html + '<td align=center class="f_gre" style="cursor:pointer">'+unescape(Player.N4) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N1) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N5) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N6) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N7) +'</td>';
			class_b = (unescape(Player.N8) == 'ALLOW') ? 'class=f_blu style="cursor:pointer"' : 'class=f_red' ;
			html = html + '<td align=center '+ class_b +' rel="'+unescape(Player.N2)+'">'+Block_Type(unescape(Player.N8)) +'</td>';
//			html = html + '<td align=center><span class="btn_pack small">';
//			html = html + '<button type="button" class="chara_btn" rel="'+unescape(Player.N1)+'" summary="'+unescape(Player.N2)+'"><%=MsgExtract("Btn_Character")%></button></span></td>';
			html = html + '<td align=center><span class="btn_pack small">';
			html = html + '<button type="button" class="chara_btn2" rel="'+unescape(Player.N1)+'" summary="'+unescape(Player.N2)+'" data="'+data.HO+'"><%=MsgExtract("Btn_Character")%></button></span></td><td></td></tr> ';
		
		});		
		$("#log_List").empty().html(html);
		log_list_color();
		$("#spinner").empty();
		$("#log_List > tr > td:nth-child(1)").click(function(){
			Player_view($(this).attr('rel'));
		});
		$("#log_List > tr > td:nth-child(3)").click(function(){
			$('#s_item').val($(this).text());
			$("#s_gbn > option[value='J']").attr("selected", true);
			argment_now(0);
		});
		$("#log_List > tr > td[class='f_blu']:nth-child(8) ").click(function(){
			Block_Player_form($(this).attr('rel'));
		});
		$("#log_List > tr > td[class='f_red']:nth-child(8) ").click(function(){
			
		});
		
		$(".chara_btn").click(function(){
			form_modal_load('/GMtool/Character_Info.asp?id_idx='+escape($(this).attr('rel'))+'&PlayerID='+escape($(this).attr('summary')), 'Character Information', 1200, 835);
		});
		
		$(".chara_btn2").click(function(){
			if ($('#s_gbn').val() == 'C'){
				var server_select = $("select[name=Server] > option:selected").val();
				location.href ='/GMtool/Character_Info2.asp?id_idx='+escape($(this).attr('rel'))+'&PlayerID='+escape($(this).attr('summary')) +'&Server='+server_select +'&Name='+escape($('#s_item').val()) +'&Socket='+escape($(this).attr('data')) ;
			}else{
				location.href ='/GMtool/Character_Info2.asp?id_idx='+escape($(this).attr('rel'))+'&PlayerID='+escape($(this).attr('summary'));
			}
		});
	}
	
	
	//]]>
	</script>
</body>
</html>