jQuery(document).ready(function($) {
    var pusher = new Pusher('0b6500a2c511ef6a91ba');
    
    var channel = pusher.subscribe('test_channel');
    channel.bind('my_event', function(data) {
        var term = $('#term').terminal();
        term.echo(data.message);
    });
});