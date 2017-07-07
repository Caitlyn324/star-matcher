import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import AuditionsContainer from './containers/AuditionsContainer';

$(function() {
  ReactDOM.render(
    <AuditionsContainer />,
    document.getElementById('app')
  );
});
