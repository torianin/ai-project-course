jQuery(document).ready(function($) {
        var pusher = new Pusher('0b6500a2c511ef6a91ba');
        
        var channel = pusher.subscribe('test_channel');
        channel.bind('my_event', function(data) {
            var term = $('#term').terminal();
            term.echo(data.message);
        });

        if( !(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) ) {
            $("#input").hide();
        }
        $("#input").focusout(function (){
            $("#input").val('Kliknij tutaj, aby wpisać zapytanie.');
        });
        $("#input").click(function (){
            $("#input").val('');
        });
        $("#input").keyup(function (e) {
            var term = $('#term').terminal();
            if (e.keyCode == 13) {
                var input = $(this).val();
                term.exec(input,false);
                $("#input").val('Kliknij tutaj, aby wpisać zapytanie.');
                $("#input").blur()
            }
        });
        $('#term').terminal(function(command, term) {
            $.post("ask",
            {
                query:command,
            },
            function(data,status){
                term.echo(data);
            });
        }, {
        greetings: '[[b;red;black] _______         _             _       \r\n|__   __|       (_)           (_)      \r\n   | | ___  _ __ _  __ _ _ __  _ _ __  \r\n   | |\/ _ \\| \'__| |\/ _` | \'_ \\| | \'_ \\ \r\n   | | (_) | |  | | (_| | | | | | | | |\r\n   |_|\\___\/|_|  |_|\\__,_|_| |_|_|_| |_|]\r\n\t\t\t\t\t[[;red;black]  robert-i.com 2014]\r\n----------------------------------------\r\nCreated by Robert Ignasiak \r\n[[;lightblue;black]Facebook: http://facebook.com/torianin\r\nLinkedin: http://linkedin.com/in/torianin\r\nInstagram: http://instagram.com/torianin]\r\n----------------------------------------\r\n\r\nWitam serdecznie i czekam na pytania.',
        name: 'torianin',
        height: 550,
        width: 600,
        prompt: ''});
    });