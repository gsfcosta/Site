<!--#include virtual="/common/Function/option_explicit.asp"-->
<object runat="Server" progid="Scripting.FileSystemObject" id="fsc"></object>
<!--#include virtual="/Common/JSON_INI/Server_CONFIG.asp"-->
<% Now_Position ="GMTool"%>
<script language="javascript" runat="server" src="/common/function/json2.min.asp"></script>
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Common/Function/function.asp"-->

<%
	Dim rServer 	:	rServer		= Request("Server")
	Dim Guild_Code	:	Guild_Code	= Request("Guild_code")
	Dim rid_idx		:	rid_idx		= Request("id_idx")
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	
	Dim SQL
	Dim MixDSN2		:	MixDSN2		= rServer
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt, i
	
	
	SQL = "Select a.Name, a.Info, a.Cert, cast(a.EstablishDate as char(16)), b.m_cnt, b.new_cnt, b.out_cnt, a.gold  " 
	SQL = SQL & " From u_guild as a, (select GuildIdx, sum(case when Grade in (3,10,11,12,13) Then 1 else 0 end) as m_cnt,"
	SQL = SQL & " sum(case when Grade = 1 Then 1 else 0 end ) as new_cnt,"
	SQL = SQL & " 	sum(case when Grade = 4 Then 1 else 0 end ) as out_cnt "
	SQL = SQL & " from u_guildmember group by GuildIdx) as b Where "
	SQL = SQL & " a.GuildIdx = b.GuildIdx and a.GuildIdx =  "& Guild_code
	
	DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
	DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
	If arrRSMixCnt > -1 Then
%>
		
		
		
		<form id="Guild_form" method="post" action="/Common/class/GMTool/GMT_Guild.class.asp?key=GEdit" >
			<div class="form_table" style="margin-top: 10px; width:950px; border:1px solid #efefef; margin-bottom:10px">
			<table class="tbl_type" cellspacing="0" summary="Guild List" width=100%>  
				<input type=hidden name="Guild_code" value="<%=Guild_Code%>">
				<input type=hidden name="Server" value="<%=rServer%>">
				<colgroup>
					<col width="150"><col width="800">
				<colgroup>
				<tr>
					<th scope="row" ><%=MsgExtract("F9_Title001")%> </th>
					<td><div class="item"><input type="input" id="tName" name="tName" value="<%=arrRSMix(0,0)%>" readonly></div></td>
				</tr>
				<tr>
					<th scope="row" ><%=MsgExtract("F9_Title021")%></th>
					<td><div class="item"><input type="input" id="tInfo" name="tInfo" value="<%=arrRSMix(1,0)%>" style="width:750px" class="field required" title="<%=MsgExtract("F9_Title023")%>"></div></td>
				</tr>
				<tr>
					<th scope="row" ><%=MsgExtract("F9_Title022")%></th>
					<td ><div class="item"><textarea style="width:750px" rows=4 id="tCert" name="tCert" class="field required" title="<%=MsgExtract("F9_Title024")%>"><%=arrRSMix(2,0)%></textarea></div></td>
				</tr>
				<tr>
					<th scope="row" ><%=MsgExtract("F9_Title025")%></th>
					<td ><div class="item"><input type="input" id="tgold" name="tgold" value="<%=arrRSMix(7,0)%>"></div></td>
				</tr>
				<tr>
					<th scope="row" ><%=MsgExtract("F9_Title006")%></th>
					<td ><%=arrRSMix(3,0)%> </td>
				</tr>
				<tr>
					<td colspan=2 style="padding:0">
						<table cellspacing="0" cellpadding="0" style="margin:0">
							<colgroup>
								<col width="120"><col width="50"><col width="120"><col width="50"><col width="120"><col width="50">
							<colgroup>
							<tr>
								<th scope="row" ><%=MsgExtract("F9_Title002")%></th>
								<td><%=arrRSMix(4,0)%> </td>
								<th scope="row"><%=MsgExtract("F9_Title019")%></th>
								<td><%=arrRSMix(5,0)%> </td>
								<th scope="row" ><%=MsgExtract("F9_Title020")%></th>
								<td><%=arrRSMix(6,0)%> </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<div style="padding-top:20px"><center><span class="btn_pack medium icon"><span class="saveas"></span><button type="submit">&nbsp;<%=MsgExtract("Btn_Save")%></button></span></center></div>
			</div>
		</form>
<%END IF%>
	<div class="ui-widget-header char_title2"> <font class='f_blu'><%=MsgExtract("Btn_Guild")%></font>&nbsp;&nbsp;<span id="Guild_name" style="cursor:pointer"></span></div>
		<table class="tbl_type" cellspacing="0" summary="Guild List" width=100%>  
			<colgroup>
				<col width="30"><col width="140"><col width="50">
				<col width="200"><col width="150">	
				<col width="100"><col width="80">
				<col width="150"><col width="80"><col width="*">
			</colgroup>
			<thead class="toolbar">
				<tr>
					<th>Num</th>
					<th><%=MsgExtract("T_Character")%></th>
					<th><%=MsgExtract("T_Level")%></th>
					<th><%=MsgExtract("F9_Title014")%></th>
					<th><%=MsgExtract("T_Player_ID")%></th>
					<th><%=MsgExtract("T_IDX")%></th>
					<th><%=MsgExtract("T_Block_St")%></th>
					<th><%=MsgExtract("F9_Title015")%></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
		
			<tbody id="Guild_List1">
				<tr><td align=center colspan=10 style="height:600px"><img src="/images/wait_fbisk.gif"></td></tr>
			</tbody>
		</table>
