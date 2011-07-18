// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  content.replace(regexp, new_id)
  $(content).insertAfter(link);
}
function brain_click(link, new_conf) {
  var hiddenInput = document.getElementById('node_confidence');
  hiddenInput.value = new_conf;
  hiddenInput.form.submit();
}
