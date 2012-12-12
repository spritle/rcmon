$(document).ready(function(){
  var message =$('.mgs').attr("value");
  var vibrate =$('.vibrate').attr("value");
  var sound =$('.sound').attr("value");
  // alert($('.sound').attr("value"))
  $(".mgs,.vibrate,.sound").live('change',function(){
  message=$('.mgs').attr("value");
  vibrate=$('.vibrate').attr("value");
  sound =$('.sound').attr("value");
  });
   $('#user_ping').live('click',function(){
    $.mobile.showPageLoadingMsg();
    $.post("/app/Ping/ping_users",{ping_mgs : message,ping_vibrate : vibrate,ping_sound : sound});
   });
  });