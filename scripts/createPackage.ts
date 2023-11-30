import * as readline from 'readline';
import { exec } from 'child_process';

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function askQuestion(query: string): Promise<string> {
    return new Promise(resolve => rl.question(query, resolve));
}

async function createUnlockedPackage() {
    try {
        const packageName = await askQuestion('Enter package name: ');
        const filePath = await askQuestion('Enter file path: ');
        const packageType = 'Unlocked';

        console.log(`Creating unlocked package with the following details:
            Name: ${packageName}
            Path: ${filePath}
            Type: ${packageType}`);

        // Command to create the unlocked package
        exec(`sfdx force:package:create -n ${packageName} -r ${filePath} -t ${packageType}`, (error, stdout, stderr) => {
            if (error) {
                console.error(`Error: ${error.message}`);
                return;
            }
            if (stderr) {
                console.error(`StdErr: ${stderr}`);
                return;
            }
            console.log(`StdOut: ${stdout}`);
        });

    } catch (error) {
        console.error('An error occurred:', error);
    } finally {
        rl.close();
    }
}

createUnlockedPackage();
