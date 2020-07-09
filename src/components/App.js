import React, { Component } from 'react'
import Web3 from 'web3'
import Navbar from './Navbar'
import EthSwap from '../abis/EthSwap.json'
import Token from '../abis/Token.json'
import './App.css'

class App extends Component {

  async componentWillMount(){
    await this.loadWeb3()
    await this.loadBlockchainData()
  }

  async loadBlockchainData() {
    const web3 = window.web3
    const accounts = await web3.eth.getAccounts()
    this.setState({account: accounts[0] })

    const ethBalance = await web3.eth.getBalance(this.state.account)
    this.setState({ethBalance})
    console.log(ethBalance)

    // load token
    const networkId = await web3.eth.net.getId()
    const tokenData = Token.networks[networkId]
    if(tokenData){
      const token = new web3.eth.Contract(Token.abi, tokenData.address)
      this.setState({token})

      let tokenBalance = await token.methods.balanceOf(this.state.account).call() // investor's token balance
      this.setState({tokenBalance: tokenBalance.toString()})
      
      console.log("tokenBalance", tokenBalance)
    } else {
      window.alert('Token contract is not deployed to detected network')
    }

    const ethSwapData = EthSwap.networks[networkId]
    if(tokenData){
      const ethSwap = new web3.eth.Contract(EthSwap.abi, ethSwapData.address)
      this.setState({ethSwap})
      console.log("ethswap",ethSwap)
    } else {
      window.alert('EthSwap contract is not deployed to detected network')
    }
    

  }

  async loadWeb3() {
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum)
      await window.ethereum.enable()
    }
    else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider)
    }
    else {
      window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
  }
  // call this function when react creates the components
  constructor(props) {
    super(props)
    this.state = {
      account: '',
      token: {},
      tokenBalance: '0', // store token in state
      ethSwap: {},
      ethBalance: '0'
    } 
  }

  render() {
    console.log(this.state.account)
    return (
      <div>
        <Navbar account={this.state.account}/>
        <div className="container-fluid mt-5">
          <div className="row">
            <main role="main" className="col-lg-12 d-flex text-center">
              <div className="content mr-auto ml-auto">
                <a
                  href="http://www.dappuniversity.com/bootcamp"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                </a>
                <h1>Hello, World!</h1>
              </div>
            </main>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
