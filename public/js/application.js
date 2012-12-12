function helloWorld() {}
$(document).ready(function(){
   $('.user_dashboard').live("click",function(){
    var name=$(this).data("user");
    $.mobile.showPageLoadingMsg();
    $.post("/app/Users/user_dashboard_refresh",{ user_name : name});
   });

   $('.device_refresh').live("click",function(){
   var name=$(this).data("user");
    $.mobile.showPageLoadingMsg();
    $.post("/app/Device/device_refresh",{ user_name : name});
 });

   $('.device_param_refresh').live("click",function(){
   var name=$(this).data("user");
   var device=$(this).data("device");
    $.mobile.showPageLoadingMsg();
    $.post("/app/Device/device_params_refresh",{ user_name : name,device_name : device });
 });

   $('.source_list_refresh').live("click",function(){
    var name=$(this).data("user");
    $.mobile.showPageLoadingMsg();
    $.post("/app/Source/source_refresh",{ user_name : name});
   });

    $('.source_param_refresh').live("click",function(){
    // alert($(this).data("user"))
    var name=$(this).data("user");
    var source=$(this).data("source");
    $.mobile.showPageLoadingMsg();
    $.post("/app/Source/source_param_refresh",{ user_name : name,source_name :source});
   });

     $('.source_doc_refresh').live("click",function(){
    // alert($(this).data("user"))
    var name=$(this).data("user");
    var source=$(this).data("source");
    var source_doc=$(this).data("doc");
    $.mobile.showPageLoadingMsg();
    $.post("/app/Source/source_doc_refresh",{ user_name : name,source_name :source,doc : source_doc});
   });
  });