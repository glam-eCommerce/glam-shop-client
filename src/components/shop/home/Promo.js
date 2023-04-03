import React, { useState, useEffect } from "react";

const Promo = () => {
  const [promo, setPromo] = useState("");

  // connect to AWS redis
  useEffect(() => {
    const redis = require("redis");

    const redisClient = redis.createClient({
      socket: {
        host: process.env.REDIS_HOST,
        port: process.env.REDIS_PORT,
      },
    });

    (async () => {
      await redisClient.connect();
    })();

    redisClient.on("error", function (err) {
      console.log(
        "==========Could not establish a connection with redis.======="
      );
      console.log(err);
    });

    redisClient.get("promo", (err, reply) => {
      setPromo(reply);
    });
  }, []);

  return <div class="promo">{promo}</div>;
};

export default Promo;
