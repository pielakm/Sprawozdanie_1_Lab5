const express = require('express');

const app = express();
const PORT = 8080;


app.get('/', (req, res) => {
    let answer = "Aplikacja jest uruchomiona na adresie IP " + req.ip;
    answer += " oraz na porcie " + req.socket.localPort + "<br>";
    answer += "Nazwa serwera: " + req.hostname + "<br>";
    answer += "Wersja aplikacji:" + req.protocol + "<br>";
    res.send(answer);
//   res.send('Aplikacja jest uruchomiona na adresie IP', req.ip);
});

app.listen(PORT, () => {
  console.log('Listening on port', PORT, ".");
});
