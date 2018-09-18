const {web3, property, sendSignedTx, sendSignedTxSimple, getString, getBytes} = require('./contractUtil.js')

const contractJson = require('../build/contracts/TestUtil.json')
const contractAbi = contractJson.abi
const contractAddr = contractJson.networks[property.networkID].address
const contract = new web3.eth.Contract(contractAbi, contractAddr)

async function testSlot() {
    const data = contract.methods.testSlot().encodeABI()
    await sendSignedTxSimple(contractAddr, data).then(tx => console.log('gasUsed', tx.gasUsed))
    const data1 = contract.methods.testSlotB().encodeABI()
    await sendSignedTxSimple(contractAddr, data1).then(tx => console.log('gasUsed B', tx.gasUsed))
}

async function testSM() {
    const data = contract.methods.testSM().encodeABI()
    await sendSignedTxSimple(contractAddr, data).then(tx => console.log('gasUsed', tx.gasUsed))
}

async function test() {
    // await testSlot()
    await testSM()
}

test()