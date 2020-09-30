<!--#include virtual="/common/Function/option_explicit.asp"-->
<object runat="Server" progid="Scripting.FileSystemObject" id="fsc"></object>
<!--#include virtual="/Common/JSON_INI/Server_CONFIG.asp"-->
<% Now_Position ="GMTool"%>
<script language="javascript" runat="server" src="/common/function/json2.min.asp"></script>
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Common/Function/function.asp"-->
<%
	Dim rid_idx		: rid_idx		= Request("id_idx") 
	Dim rPlayerID	: rPlayerID		= Request("PlayerID")
%>
	<script language=javascript>
	//<![CDATA[	
	$(function($){
		$("#Character_List").load("/GMTool/Form/Form_Character_list.asp?id_idx=<%=rid_idx%>&PlayerID=<%=escape(rPlayerID)%>");
		$("#Character_Info").load("/GMTool/Form/Form_Character_Detail.asp");
	});
	
	//]]>
	</script>
	

			<table class="tbl_type" cellspacing="0" summary="Player List"> 
				<tbody>
					<tr>
						<td>
							<h3 style="margin:20px 0 5px 10px; padding:0; font-size:95%"><%=MsgExtract("F4_Title000")%></h3>  
						</td>
					</tr>
					<tr>
						<td id="Character_List">
							
						</td>
					</tr>
					<tr>
						<td>
							<h3 style="margin:25px 0 5px 10px; padding:0; font-size:95%"><span id="Character_Information"></span><%=MsgExtract("F4_Title004")%></h3>  
						</td>
					</tr>
					<tr>
						<td id="Character_Info">
							
						</td>
					</tr>
				</tbody>
			</table>
			
