// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function showCard(card_id) {
  $('#preview').html($('#card_' + card_id).html());
}
function show_card_info(card_id, x, y) {
  var card_div = $('#card_' + card_id)
  card_div.css('position', 'fixed');
  card_div.css('z-index', '500');
  card_div.css('top', y);
  card_div.css('left', x + 55);
  card_div.show();
}
function hide_card_info(card_id) {
  $('#card_' + card_id).hide();
}
