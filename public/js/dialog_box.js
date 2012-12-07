  // $(".refresh_icon").click(function(){
    //     location.reload();
    //    })
  //alert("test");
  // $("#reset_db").click(function(){
  //  //alert("test");
  //  $.post("/app/RhoMonitor/reset");
  // });
 $(document).delegate('#reset_db', 'click', function() {
  // NOTE: The selector can be whatever you like, so long as it is an HTML element.
  //       If you prefer, it can be a member of the current page, or an anonymous div
  //       like shown.
  $('<div>').simpledialog2({
    mode: 'button',
    headerText: 'DB Reset',
    headerClose: true,
    buttonPrompt: 'Are you sure want to reset database?',
    buttons : {
      'YES': {
        click: function () { 
          $('#buttonoutput').text('Yes');
          $.post("/app/RhoMonitor/on_dismiss_popup",{ button_title : "Yes"});
        }
      },
      'NO': {
        click: function () { 
          $('#buttonoutput').text('No');
        },
        icon: "delete",
        theme: "c"
      }
    }
  });
});

 $('#adapter').live("click",function(){
   $.post("/app/RhoMonitor/get_adapter");
 });
 $('#ping_status').live("click",function(){
   $.post("/app/RhoMonitor/ping_status");
 });
 function show_dialog_box(head_text,body,btn_type,callback_url){
  //alert("test")
 //alert("test")
 //alert(callback_url)
   if (btn_type == "single"){
    //alert("if")
    single_button_type1(head_text,body,btn_type,callback_url);
   }else{
    //alert("else")
   }
   
 }
 function single_button_type1(head_text,body,btn_type,callback_url){
  //alert(body)
   $('<div>').simpledialog2({
    mode: 'button',
    headerText: head_text,
    headerClose: true,
    buttonPrompt: body,
    buttons : {
      'OK': {
        click: function () { 
          $('#buttonoutput').text('Yes');
          if(callback_url){
            window.location.href = callback_url;
          }
        }
      }
    }
  });
 }
$(document).delegate('#user_delete', 'click', function() {
  // var data_id=$(this).attr("id");
  // alert($(this).attr("id"))
  var user=$(this).data("user");
  
  $('<div>').simpledialog2({
    mode: 'button',
    headerText: 'Delete Box',
    headerClose: true,
    buttonPrompt: 'Are you want to delete this user?',
    buttons : {
      'YES': {
        click: function () { 
          $('#buttonoutput').text('Yes');
          
          $.post("/app/Users/delete_popup",{ user_name : user,button_title : "Yes"});
        }
      },
      'NO': {
        click: function () { 
          $('#buttonoutput').text('No');
        },
        icon: "delete",
        theme: "c"
      }
    }
  });
});
  $(document).delegate('#device_delete_btn', 'click', function() {
  // var data_id=$(this).attr("id");
  // alert($(this).attr("id"))
  //alert("test")
  var name=$(this).attr("title");
  $('<div>').simpledialog2({
    mode: 'button',
    headerText: 'Delete Box',
    headerClose: true,
    buttonPrompt: 'Are you want to delete this device?',
    buttons : {
      'YES': {
        click: function () { 
          $('#buttonoutput').text('Yes');
          $.post("/app/Device/delete",{ device_name : name})
        }
      },
      'NO': {
        click: function () { 
          $('#buttonoutput').text('No');
        },
        icon: "delete",
        theme: "c"
      }
    }
  });
});