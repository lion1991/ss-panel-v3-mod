{include file='auth/header.tpl'}
<body>


<div id="main">
	<div class="inner">

			<div class="row uniform">
				<p>登录到用户中心</p>
				
				<div class="12u 12u$(xsmall)">
					<input type="text" id="email" class="form-control" placeholder="邮箱"/>
				</div>
				<div class="12u 12u$(xsmall)">
					<input type="password" id="passwd" class="form-control" placeholder="密码"/>
				</div>
				
				<div class="12u 12u$(xsmall)">
					<input type="text" id="code" class="form-control" placeholder="两步验证码，没有设置就请不要输入"/>
				</div>
				
				<div class="12u 12u$(xsmall)">
					<input id="remember_me" value="week" type="checkbox">
					<label for="remember_me">记住我</label>
				</div>

				<div class="12u 12u$(xsmall)">
					<button type="submit" id="login" class="special fit">登录</button>
				</div>

				<pre class="12u 12u$(xsmall)" id="msg-success" style="display: none;">
					
						<div style="float:right;"><button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button></div>
							<h4>登录成功!</h4>
							<p id="msg-success-p"></p>
					
				</pre>
				
				<pre class="12u 12u$(xsmall)" id="msg-error" style="display: none;">
					
						<div style="float:right;"><button type="button" class="close" id="error-close" aria-hidden="true">&times;</button></div>
							<h4>出错了!</h4>
							<p id="msg-error-p"></p>
					
				</pre>

				<div class="12u 12u$(xsmall)">
					<a href="/password/reset">忘记密码</a><br>
					<a href="/auth/register" class="text-center">注册个帐号</a>
				</div>
			</div><!-- /.form-box -->
	</div>
</div>








{include file='footer.tpl'}


<script>
    $(document).ready(function(){
        function login(){
            $.ajax({
                type:"POST",
                url:"/auth/login",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                    passwd: $("#passwd").val(),
					code: $("#code").val(),
                    remember_me: $("#remember_me").val()
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#msg-error").hide(10);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/user'", 2000);
                    }else{
                        $("#msg-success").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误："+jqXHR.status);
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                login();
            }
        });
        $("#login").click(function(){
            login();
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function(){
            $("#msg-error").hide(100);
        });
    })
</script>
