<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->

<%
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rServer 	:	rServer			= Request("Server")
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim rCItem		: 	rCitem			= Request("cI")
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	
%>

<div style="padding-top: 15px">
	<center>
	<form id="form_item_Move<%=rGBN%>" action="/Common/Class/GMTool/GMT_Character_Item.class.asp?I_Pro=ITEMMOVE" method="post">
		<input type=hidden name="Server" value="<%=rServer%>">
		<input type=hidden name="id_idx" value="<%=rid_idx%>">
		<input type=hidden name="Socket" value="<%=rSocket%>">
		<input type=hidden name="GBN" value="<%=rGBN%>">
	
	<table>
		<tr>
			<td align=left><div style="padding-bottom:5px;">이동될 Item, Server : <%=rServer%></div>
				<select id="Mitem_sel" name="Mitem_sel" size=15 multiple style="width:200px;"></select>
			</td>
			<td width="80">
				<center><img src="/images/arrow_right.png" ></center>
			</td>
			<td align=left>
				<div style="padding-bottom:5px;"><%=MsgExtract("F9_Title027")%></div>
				<input type="text" id="charsearch" name="charsearch" style="width:120px">
				<span class="btn_pack medium icon"><span class="seach"></span><button type="button" id="chara_search_btn">&nbsp;<%=MsgExtract("Lab_Search")%></button></span>
				<br><br><br>
				<div id="move_target_char" style="height:130px">
				
				
				</div>
				
			</td>
		</tr>
	</table>
	<div style="padding-top:15px;"><span class="btn_pack medium icon"><span class="saveas"></span><button type="submit" id="char_item_move_btn">&nbsp;<%=MsgExtract("Btn_Save")%></button></span></div>
	</form>
	</center>
</div>		
		
	
<script>
	
$(function(){

	var a_check_item = new Array(<%=rCitem%>);
	var s_option = "";
	for(var i = 0 ; i < a_check_item.length ; i++){
		s_option = s_option + '<option value="'+a_check_item[i][2]+'|'+a_check_item[i][1]+'">'+ s_item_search(a_check_item[i][0]) +'</option>'
	}
	$("#charsearch").keydown(function(e){
	
		if (e.keyCode == 13){
			search_character();
			return false;
		}
		
	});
	$("#Mitem_sel").empty().append(s_option) ;
	
	$("#chara_search_btn").click(function(){
		search_character();
	});
	
	$("input[name='charsearch']").focus();
	
	
	//아이템 이동 저장 버튼을 클릭했을경우
	$('#form_item_Move<%=rGBN%>').submit(function(){
		if (confirm('<%=MsgExtract("F9_Title030")%>')){
			$("#Mitem_sel option").prop('selected',true);
			$(this).ajaxSubmit({ beforeSubmit: check_move_form, success: rtn_Move_item_val });
			return false;
		}else{
			return false;
		}
		
	});

	function check_move_form (formData, jqForm, optionsa) {
		var sw_f = false;
		//캐릭터가 검색되었는지 체크한다.
		if ($("#charsearch").val() == ''){
			alert("<%=MsgExtract("F9_Title027")%>");
			return false;
		} 
		
		//이동할 캐릭터가 선택되었는지 체크
		if ($("input[name='target_char']").is(":checked")){
			
		}else{
			alert("<%=MsgExtract("F9_Title028")%>");
			return false;
		}
		
		return true;
	}
	
	function rtn_Move_item_val(responseText, statusText, xhr, $form)  {  
		if (responseText == '1002') {
			alert('<%=MsgExtract("F3_Title014")%>');
		}else{
			gen_Item_Table();
			alert('<%=MsgExtract("F6_Title027")%>');
			$('#item_hidden_form').empty().dialog('close');
			
		}
	} 
	
	
	function search_character(){
		var str = '';
		str			= $("#charsearch").val();
		if (str == ''){
			alert('<%=MsgExtract("F9_Title027")%>');
			return false;
		}
		
		// 해당 계정의 캐릭터를 가져온다.
		$.getJSON("/Common/Class/GMTool/GMT_Character.class.asp?GBN=<%=rGBN%>&key=IMOVE_CHAR&Server=<%=rServer%>&s_item="+escape(str),	function(data){
		
			if (data.CNT == 0){
			
			}else{
				var m_html = "";
				m_html = m_html +"<div><%=MsgExtract("F9_Title028")%></div><br>";
				$.each(data.List, function(i,C_char){
					m_html = m_html +' <div style="height:42px;" title="<%=MsgExtract("F9_Title026")%> :'+ C_char.N4 +'">';
					m_html = m_html +' <input type="radio" id="target_char'+i+'" name="target_char" value="'+C_char.N1+'|'+C_char.N2+'" rel="'+C_char.N4+'">';
					m_html = m_html +' <label  for="target_char'+i+'" style="cursor:pointer">' + unescape(C_char.N3) + ' ('+ C_char.N4 +')</label></div>' ;
				});
				$('#move_target_char').empty().html(m_html);
				
				// 캐릭터를 클릭하면 해당 캐릭터의 비어있는 소캣 갯수와  이동시킬 아이템 갯수를비교한다. 
				$('input[id^=target_char]').click(function(){

					if ( a_check_item.length  > parseInt($(this).attr("rel"))){
						alert('<%=MsgExtract("F9_Title029")%>');
						$(this).attr("checked", false);
					}
				});
			}
			
		});
	
	}
});	
	
</script>