$( document ).ajaxComplete(function( event, xhr, settings ) {
    $('#problem_issue').val('');
    $('#problem_try').val('');
});