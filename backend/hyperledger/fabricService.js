const { Gateway, Wallets } = require('fabric-network');
const path = require('path');
const fs = require('fs');

async function insertApplicationId(applicationId) {
    try {
        // Load the connection profile
        const ccpPath = path.resolve(__dirname, 'connection-org1.json');
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf8'));

        // Load the wallet
        const walletPath = path.join(process.cwd(), 'wallet');
        const wallet = await Wallets.newFileSystemWallet(walletPath);

        // Check if user is already enrolled
        const identity = 'appUser';
        const userIdentity = await wallet.get(identity);
        if (!userIdentity) {
            console.log(`An identity for the user ${identity} does not exist in the wallet`);
            return;
        }

        // Create a new gateway connection
        const gateway = new Gateway();
        await gateway.connect(ccp, {
            wallet,
            identity,
            discovery: { enabled: true, asLocalhost: true }
        });

        // Get the network (channel) where the contract is deployed
        const network = await gateway.getNetwork('mychannel');

        // Get the contract from the network
        const contract = network.getContract('ApplicationContract');

        // Submit the transaction to insert the applicationId
        await contract.submitTransaction('insertApplicationId', applicationId);
        console.log(`Application ID ${applicationId} has been inserted into the ledger`);

        // Disconnect from the gateway
        await gateway.disconnect();

    } catch (error) {
        console.error(`Failed to insert application ID: ${error}`);
        process.exit(1);
    }
}

// Example usage: insert application ID 'app123'
insertApplicationId('app123');
