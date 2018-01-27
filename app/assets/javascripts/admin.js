// @flow

document.addEventListener("turbolinks:load", () => {
  if (document.querySelector(".tabs")) {
    M.Tabs.init(document.querySelector(".tabs")); // eslint-disable-line
  }
});
