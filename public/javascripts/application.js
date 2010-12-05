// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function showCard(card_id) {
  $('#preview').html($('#card_' + card_id).html());
}
