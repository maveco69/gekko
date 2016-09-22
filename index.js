/**
 * Created by Maveco on 8/23/2015.
 */
exports.handler = function (event, context) {
    var command = './backtest-coin.sh';

    var util = require('util'),
        spawn = require('child_process').spawn,

    // ex: execute shell command
    // bash    = spawn('ls', ['-lh', '/usr']); // the second arg is the command
    // options
    // MAIN: call the shell script
        bash = spawn('command', [event.coin, event.day]); // [''] place holders for args

    bash.stdout.on('data', function (data) {    // stdout handler
        console.log('stdout: ' + data);
        context.succeed('stdout: ' + data);
    });

    bash.stderr.on('data', function (data) {	// stderr handler
        console.log('stderr: ' + data);
        context.fail('stderr: ' + data);
        // context.fail('Something went wrong');
    });

    bash.on('exit', function (code) {		// exit code handler
        console.log('lambda bash exited with code ' + code);
    });
};


//console.log(array);
exports.handler({
    "coin": "BURST",
    "day": "01"
}, {
    succeed: function (e) {
        console.log("Sucess: " + e + " ms: " + (new Date().getTime() - started.getTime()));
    },
    done: function (e) {
        console.log("Done: " + e);
    },
    fail: function (e) {
        console.log("fail: " + e);
    }
});