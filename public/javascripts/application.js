// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function showCard(card_id) {
  $('#preview').html($('#card_' + card_id).html());
}
function show_card_info(card_id, x, y) {
  var card_div = $('#card_' + card_id);
  $('#selected_card').html(card_div.html());
}
function show_card_actions(game_card_id, x, y) {
  hide_card_actions();
  $('.card_container').hide();
  var card_div = $('#card_actions_' + game_card_id)
  show_card_div(card_div, x + 5, y);
}
function hide_card_actions() {
  $('.card_action_container').hide();
}
function show_card_div(card_div, x, y) {
  card_div.css('position', 'fixed');
  card_div.css('z-index', '500');
  card_div.css('top', y);
  card_div.css('left', x);
  card_div.show();
}
function hide_card_info(card_id) {
  $('#card_' + card_id).hide();
}
function run_action(card_id, container_id, code, param_required) {
  switch(param_required) {
    case 'none':
      break;
    default:
      alert("I don't know what to do!");
  }
  var url = '/game_cards/' + card_id + '/handle_action';
  var post_data = {
    'game_container_id': container_id,
    'code': code
  };
  $.post( url, post_data, function(data, http_status, xhr) {
    location.reload();
  });
}
