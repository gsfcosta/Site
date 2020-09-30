<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
	
</head>
<%
	Dim rid_idx		: rid_idx		= Request("id_idx") 
	Dim rPlayerID	: rPlayerID		= Request("PlayerID")
	Dim rServer		: rServer		= Request("Server")
	Dim rName		: rName			= Request("Name")
	Dim rSocket		: rSocket		= Request("Socket")
%>
<style> 
	td{height:20px; font-size:12px;}
	
</style>
<body>
<div id="wrap">
	<div id="header">
		<!--#include virtual="/common/Include/Header.asp"-->
	</div>
	<div id="container" style="padding-bottom:10px;">
		<div class="snb">
			<!--#include virtual="/common/Include/GMTool_Left.asp"-->
		</div>
		<div id="content" >
		
		<div class="progress">
				<strong class="tit"><%=MsgExtract("Lab_Home")%></strong> 
				<ol>
					<li class="on"><span><%=Now_Position%></span></li>
					<li class="on"><span><%=MsgExtract("TOOL_Mid1_Title")%></span></li>
					<li class="on"><span><%=MsgExtract("TOOL_SM1_Title")%></span></li>
					<li class="on"><span><%=MsgExtract("TOOL_SM1_1_Title")%></span></li>
				</ol>
		</div>
		<h3 style="margin:10px 0 20px 0; padding:0"><%=MsgExtract("TOOL_SM1_1_Title")%></h3> 
		<form method="post" action="/Gmtool/">
		<table class="tbl_type" cellspacing="0" summary="Player List"> 
			<colgroup>
				<col width="*">
			</colgroup>

			<thead class="toolbar">
				<tr>
					<td style="border-bottom:0px">
						<div class="fl2">
							<select id="s_gbn" name="s_gbn">
								<option value="I" selected><%=MsgExtract("T_Player_ID")%></option><option value="X"><%=MsgExtract("T_IDX")%></option><option value="C"><%=MsgExtract("T_Character")%></option><option value="N"><%=MsgExtract("T_Player_Name")%></option><option value="J"><%=MsgExtract("T_JUMIN")%></option>
							</select>
							<% Server_Select %>
							<input type="text" id="s_item" name="s_item" value="" class="i_text" >
							<span class="btn_pack medium icon"><span class="seach"></span><button type="submit" id="i_search_btn"><%=MsgExtract("Lab_Search")%></button></span>
						</div>
						<div class="fr2 item">
							
						</div>	
					</td>
				</tr>
			</thead>
		</table>
		</form>
		<div id="CHAR_INFO" style="height:100%;display:inline-block; width:100%">
			<div id="Player_char_list" style="height:100%; margin:0 ; float:left;" >
				<div id="Character_List"></div>
			</div>
			<div id="Player_char_Info_a" style="height:100%; margin-left:0px;  margin-left:380px; margin-top:0px;">
				<div id="Player_char_Info">
				
				</div>
			</div>
		</div>

		
	</div>		
	<!-- footer -->
	<div id="footer">
	<!--#include virtual="/common/Include/Footer.asp"-->
	</div>
	<!--//footer -->
	<div id="item_hidden_form"></div>
	<div id ="ins_form"></div>
</div>
<script language=javascript>
	//<![CDATA[	
	var Json_url ="";
	$(function($){
		menu_control(0, 0);
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
		$("#Character_List").load("/GMTool/Form/Form_Character_list2.asp?id_idx=<%=rid_idx%>&PlayerID=<%=escape(rPlayerID)%>&Server=<%=escape(rServer)%>&Name=<%=escape(rName)%>&Socket=<%=escape(rSocket)%>");
		$("#Player_char_Info").load("/GMTool/Form/Form_Character_Detail2.asp?id_idx=<%=rid_idx%>&Server=<%=rServer%>&C_name=<%=escape(rName)%>&Socket=<%=rSocket%>");
	});
	
	//]]>
	</script>
</body>
</html>