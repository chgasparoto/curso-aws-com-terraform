const express = require('express');
const axios = require('axios');

const app = express();
const port = 80;

const indexPage = `
    <h3>Hello from a Node.js Application running on AWS ECS Fargate</h3>
    <p>What would you like to see?</p>
    <ul>
        <li>Random cats? <a href="/cats">Click here</a></li>
        <li>Random dogs? <a href="/dogs">Click here</a></li>
        <li>Random foxes? <a href="/foxes">Click here</a></li>
    </ul>
`;

app.get('/', (req, res) => res.send(indexPage));
app.get('/healthcheck', (req, res) => {
    try {
        res.sendStatus(204);
    } catch (err) {
        res.sendStatus(500);
    }
});

app.get('/cats', (req, res) => {
    axios.get('https://aws.random.cat/meow')
        .then(response => {
            console.log(JSON.stringify(response.data));

            const { file: catImage } = response.data;
            res.send(`<img src="${catImage}" alt="cat" style="max-width: 500px" />`);
        })
        .catch(error => {
            console.error(JSON.stringify(error));
            res.status(500);
            res.send(error.message);
        })
});

app.get('/dogs', (req, res) => {
    axios.get('https://dog.ceo/api/breeds/image/random')
        .then(response => {
            console.log(JSON.stringify(response.data));

            const { message: dogImage } = response.data;
            res.send(`<img src="${dogImage}" alt="cat" style="max-width: 500px" />`);
        })
        .catch(error => {
            console.error(JSON.stringify(error));
            res.status(500);
            res.send(error.message);
        })
});

app.get('/foxes', (req, res) => {
    axios.get('https://randomfox.ca/floof/')
        .then(response => {
            console.log(JSON.stringify(response.data));

            const { image: foxImage } = response.data;
            res.send(`<img src="${foxImage}" alt="cat" style="max-width: 500px" />`);
        })
        .catch(error => {
            console.error(JSON.stringify(error));
            res.status(500);
            res.send(error.message);
        })
});

app.listen(port, () => {
    console.log(`App running on port ${port}`);
});
