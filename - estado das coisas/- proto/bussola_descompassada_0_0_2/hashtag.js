console.log('The bot is starting');

var Twit = require('twit');
var jsonfile = require('jsonfile')
 
var file_1 = './tmp/data_1.json'
var file_2 = './tmp/data_2.json'

var file_3 = './tmp/data_bolsonaro.json'

var array_1 = new Array();
var array_2 = new Array();

var config = require('./config');

var T_1 = new Twit(config);
var T_2 = new Twit(config);

var T_3 = new Twit(config);

/*T_3.get('statuses/user_timeline', {screen_name: 'jairbolsonaro', count: 8806}, function (err,data){
  console.log(data.text)
  var array_3 = new Array();
  for (var i = 0; i < data.length; i++){
    //console.log(data[i].text)
    array_3[i] = {};
    array_3[i].id = i;
    array_3[i].text = data[i].text;
    array_3[i].created_at = data[i].created_at;  
  }
  var jsonArray = JSON.parse(JSON.stringify(array_3));
  jsonfile.writeFile(file_3, array_3, function(err){
    console.error(err)
  })
})*/

var stream_1 = T_1.stream('statuses/filter', { track: 'bolsonaro' , tweet_mode:'extended'})
var counter_1 = 0;

var stream_2 = T_2.stream('statuses/filter', { track: 'lula' })
var counter_2 = 0;

stream_1.on('tweet', function (tweet) { 
  if (tweet.retweeted_statuses == false){
  counter_1++;
  console.log(counter_1);
  // console.log(tweet);
  // console.log(tweet.created_at);
  // console.log(tweet.text);
  array_1[array_1.length] = {};
  array_1[array_1.length-1].id = counter_1;
  array_1[array_1.length-1].created_at = tweet.created_at;
  array_1[array_1.length-1].time = new Date();
  console.log(tweet.truncated ? tweet.extended_tweet.full_text : tweet.text);
  array_1[array_1.length-1].text = tweet.full_text;
  //console.log(array_1[array_1.length-1]);
  console.log(array_1.length);
  var jsonArray = JSON.parse(JSON.stringify(array_1))
  // array.push( {text: tweet.text, created_at: tweet.created_at});
  jsonfile.writeFile(file_1, array_1, function (err) {
    //console.error(err)
  })
  
 /*function testTime_1 (time, index){
    var now = new Date();
    if(now - array_1[index].time >= 300000){
      console.log('Tweet antigo apagado!');
      array_1.shift();
    }
  }*/

  //array_1.forEach(testTime_1);
}
//console.log(tweet);
})
/*stream_2.on('tweet', function (tweet) {
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
})*/
