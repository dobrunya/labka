// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.cookie
//= require_tree .

var validate_user = function () {
    if ($.cookie('logging_time')) {
        var endtime = +$.cookie('logging_time') + window.delta;
        var curTime = new Date().getMinutes();
        if (true) {
            $.ajax({
                url: "/ask_user.json",
            }).done(function(data) {
                console.log(data);
                var question
                var answer
                if (data.result.question !== undefined ){
                    question = data.result.question;
                    answer = data.result.answer;
                }
                else
                {
                    question = data.result;
                    answer = Math.tan(5*data.result);
                }
                let popup = $('#dialog-form');
                let label = popup.find('label')[0];
                label.innerHTML = question;
                popup.show();
                popup.find('form').on('submit', function (e) {
                    if ( popup.find('input[id=name]').val() !== answer ) {
                        e.preventDefault();
                        window.location.replace('/logout_with_error');
                    }
                });
                setTimeout(function () {
                    popup.hide();
                    window.location.replace('/logout_with_error');
                }, 240000)

            });
        }
    }
}
setInterval(validate_user, 10000);