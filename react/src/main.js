import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import AuditionsContainer from './containers/AuditionsContainer';

$(function () {
  let app = document.getElementById('app')
  if (app) {
    ReactDOM.render(
      <AuditionsContainer />,
      app
    );
  }
});
