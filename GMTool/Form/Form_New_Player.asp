<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->
<script>
	$(function($){
		$('#Player_form').submit(function(){
			$(this).ajaxSubmit({ beforeSubmit: validationForm, success: Check_val }); 
			return false;
		});
		$('#txtID').blur(function(){
			var this_id = $(this).val();
			
			if (this_id.length > 3){
				$.ajax({  
					url: '/Common/class/GMTool/GMT_Player.class.asp?key=IDCK&S_item='+escape(this_id),  
					cache: false,  
					success: function(data){
						if (data != '0')
							$('#results').empty().append('<%=MsgExtract("F1_Title013")%>').removeClass("f_gre").addClass("f_red");
						else{    
							$('#results').empty().append('<%=MsgExtract("F1_Title014")%>').removeClass("f_red").addClass("f_gre");
						}  
					}
				});
			}else if(this_id.length > 0){
				alert('<%=MsgExtract("F1_Title016")%>');
				$('#results').empty();

			}else{
				$('#results').empty();
			}
			
		});
		
		$('#txtConfirmPwd').blur(function(){
		
			if ($('#txtPwd').val() != ''){
			 	if ($('#txtConfirmPwd').val() != $('#txtPwd').val()){
			 		alert('<%=MsgExtract("F1_Title018")%>');
			 		$('#txtConfirmPwd').val("");
			 		$('#txtConfirmPwd').focus();
			 	}
			}
		});
		
	});
	function Check_val(responseText, statusText, xhr, $form)  {     
			if ($.trim(responseText) == '1001'){ 
				alert('<%=MsgExtract("F1_Title013")%>');
			}else if ($.trim(responseText) == '0000'){ 
				alert('<%=MsgExtract("F1_Title019")%>');
				argment_now(0);
			}
	} 
</script>
<form id="Player_form" method="post" action="/Common/class/GMTool/GMT_Player.class.asp?key=NEW" >
<div class="form_table" style="margin-top: 10px">
<table border="1" cellspacing="0" summary="New Player Insert Form">
  <tr>
    <th><%=MsgExtract("F1_Title001")%></th>
    <td>
      <div class="item"><input type="text" id="txtName" name="txtName"  class="field required" title="<%=MsgExtract("F1_Title009")%>">&nbsp;&nbsp;</div>
    </td>
  </tr>
  <tr>
    <th><%=MsgExtract("F1_Title002")%></th>
    <td>
      <div class="item"><input type="text" id="txtID" name="txtID" value="" class="field required" title="<%=MsgExtract("F1_Title010")%>">&nbsp;&nbsp;<span id="results"></span></div>
    </td>
  </tr>
                   
  <tr>
    <th><%=MsgExtract("F1_Title003")%></th>
    <td>
      <div class="item"><input type="password" id="txtPwd" name="txtPwd" maxlength="12" class="field required" title="<%=MsgExtract("F1_Title011")%>">&nbsp;&nbsp;</div>
    </td>
  </tr>
            
  <tr>
    <th><%=MsgExtract("F1_Title004")%></th>
    <td>
      <div class="item"><input TYPE="password" id="txtConfirmPwd" name="txtConfirmPwd" maxlength="12" class="field required" title="<%=MsgExtract("F1_Title012")%>">&nbsp;&nbsp;</div>
    </td>
  </tr>       
  <tr>
    <th><%=MsgExtract("F1_Title005")%></th>
    <td>
    
      <div class="item"><input type="text" name="txtSocialID" maxlength="13" class="field required" title="<%=MsgExtract("F1_Title015")%>" >&nbsp;&nbsp;</div>
    </td>
  </tr>
  <tr>
    <th><%=MsgExtract("F1_Title006")%></th>
    <td>
      <div class="item"><input type="text" name="txtAccess" maxlength="3" title="<%=MsgExtract("F1_Title008")%>">&nbsp;&nbsp;<font class='f_gre'><%=MsgExtract("F1_Title017")%></font>
      </div> <br>
      <font class="f_red"><%=MsgExtract("F1_Title008")%></font>
    </td>
  </tr>  
 

</table>
</div>
<div style="margin-top:20px"><center>
			<span class="btn_pack medium icon"><span class="saveas"></span><button type="submit">&nbsp;<%=MsgExtract("Btn_Save")%></button></span>
			
	</center></div>
</form>