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
				<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("TOOL_Mid4_Title")%></span></li><li class="on"><span>Admin List</span></li></ol>
		</div>
		<h3 style="margin:10px 0 0 0; padding:0">Admin List</h3> 

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
				<col width="50"><col width="120">
				<col width="120"><col width="120">	
				<col width="150"><col width="200">
				<col width="80"><col width="*">
			</colgroup>

			<thead class="toolbar">
				<tr>
					<td colspan="10">
						<div class="fl2">
							<span class="btn_pack medium icon"><span class="add"></span><button type="button" id="Player_add"><%=MsgExtract("Btn_New")%></button></span>
							<span id="spinner" style="padding-top:5px"></span>
						</div>
						<div class="fr2 item" style="display:none">
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
					<th>Num</th>
					<th>Admin ID</th>
					<th>Password</th>
					<th>Name</th>
					<th>Login IP</th>
					<th>Login Date</th>
					<th></th>
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

	var Json_url = "/common/class/GMTool/GMT_Admin.class.asp";
	$(function($){
		
		menu_control(3, 0);
		
		$("#Player_add").click(function(){
			
			form_modal_load('/GMtool/Form/Form_NEW_Admin.asp', 'New Admin', 520, 260);
			
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
			html = html + '<td align=center>'+unescape(Player.N1) +'</td>';
			html = html + '<td align=center class="link" rel="'+unescape(Player.N1)+'">'+unescape(Player.N2) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N3) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N4) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N5) +'</td>';
			html = html + '<td align=center>'+unescape(Player.N6) +'</td>';
			html = html + '<td align=center><span class="btn_pack medium icon"><span class="delete"></span>';
				html = html + '<button TYPE=button id="btn_del" rel="'+ unescape(Player.N1) +'">&nbsp;<%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr> ';
		
		});		
		$("#log_List").empty().html(html);
		log_list_color();
		$("#spinner").empty();
		
		$("button[id^=btn_del]").click(function(){
				var id_idx = $(this).attr('rel');
				var del_url = "/Common/Class/GMTool/GMT_Admin.class.asp?key=A_DEL&id_idx="+id_idx ;
				if (confirm('<%=MsgExtract("F6_Title010")%>')){
					$.ajax({  
						url:del_url,  
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