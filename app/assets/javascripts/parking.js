// @flow
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const form = document.getElementById("parking-form");

/* eslint-disable */
document.addEventListener("turbolinks:load", function() {
  (function($) {
    $(function() {
      // $(".button-collapse").sideNav();
      $(".parallax").parallax();
    }); // $FlowFixMe
  })(jQuery);
});
/* eslint-enable */


window.onLoad = findButton;

function findButton() {
  // $FlowFixMe
  document.getElementById("parking-button").addEventListener("click", () => { // $FlowFixMe
    form.submit();
  });
}

// $FlowFixMe
document.addEventListener("turbolinks:load", () => {
  if (document.querySelector(".start_date")) {
    const startElem = document.querySelector(".start_date");
    const startDate = new Date();
    const startOptions = { defaultDate: startDate, setDefaultDate: true }; // $FlowFixMe
    new M.Datepicker(startElem, startOptions); // eslint-disable-line

    const endElem = document.querySelector(".end_date");
    const endDate = new Date(new Date().getTime() + (86400 * 1000));
    const endOptions = { defaultDate: endDate, setDefaultDate: true }; // $FlowFixMe
    new M.Datepicker(endElem, endOptions); // eslint-disable-line    
  }
});
