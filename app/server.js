const express = require("express");
const redis = require("redis");

const app = express();
const client = redis.createClient({ url: "redis://redis:6379" });

client.connect();

app.get("/", async (req, res) => {
  let count = await client.incr("hits");
  res.send(`Hello from Node.js! This page has been visited ${count} times.`);
});

app.listen(3000, () => {
  console.log("App running on port 3000");
});
