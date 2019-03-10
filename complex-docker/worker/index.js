const keys = require("./keys");
const redis = require("redis");

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    retry_strategy: () => 1000
});
const sub = redisClient.duplicate();

function fib(index) {
    var a = 0;
    var b = 1;
    var c = 0;
    for (var i = 0; i < index; i++) {
        c = a + b;
        a = b;
        b = c;
    }
    return c;
}

sub.on("message", (channel, message) => {
    redisClient.hset("values", message, fib(parseInt(message)));
});
sub.subscribe("insert");