<script>
	var common_url = '/Common/Class/GMTool/GMT_Guild.class.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&Guild_Code=<%=Guild_Code%>'
	$(function($){
			
		gen_Guild_list();
		
		$('#Guild_form').submit(function(){
			$(this).ajaxSubmit({ beforeSubmit: validationForm, success: Check_val }); 
			return false;
		});
		function Check_val(responseText, statusText, xhr, $form)  {     
			if ($.trim(responseText) == '0000'){ 
				alert('<%=MsgExtract("F1_Title019")%>');
			}
		} 
			
	});
	function gen_Guild_list(){
		$.getJSON(common_url + '&key=GUILD',	function(data){
			var html="";
			var adb = "";
			var me = "";
			var class_b = "";
			$("#Guild_name").html("["+unescape(data.Gname)+"]");
			$("#Guild_name").attr("rel", data.Guild_Code)
			if (data.List.length != 0 ){
				$.each(data.List, function(i,C_Guild){
					html = html + '	<tr> ';
					html = html + '	<td align=center>'+ (parseInt(i) + 1) +'</td> ';
					if ('<%=rid_idx%>' == unescape(C_Guild.N7) && '<%=rSocket%>' == C_Guild.N10 ){
						me = "<img src='/images/arrow.gif'> &nbsp;"
					}else{
						me = "";
					}
					html = html + '<td align=center>'+me+'<a href="/GMtool/Character_Info2.asp?id_idx='+unescape(C_Guild.N7)+'&PlayerID='+unescape(C_Guild.N5)+'&Server=<%=rServer%>&Name='+C_Guild.N1+'&Socket='+C_Guild.N10+'" class="link" target="_blank">'+ unescape(C_Guild.N1) +'</a></td>';
					html = html + '<td align=center>'+ unescape(C_Guild.N3) +'</td>';
					if (unescape(C_Guild.N9) == "0"){
						adb = "<%=MsgExtract("F9_Title016")%>";
					}else if(unescape(C_Guild.N9) == "1"){
						adb = "<%=MsgExtract("F9_Title017")%>";
					}else{
						adb = "";
					}
					html = html + '<td align=center>'+ Guild_Grade(unescape(C_Guild.N2)) +adb+'</td>';
					html = html + '<td align=center rel="'+unescape(C_Guild.N7)+'" class="f_gre link ">'+ unescape(C_Guild.N5) +'</td>';
					html = html + '<td align=center>'+ unescape(C_Guild.N7) +'</td>';
					class_b = (unescape(C_Guild.N6) == 'ALLOW') ? 'class=f_blu style="cursor:pointer"' : 'class=f_red' ;
					html = html + '<td align=center  '+ class_b +' rel="'+unescape(C_Guild.N5)+'">'+ Block_Type(unescape(C_Guild.N6)) +'</td>';
					html = html + '<td align=center>'+ unescape(C_Guild.N4) +'</td>';
					if (parseInt(unescape(C_Guild.N2)) == 12){
						html = html + '<td></td><td></td></tr>';
					}else{
						html = html + '<td><span class="btn_pack medium icon"><span class="delete"></span>';
						html = html + '<button TYPE=button id="btn_del" rel="'+unescape(C_Guild.N7)+'" data="'+C_Guild.N10+'">&nbsp;<%=MsgExtract("Btn_Delete2")%></button></span></td><td></td></tr>';
					}
					$('#Guild_List1').html(html);
					list_color('Guild_List1');
					$("#Guild_List1 > tr > td:nth-child(5)").click(function(){
						Player_view($(this).attr('rel'));
					});	
					$("#Guild_List1 > tr > td[class='f_blu']:nth-child(7) ").click(function(){
						Block_Player_form($(this).attr('rel'));
					});
					$("#Guild_name").click(function(){
						form_modal_load('/GMtool/Form/Form_Guild_Info.asp?Guild_code='+escape($(this).attr('rel'))+'&Server=<%=rServer%>', 'Guild Information', 570, 335);
					});
					$("button[id^=btn_del]").click(function(){
						var id_idx = $(this).attr('rel');
						var Socket = $(this).attr('data');
						var del_url = "/Common/Class/GMTool/GMT_Guild.class.asp?key=GUILD_DEL&Guild_Code="+data.Guild_Code+"&Server=<%=rServer%>&id_idx="+id_idx + "&Socket="+Socket ;
						if (confirm('<%=MsgExtract("F9_Title031")%>')){
							var id_idx = $(this).attr("rel");
							var rSocket =  $(this).attr("data");
							
							$.ajax({  
								url:del_url,  
								cache: false,  
								success: function(data){
									if (data == '0000'){
										alert('<%=MsgExtract("F2_Title029")%>');
										gen_Guild_list();
									}  
								}
							});
							
						}
					});
				});
			}else{
				html = html + '<tr><td colspan=9>&nbsp;</td><td></td></tr>';
				html = html + '<tr><td colspan=9 align=center valign=middle style="height:568px"><%=MsgExtract("F9_Title018")%></td><td></td></tr>';
				html = html + '<tr><td colspan=9>&nbsp;</td><td></td></tr>';
				$("#Guild_List1").empty().html(html);
			
			}

		});		
		
	}
</script>