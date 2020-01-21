console.log('The bot is starting');

var Twit = require('twit');
var jsonfile = require('jsonfile')
 
var file_1 = './tmp/data_1.json'
var file_2 = './tmp/data_2.json'

var array_1 = new Array();
var array_2 = new Array();

var config = require('./config');

var T_1 = new Twit(config);
var T_2 = new Twit(config);

var stream_1 = T_1.stream('statuses/filter', { track: 'bolsonaro' })
var counter_1 = 0;

var stream_2 = T_2.stream('statuses/filter', { track: 'lula' })
var counter_2 = 0;

stream_1.on('tweet', function (tweet) {
  counter_1++;
  console.log(counter_1);
  // console.log(tweet);
  // console.log(tweet.created_at);
  // console.log(tweet.text);
  array_1[array_1.length] = {};
  array_1[array_1.length-1].id = counter_1;
  array_1[array_1.length-1].created_at = tweet.created_at;
  array_1[array_1.length-1].time = new Date();
  array_1[array_1.length-1].text = tweet.text;
  console.log(array_1[array_1.length-1]);
  console.log(array_1.length);
  var jsonArray = JSON.parse(JSON.stringify(array_1))
  // array.push( {text: tweet.text, created_at: tweet.created_at});
  jsonfile.writeFile(file_1, array_1, function (err) {
    console.error(err)
  })
  
  function testTime_1 (time, index){
    var now = new Date();
    if(now - array_1[index].time >= 300000){
      console.log('Tweet antigo apagado!');
      array_1.shift();
    }
  }

  array_1.forEach(testTime_1);
})
stream_2.on('tweet', function (tweet) {
  counter_2++;
  console.log(counter_2);
  // console.log(tweet);
  // console.log(tweet.created_at);
  // console.log(tweet.text);
  array_2[array_2.length] = {};
  array_2[array_2.length-1].id = counter_2;
  array_2[array_2.length-1].created_at = tweet.created_at;
  array_2[array_2.length-1].time = new Date();
  array_2[array_2.length-1].text = tweet.text;
  console.log(array_2[array_2.length-1]);
  console.log(array_2.length);
  var jsonArray = JSON.parse(JSON.stringify(array_2))
  // array.push( {text: tweet.text, created_at: tweet.created_at});
  jsonfile.writeFile(file_2, array_2, function (err) {
    console.error(err)
  })
  
  function testTime_2 (time, index){
    var now = new Date();
    if(now - array_2[index].time >= 300000){
      console.log('Tweet antigo apagado!');
      array_2.shift();
    }
  }

  array_2.forEach(testTime_2);
})
