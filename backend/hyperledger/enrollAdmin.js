const FabricCAServices = require('fabric-ca-client');
const { Wallets } = require('fabric-network');
const fs = require('fs');
const path = require('path');

async function main() {
    try {
        // Load the network configuration
        const ccpPath = path.resolve(__dirname, '../hyperledger/connection-org1.json'); // Updated path
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf8'));
        
        // Create a new CA client for interacting with the CA
        const caInfo = ccp.certificateAuthorities['ca.org1.example.com'];
        const ca = new FabricCAServices(caInfo.url);

        // Create a new file system-based wallet
        const walletPath = path.resolve(__dirname, 'wallet');
        if (!fs.existsSync(walletPath)){
            fs.mkdirSync(walletPath);
        }
        const wallet = await Wallets.newFileSystemWallet(walletPath);
        console.log(`Wallet path: ${walletPath}`);

        // Check if we've already enrolled the admin user
        const identity = await wallet.get('Org1Admin');
        if (identity) {
            console.log('Admin identity already exists in the wallet');
            return;
        }

        // Enroll the admin user
        const enrollment = await ca.enroll({ enrollmentID: 'admin', enrollmentSecret: 'adminpw' });
        const x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'Org1MSP',
            type: 'X.509',
        };
        await wallet.put('Org1Admin', x509Identity);
        console.log('Successfully enrolled admin user "Org1Admin" and imported it into the wallet');
    } catch (error) {
        console.error(`Failed to enroll admin user "Org1Admin": ${error}`);
    }
}

main();
