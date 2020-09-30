<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim rC_name		:	rC_name			= trim(unescape(Request("C_name")))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim cn
	
	Dim SQL
	Dim MixDSN2		:	MixDSN2		= rServer
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	if rC_name <> "" Then
		SQL = "Select name, hero_type, now_zone_idx, now_zone_x,  now_zone_y, class, revive_zone_idx, baselevel , exp, abil_freepoint, avatar_head,avatar_body, avatar_foot, " 
		SQL = SQL & " gold, speed_move, speed_attack, speed_skill, skill_point,  str, dex, aim, luck, ap, dp," 
		SQL = SQL & " hc, hd, hp, mp, maxhp, maxmp, res_fire, res_water, res_earth, res_wind, res_devil,  cast(regdate as char(19))"
		SQL = SQL & " From u_hero where id_idx = " & rid_idx &" and name = '"& rC_name &"' and serial = " &rC_serial
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
	
%>
<style>
.ui-spinner {position: relative}
.ui-spinner-buttons {position: absolute}
.ui-spinner-button {overflow: hidden}
#Character_Tab .ui-tabs-panel{ height: 456px; overflow: hidden; padding:0px}
</style>
<script type="text/javascript" src="/Common/JS/CommonJS/ui.spinner.js"></script>


<script>
	$(function($){
		$('#Character_Tab').tabs();
	//$('#charlevel').spinner({ min: 1, max: 200 });
	//$('#charExp').spinner({ min: 0, max: 14 });
		var level_i = 1;
		var level_opt = '';
		
	// 캐릭터 레벨 초기화.
		for( level_i; level_i < 201; level_i++){
			level_opt = level_opt + "<option value='"+ level_i +"'>"+level_i+"</option>";
		}
		$("#charlevel").empty().append(level_opt);
		$("#charlevel option[value=<%=arrRSMix(7,0)%>]").attr('selected', 'selected');
		
		$("#charType").text(Char_Type2('<%=arrRSMix(1,0)%>'));
		$("#charExp").val(<%=arrRSMix(8,0)%>);
		$("#EXP_Lavel1").text(Character_level($("#charlevel").val() - 1 ) + 1);
		$("#EXP_Lavel2").text(Character_level($("#charlevel").val())); 
		$("#zone_point").text(s_zone_search('<%=arrRSMix(2,0)%>') + '(X : <%=arrRSMix(3,0)%>, Y : <%=arrRSMix(4,0)%>)')
		$("#charemp").val(); 
		$("#charadb").val('<%=arrRSMix(5,0)%>');
		$("#charhead").val('<%=arrRSMix(10,0)%>');
		$("#charbody").val('<%=arrRSMix(11,0)%>');
		$("#charfoot").val('<%=arrRSMix(12,0)%>');
		$("#charGP").val('<%=arrRSMix(13,0)%>');
		$("#charMoveS").val('<%=arrRSMix(14,0)%>');
		$("#charAttS").val('<%=arrRSMix(15,0)%>');
		$("#charSkillS").val('<%=arrRSMix(16,0)%>');
		$("#charSkillP").val('<%=arrRSMix(17,0)%>');
		$("#charStra").val('<%=arrRSMix(18,0)%>');
		$("#charDext").val('<%=arrRSMix(19,0)%>');
		$("#charAim").val('<%=arrRSMix(20,0)%>');
		$("#charLuck").val('<%=arrRSMix(21,0)%>');
		$("#charAP").val('<%=arrRSMix(22,0)%>');
		$("#charDP").val('<%=arrRSMix(23,0)%>');
		$("#charHC").val('<%=arrRSMix(24,0)%>');
		$("#charHD").val('<%=arrRSMix(25,0)%>');
		$("#charNHP").val('<%=arrRSMix(26,0)%>');
		$("#charNMP").val('<%=arrRSMix(27,0)%>');
		$("#charMHP").val('<%=arrRSMix(28,0)%>');
		$("#charMMP").val('<%=arrRSMix(29,0)%>');
		$("#charresfi").val('<%=arrRSMix(30,0)%>');
		$("#charreswa").val('<%=arrRSMix(31,0)%>');
		$("#charresea").val('<%=arrRSMix(32,0)%>');
		$("#charreswi").val('<%=arrRSMix(33,0)%>');
		$("#charresev").val('<%=arrRSMix(34,0)%>');
		$("#regdate").text('<%=arrRSMix(35,0)%>');
		
		
		//alert($("#Char_ID_IDX").val());
		
	//
	
		$("#charlevel").change(function(){
			//$("#charExp").val(Character_level($(this).val() -1 ) + 1 );
			$("#EXP_Lavel1").text(Character_level($(this).val() -1 ) + 1);
			$("#EXP_Lavel2").text(Character_level($(this).val()));
		});
		
	 });
	 
	 
