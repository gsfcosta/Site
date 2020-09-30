<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rServer 	:	rServer		= Request("Server")
	Dim Guild_Code	:	Guild_Code	= Request("Guild_code")
	
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
	<div class="form_table" style="margin-top: 10px">
	<table class="tbl_type" cellspacing="0" summary="Guild List" width=100%>  
		<input type=hidden name="Guild_code" value="<%=Guild_Code%>">
		<input type=hidden name="Server" value="<%=rServer%>">
		<colgroup>
			<col width="150"><col width="400">
		<colgroup>
		<tr>
			<th scope="row" ><%=MsgExtract("F9_Title001")%> </th>
			<td><div class="item"><input type="input" id="tName" name="tName" value="<%=arrRSMix(0,0)%>" readonly></div></td>
		</tr>
		<tr>
			<th scope="row" ><%=MsgExtract("F9_Title021")%></th>
			<td><div class="item"><input type="input" id="tInfo" name="tInfo" value="<%=arrRSMix(1,0)%>" style="width:390px" class="field required" title="<%=MsgExtract("F9_Title023")%>"></div></td>
		</tr>
		<tr>
			<th scope="row" ><%=MsgExtract("F9_Title022")%></th>
			<td ><div class="item"><textarea style="width:390px" rows=4 id="tCert" name="tCert" class="field required" title="<%=MsgExtract("F9_Title024")%>"><%=arrRSMix(2,0)%></textarea></div></td>
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
<script>
	$(function($){
		$('#Guild_form').submit(function(){
			$(this).ajaxSubmit({ beforeSubmit: validationForm, success: Check_val }); 
			return false;
		});
		function Check_val(responseText, statusText, xhr, $form)  {     
			if ($.trim(responseText) == '0000'){ 
				alert('<%=MsgExtract("F1_Title019")%>');
				$('#ins_form').dialog('close');
				$('#ins_form').empty();
				
			}
	} 
	});
</script>
<%
	End if
%>