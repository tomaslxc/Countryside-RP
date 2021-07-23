
jQuery(document).ready(function() {

    $('.page-container form').submit(function(){
        var username = $(this).find('.username').val();
        var password = $(this).find('.password').val();
        var password2 = $(this).find('.password2').val();
		var email = $(this).find('.email').val();
		var email2 = $(this).find('.email2').val();
        if(username == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '27px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.username').focus();
            });
            return false;
        }
        if(password == '' || email2 == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '96px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.password').focus();
            });
            return false;
        }
        if(password2 == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '165px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.password2').focus();
            });
            return false;
        }
        if(email == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '234px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.email').focus();
            });
            return false;
        }
    });

    $('.page-container form .username, .page-container form .password').keyup(function(){
        $(this).parent().find('.error').fadeOut('fast');
    });

	$("#loginform").show();
	$("#barrasuperior1").show();
	
$('#gotoregister').click(function() {
$("#loginform").hide(1000);
$("#registerform").show(1500);
});
	
$('#gotologin').click(function() {
$("#loginform").show(1500);
$("#registerform").hide(1000);
});

$('#gotologin2').click(function() {
$("#loginform").show(1500);
$("#recpassform").hide(1000);
});
	
$('#gotorecp').click(function() {
$("#recpassform").show(1500);
$("#loginform").hide(1000);
});
	
});

function loginTrigger() {
var UsernameValue = $( "#UsernameInput" ).val();
var PasswordValue = $( "#PasswordInput" ).val();
mta.triggerEvent("belepesfunkc", UsernameValue, PasswordValue)
	
}
function registerTrigger() {
var UsernameValue = $( "#UsernameInputR" ).val();
var PasswordValue = $( "#PasswordInputR" ).val();
var PasswordCValue = $( "#PasswordCInputR" ).val();
var EmailValue = $( "#EmailInputR" ).val();
mta.triggerEvent("belepesfunkcregisztral", UsernameValue, PasswordValue, PasswordCValue, EmailValue)
}

function recuperarpass(){
var UsernameValue = $( "#UsernameInputR2" ).val();
var EmailValue = $( "#EmailInputR2" ).val();

}

function gotologinfromregister(){
$("#registerform").hide(1000);
$("#loginform").show(1000);
document.getElementById("UsernameInputR").value = "";
document.getElementById("PasswordInputR").value = "";
document.getElementById("PasswordCInputR").value = "";

}
