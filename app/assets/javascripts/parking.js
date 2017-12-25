// @flow
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const form = document.getElementById("parking-form");

/* eslint-disable */
(function($) {
  $(function() {
    $(".button-collapse").sideNav();
    $(".parallax").parallax();
  }); // $FlowFixMe
})(jQuery);
/* eslint-enable */


window.onLoad = findButton;

function findButton() {
  // $FlowFixMe
  document.getElementById("parking-button").addEventListener("click", () => { // $FlowFixMe
    form.submit();
  });
}
