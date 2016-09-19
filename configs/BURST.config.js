// Everything is explained here:
// @link https://github.com/askmike/gekko/blob/stable/docs/Configuring_gekko.md

var config = {};

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                          GENERAL SETTINGS
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

config.debug = true; // for additional logging / debugging

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                         WATCHING A MARKET
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Monitor the live market
config.watch = {

  // see https://github.com/askmike/gekko#supported-exchanges
  exchange: 'poloniex',
  currency: 'BTC',
  asset: 'BURST'
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                       CONFIGURING TRADING ADVICE
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

config.tradingAdvisor = {
  enabled: true,
  method: 'candle',
  candleSize: 60*12,
  historySize: 10,
  adapter: 'sqlite',
  talib: {
    enabled: false,
    version: '1.0.2'
  }
};

config.trader = {
  enabled: false,
  key: '',
  secret: '',
  username: '' // your username, only required for specific exchanges.
};

config.adviceLogger = {
  enabled: true,
  muteSoft: true // disable advice printout if it's soft
};

// do you want Gekko to calculate the profit of its own advice?
config.profitSimulator = {
  enabled: true,
  // report the profit in the currency or the asset?
  reportInCurrency: true,
  // start balance, on what the current balance is compared with
  simulationBalance: {
    // these are in the unit types configured in the watcher.
    asset: 1,
    currency: 0.02,
  },
  // how much fee in % does each trade cost?
  fee: 0.25,
  // how much slippage/spread should Gekko assume per trade?
  slippage: 0.05
}

config.candleWriter = {
  adapter: 'sqlite',
  enabled: true
}

config.adapters = {
  sqlite: {
    path: 'plugins/sqlite',

    dataDirectory: './history',
    version: 0.1,

    dependencies: [{
      module: 'sqlite3',
      version: '3.1.4'
    }]
  }
}

config.backtest = {
  adapter: 'sqlite',
  daterange: {
    from: "2016-09-15 12:00:00",
    to: "2016-09-16 12:00:00"
  },
  batchSize: 50
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                       CONFIGURING IMPORTING
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

config.importer = {
  daterange: {
    from: "2016-09-15 12:00:00",
    to: "2016-09-16 12:00:00"
  }
}

config['I understand that Gekko only automates MY OWN trading strategies'] = false;

module.exports = config;
