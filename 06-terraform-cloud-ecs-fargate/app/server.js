const express = require('express');
const axios = require('axios');

const app = express();
const port = 3000;

app.get('/', (req, res) => res.send('Hello World from Nodejs!'));
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

app.listen(port, () => {
    console.log(`App running on port ${port}`);
});