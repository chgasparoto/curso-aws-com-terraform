const express = require('express');
const axios = require('axios');

const app = express();
const port = 3000;

app.get('/', (req, res) => res.send('Hello World from Nodejs!'));
app.get('/healthcheck', (req, res) => res.send('Hello World from Nodejs!'));

app.get('/cat', (req, res) => {
    axios.get('https://aws.random.cat/meow')
        .then(response => {
            console.log(JSON.stringify(response.data));

            const { file: catImage } = response.data;
            res.send(`<img src="${catImage}" alt="cat" style="max-width: 500px" />`);
        })
        .catch(error => {
            console.error(error);
            res.send(error.message);
        })
});

app.get('/dog', (req, res) => {
    axios.get('https://dog.ceo/api/breeds/image/random')
        .then(response => {
            console.log(JSON.stringify(response.data));

            const { message: dogImage } = response.data;
            res.send(`<img src="${dogImage}" alt="cat" style="max-width: 500px" />`);
        })
        .catch(error => {
            console.error(error);
            res.send(error.message);
        })
});

app.get('/fox', (req, res) => {
    axios.get('https://randomfox.ca/floof/')
        .then(response => {
            console.log(JSON.stringify(response.data));

            const { image: foxImage } = response.data;
            res.send(`<img src="${foxImage}" alt="cat" style="max-width: 500px" />`);
        })
        .catch(error => {
            console.error(error);
            res.send(error.message);
        })
});

app.listen(port, () => {
    console.log(`App running on port ${port}`);
});
