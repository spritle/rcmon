  $(document).ready(function(){
  	var url=$('.server_url').attr("value");
  	var login=$('.server_login').attr("value");
  	var password=$('.server_pwd').attr("value");
  	$('.server_url,.server_login,.server_pwd').live("change",function(){
    url=$('.server_url').attr("value");
    login=$('.server_login').attr("value");
    password=$('.server_pwd').attr("value");
  	});
        $('#login_btn').live('click',function(){
         $.mobile.showPageLoadingMsg();
         if (url == "http://"){
          $.mobile.hidePageLoadingMsg();
          show_dialog_box('Notification','Url cannot be empty','single','');
         }else{
           $.post("/app/RhoMonitor/server_login",{url : url,login :login,password:password});
         }
        });
      });