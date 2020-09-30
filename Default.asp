<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Mixmaster GMTool</title>
<meta name="description" content="" />
<link rel="stylesheet" type="text/css" href="/common/css/login.css"/>
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/themes/base/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="/common/css/jquery.alerts.css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/jquery-ui.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/common/js/commonjs/common.js"></script>
<script type="text/javascript" src="/common/js/commonjs/jquery.form.js"></script>

<script language="javascript">
//<![CDATA[	
	$(function($){
		$('#login').submit(function(){
			$(this).ajaxSubmit({ beforeSubmit: validationForm, success: Check_val }); 
			return false;
		});
		$("#login_username").focus();
	});
	
	function Check_val(responseText, statusText, xhr, $form)  {     
		if ($.trim(responseText) == 99){ 
			alert('Access Denied');
		}else if ($.trim(responseText) == 98){ 
			alert('Access Denied');
		}else if ($.trim(responseText) == 0){ 
			location.replace ("/GMTool/");
		}
	} 
	
//]]>
</script>


</head>
<body>

<form id="login" method="post" action="/member/GM_login_ok.asp" > 
    <h1>Log in to <strong>Mixmaster Gmtool</strong></h1>
    <div>
    	<label for="login_username">User ID</label> 
    	<input type="text" name="username" id="login_username" class="field required" title="Please provide your UserId," />
    </div>			
    <div>
    	<label for="login_password">Password</label>
    	<input type="password" name="password" id="login_password" class="field required" title="Password is required" />
    </div>			
    <div class="submit" style="text-align:right">
        <button type="submit">Log in</button>   
    </div>
     <p class="back">Gmtool Ver 2.0</p>
    
</form>	
</body>
</html>
