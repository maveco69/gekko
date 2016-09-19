// If you want to use your own trading methods you can
// write them here. For more information on everything you
// can use please refer to this document:
// 
// https://github.com/askmike/gekko/blob/stable/docs/trading_methods.md
// 
// The example below is pretty stupid: on every new candle there is
// a 10% chance it will recommand to change your position (to either
// long or short).

var config = require('../core/util.js').getConfig();
var settings = config.custom;
var log = require('../core/log.js');

// Let's create our own method
var method = {};

// Prepare everything our method needs
method.init = function() {
  this.currentTrend = 'long';
  this.requiredHistory = 0;
  this.upTrend = 0;
  this.downTrend = 0;
};

// What happens on every new candle?
method.update = function(candle) {
  if(candle.open < candle.close){
    this.upTrend++;
    this.downTrend = 0;
  } else {
    this.upTrend = 0;
    this.downTrend++;
  }
  this.toUpdate = true;
};

// For debugging purposes.
method.log = function() {
  log.debug('calculated random number:');
};

// Based on the newly calculated
// information, check if we should
// update or not.
method.check = function() {

  // Only continue if we have a new update.
  if(!this.toUpdate)
    return;

  if(this.currentTrend === 'long' && this.downTrend == 0) {

    // If it was long, set it to short
    this.currentTrend = 'short';
    this.advice('short');

  } else {

    // If it was short, set it to long
    this.currentTrend = 'long';
    this.advice('long');

  }
}

module.exports = method;