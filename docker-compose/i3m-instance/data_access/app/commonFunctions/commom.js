"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.NRPcompletenessCheck = exports.validateProofOfReception = exports.getTimestamp = exports.responseData = exports.mapData = exports.checkFile = exports.getFilesizeInBytes = void 0;
const fs = require("fs");
const path = require("path");
const crypto = require("crypto");
const nonRepudiationLibrary = require("@i3m/non-repudiation-library");
const getFunctions = require("../routes/routes");
const sqliteFunctions = require("../sqliteFunctions/sqliteFunctions");
require('isomorphic-fetch');
// Load environment variables
const dotenv = require('dotenv').config({ path: path.resolve(__dirname, '../.env') });
let block_size = Number(process.env.BLOCK_SIZE) || 256;
let BACKPLANE_URL = String(process.env.BACKPLANE_URL);
// get file size in bytes
function getFilesizeInBytes(filename) {
    var stats = fs.statSync(filename);
    var fileSizeInBytes = stats.size;
    return fileSizeInBytes;
}
exports.getFilesizeInBytes = getFilesizeInBytes;
// check if file exists, if it doesn't create it and append structure
function checkFile(resource_map_path, resource_path) {
    try {
        fs.accessSync(resource_map_path, fs.constants.F_OK);
        console.log('Map already exists');
    }
    catch (e) {
        const data = '{"records":[]}';
        const create = fs.appendFileSync(resource_map_path, data);
        mapData(resource_map_path, resource_path);
    }
}
exports.checkFile = checkFile;
// map offset to ID
function mapData(resource_map_path, resource_path) {
    const fd = fs.openSync(resource_path, 'r');
    const size = getFilesizeInBytes(resource_path);
    const nr_of_blocks = Math.ceil(size / block_size);
    console.log(`Number of blocks: ${nr_of_blocks}`);
    var data = fs.readFileSync(resource_map_path, 'binary');
    let map = JSON.parse(data);
    let hash = '';
    var index = 0;
    while (index < (nr_of_blocks * block_size)) {
        var buffer = Buffer.alloc(block_size);
        fs.readSync(fd, buffer, 0, block_size, index);
        let content = buffer;
        hash = crypto.createHash('sha256').update(content + hash).digest('hex');
        console.log(`Hash of the block is ${hash}`);
        map.records.push({ [`${hash}`]: `${index}` });
        index += block_size;
    }
    let json = JSON.stringify(map);
    fs.writeFileSync(resource_map_path, json);
    console.log('Map created');
}
exports.mapData = mapData;
// response formating
async function responseData(ID, map, resource_path) {
    let block = block_size;
    // get index of ID
    let keys = [];
    for (let i = 0; i < map.records.length; i++) {
        keys[i] = Object.keys(map.records[i])[0];
    }
    let getIndex;
    if (keys.indexOf(ID) !== undefined) {
        getIndex = keys.indexOf(ID);
    }
    else {
        throw new Error('The inputed Id is wrong');
    }
    // check if you got to last block
    if (getIndex + 1 == keys.length) {
        block = getFilesizeInBytes(resource_path) % block_size;
        console.log(`New block size is: ${block}`);
    }
    // data from coresponding offset
    let buffer = Buffer.alloc(block);
    const promise = await new Promise((resolve) => {
        fs.open(resource_path, 'r+', function (err, fd) {
            if (err) {
                return console.error(err);
            }
            console.log("Reading the file");
            fs.read(fd, buffer, 0, block, parseInt(map.records[getIndex][`${ID}`]), function (err, num) {
                if (err) {
                    console.log(err);
                }
                let content = buffer;
                console.log('CONTENT: ' + content.length);
                if (getIndex + 1 == keys.length) {
                    resolve({ block_id: ID, data: content, next_block_id: null });
                }
                else {
                    resolve({ block_id: ID, data: content, next_block_id: keys[getIndex + 1] });
                }
            });
            // Close the opened file. 
            fs.close(fd, function (err) {
                if (err) {
                    console.log(err);
                }
                console.log("File closed successfully");
            });
        });
    });
    return promise;
}
exports.responseData = responseData;
// Get the date that will be written in the database
function getTimestamp() {
    const currentDate = new Date();
    const dateFormat = `${currentDate.getFullYear()}` + '-' + ("0" + (currentDate.getMonth() + 1)).slice(-2) + '-' + ("0" + currentDate.getDate()).slice(-2);
    return dateFormat;
}
exports.getTimestamp = getTimestamp;
//nonRepudiationLibrary.StoredProof<nonRepudiationLibrary.PoPPayload>
/////////////// NRP /////////////
async function validateProofOfReception(por, npProvider) {
    await npProvider.verifyPoR(por.jws);
    const pop = await npProvider.generatePoP();
    const poo = npProvider.block.poo;
    const timestamp = getTimestamp();
    const consumer_id = getFunctions.getConsumerId();
    const block_id = getFunctions.getBlockId();
    sqliteFunctions.saveProofs(timestamp, consumer_id, block_id, JSON.stringify(poo), JSON.stringify(por), JSON.stringify(pop));
    console.log(JSON.stringify(pop));
    return pop;
}
exports.validateProofOfReception = validateProofOfReception;
async function NRPcompletenessCheck(npProvider) {
    const signedResolution = await fetchSignedResolution(npProvider);
    const { payload, signer } = await nonRepudiationLibrary.ConflictResolution.verifyResolution(signedResolution);
    if (payload.resolution === 'completed') {
        // is a valid proof of completeness signed by signer (the public JWK)
        console.log("NRP Protocol is completed");
    }
}
exports.NRPcompletenessCheck = NRPcompletenessCheck;
async function fetchSignedResolution(npProvider) {
    const verificationRequest = await npProvider.generateVerificationRequest();
    sleep(70000);
    let verification = await fetch(`${BACKPLANE_URL}/conflictResolverService/verification`, {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ "verificationRequest": `${verificationRequest}` }),
    }).catch((error) => {
        console.error('Error:', error);
    });
    const resolution = await verification.json();
    console.log("signedResolution => " + JSON.stringify(resolution));
    const signedResolution = resolution.signedResolution;
    return signedResolution;
}
function sleep(milliseconds) {
    const date = Date.now();
    let currentDate = 2;
    do {
        currentDate = Date.now();
    } while (currentDate - date < milliseconds);
}
