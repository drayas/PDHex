// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function showCard(card_id) {
  $('#preview').html($('#card_' + card_id).html());
}
function show_card_info(card_id, x, y) {
  $('.card_action_container').hide();
  var card_div = $('#card_' + card_id)
  show_card_div(card_div, x + 55, y);
}
function show_card_actions(card_id, x, y) {
  $('.card_container').hide();
  var card_div = $('#card_actions_' + card_id)
  show_card_div(card_div, x + 5, y);
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
function run_action(code, param_required) {
  switch(param_required) {
    case 'none':
      alert(code);
      break;
    default:
      alert("I don't know what to do!");
  }
}
