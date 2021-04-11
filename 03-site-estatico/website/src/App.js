import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Curso AWS com Terraform - Cleber Gasparoto
        </p>
        <a
          className="App-link"
          href="https://www.youtube.com/channel/UCnP-0M4m5peN-7aLfs4pScA"
          target="_blank"
          rel="noopener noreferrer"
        >
          Canal do Youtube
        </a>
        <br/>
        <a
            className="App-link"
            href="https://clebergasparoto.com"
            target="_blank"
            rel="noopener noreferrer"
        >
          Site Pessoal
        </a>
        <br/>
        <a
            className="App-link"
            href="https://twitter.com/clebergasparoto"
            target="_blank"
            rel="noopener noreferrer"
        >
          Twitter
        </a>
        <br/>
        <a
            className="App-link"
            href="https://github.com/chgasparoto"
            target="_blank"
            rel="noopener noreferrer"
        >
          Github
        </a>
      </header>
    </div>
  );
}

export default App;
