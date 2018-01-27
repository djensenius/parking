// @flow

document.addEventListener("turbolinks:load", () => {
  if (document.querySelector(".tabs")) { // $FlowFixMe
    M.Tabs.init(document.querySelector(".tabs")); // eslint-disable-line
  }
});