</script>
<%else %>
<script>
	$(function($){
		$('#Character_Tab').tabs();
	});
</script>
<%		End if%>
	<div id="Character_Tab" style="height:500px ;margin-bottom:3px;overflow-y:auto; ">
		<ul style="font-size:95%">
			<li><a href="#tabs-1"><%=MsgExtract("F4_Title005")%></a></li>
			<li><a href="/GMTool/Form/Form_Character_Item.asp?Server=<%=rServer%>&GBN=I&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>"><%=MsgExtract("F4_Title006")%></a></li>
			<li><a href="/GMTool/Form/Form_Character_Item.asp?Server=<%=rServer%>&GBN=S&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>"><%=MsgExtract("F4_Title003")%></a></li>
			<li><a href="/GMTool/Form/Form_Character_Hench.asp?Server=<%=rServer%>&GBN=I&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>"><%=MsgExtract("F4_Title008")%></a></li>
			<li><a href="/GMTool/Form/Form_Character_Hench.asp?Server=<%=rServer%>&GBN=S&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>"><%=MsgExtract("F4_Title007")%></a></li>
			<li><a href="/GMTool/Form/Form_Character_Guild.asp?Server=<%=rServer%>&C_serial=<%=rC_serial%>&C_name=<%=escape(rC_name)%>&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>"><%=MsgExtract("F4_Title009")%></a></li>
			<li><a href="/GMTool/Form/Form_Character_Friend.asp?Server=<%=rServer%>&C_serial=<%=rC_serial%>&C_name=<%=escape(rC_name)%>&id_idx=<%=rid_idx%>&Socket=<%=rSocket%>"><%=MsgExtract("F4_Title010")%></a></li>
		</ul>
		<%if rC_name = "" Then%>
			<div id="tabs-1"  style="text-align: center">
				<div style="maigin:0 auto; width:300px; text-align:left;padding-top:20px">
					캐릭터 이름을 클릭하시면 정보를 확인 할 수 있습니다.
				</div>
			</div>
		<%
			Response.End
		End if%>
		<div id="tabs-1"  class="form_table">
			<table border="1" cellspacing="0" summary="New Character Form" style="width:100%">
			  <tr><td width=33%>
				<table border="0" cellspacing="0" summary="">
				  <tr>
				    <th><%=MsgExtract("F5_Title001")%></th>
				    <td>
				      <div class="item"><input type="text" id="charname" name="charname" value="<%=rC_name%>"></div>
				    </td>
				  </tr>
				   <tr>
				    <th><%=MsgExtract("F5_Title008")%></th>
				    <td>
				      <div class="item"><%=rC_serial%></font>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title009")%></th>
				    <td>
				      <div class="item" id="charType"><!--캐릭터종류--></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title002")%></th>
				    <td>
				      <div class="item" id="zone_point"><!--접소위치--></div>
				    </td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title004")%></th>
				    <td>
				      <div class="item"><select id="charlevel" name="charlevel"></select></div>
				    </td>
				  </tr>
				            
				  <tr>
				    <th><%=MsgExtract("F5_Title005")%></th>
				    <td>
				      <div class="item"><input TYPE="text" id="charExp" name="charExp" value="0"><br><label id="EXP_Lavel1"></label>~ <label id="EXP_Lavel2"></label></div>
				    </td>
				  </tr>       
				  <tr>
				    <th><%=MsgExtract("F5_Title006")%></th>
				    <td>
				      <div class="item"><input type="text" id="charemp" name="charemp" value="" size=4 maxlength=4></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title007")%></th>
				    <td>
				      <div class="item"><input type="text" id="charadb" name="charadb" value="" size=4 maxlength=3></div>
				    </td>
				  </tr>
				  
				  <tr>
				    <th><%=MsgExtract("F5_Title010")%></th>
				    <td>
				      <div class="item"><input type="text" id="charhead" name="charhead" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title011")%></th>
				    <td>
				      <div class="item"><input type="text" id="charbody" name="charbody" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				   <tr>
				    <th><%=MsgExtract("F5_Title012")%></th>
				    <td>
				      <div class="item"><input type="text" id="charfoot" name="charfoot" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				</table>
				</td>
				<td width=33%>
					<table border="0" cellspacing="0" summary="">
				  <tr>
				    <th><%=MsgExtract("F5_Title013")%></th>
				    <td>
				      <div class="item"><input type="text" id="charGP" name="charGP" value=""  maxlength=10></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title014")%></th>
				    <td>
				      <div class="item"><input type="text" id="charMoveS" name="charMoveS" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title015")%></th>
				    <td>
				      <div class="item"><input type="text" id="charAttS" name="charAttS" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				            
				  <tr>
				    <th><%=MsgExtract("F5_Title016")%></th>
				    <td>
				      <div class="item"><input TYPE="text" id="charSkillS" name="charSkillS" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>       
				  <tr>
				    <th><%=MsgExtract("F5_Title017")%></th>
				    <td>
				      <div class="item"><input type="text" id="charSkillP" name="charSkillP" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title018")%></th>
				    <td>
				      <div class="item"><input type="text" id="charStra" name="charStra" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				   <tr>
				    <th><%=MsgExtract("F5_Title019")%></th>
				    <td>
				      <div class="item"><input type="text" id="charDext" name="charDext" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title020")%></th>
				    <td>
				      <div class="item"><input type="text" id="charAim" name="charAim" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title021")%></th>
				    <td>
				      <div class="item"><input type="text" id="charLuck" name="charLuck" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title022")%></th>
				    <td>
				      <div class="item"><input type="text" id="charAP" name="charAP" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				   <tr>
				    <th><%=MsgExtract("F5_Title023")%></th>
				    <td>
				      <div class="item"><input type="text" id="charDP" name="charDP" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				</table>
				</td>
				<td width=33% valign="top">
				<table border="0" cellspacing="0" summary="" valign="top">
				  <tr>
				    <th><%=MsgExtract("F5_Title024")%></th>
				    <td>
				      <div class="item"><input type="text" id="charHC" name="charHC" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title025")%></th>
				    <td>
				      <div class="item"><input type="text" id="charHD" name="charHD" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title026")%></th>
				    <td>
				      <div class="item"><input type="text" id="charNHP" name="charNHP" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				            
				  <tr>
				    <th><%=MsgExtract("F5_Title027")%></th>
				    <td>
				      <div class="item"><input TYPE="text" id="charNMP" name="charNMP" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>       
				  <tr>
				    <th><%=MsgExtract("F5_Title028")%></th>
				    <td>
				      <div class="item"><input type="text" id="charMHP" name="charMHP" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title029")%></th>
				    <td>
				      <div class="item"><input type="text" id="charMMP" name="charMMP" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <!---->
				   <tr>
				    <th><%=MsgExtract("F5_Title031")%></th>
				    <td>
				      <div class="item"><input type="text" id="charresfi" name="charresfi" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				                   
				  <tr>
				    <th><%=MsgExtract("F5_Title032")%></th>
				    <td>
				      <div class="item"><input type="text" id="charreswa" name="charreswa" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				            
				  <tr>
				    <th><%=MsgExtract("F5_Title033")%></th>
				    <td>
				      <div class="item"><input TYPE="text" id="charresea" name="charresea" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>       
				  <tr>
				    <th><%=MsgExtract("F5_Title034")%></th>
				    <td>
				      <div class="item"><input type="text" id="charreswi" name="charreswi" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				  <tr>
				    <th><%=MsgExtract("F5_Title035")%></th>
				    <td>
				      <div class="item"><input type="text" id="charresev" name="charresev" value="" size=4 maxlength=5></div>
				    </td>
				  </tr>
				   <tr>
				    <th><%=MsgExtract("F5_Title030")%></th>
				    <td>
				      <div class="item" id="regdate"></div>
				    </td>
				  </tr>
				  
				</table>
				</td>
				</tr>
			</table>
		</div>
	</div>
