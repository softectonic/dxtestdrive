const { execSync } = require('child_process');

function rebaseFeature() {
    try {
        // Get the current branch name
        const currentBranch = execSync('git branch --show-current').toString().trim();

        // Check if the current branch is 'main'
        if (currentBranch === 'main') {
            console.error('Error: Attempting to rebase the main branch is not allowed.');
            return;
        }

        // Checkout and pull the main branch
        execSync('git checkout main && git pull', { stdio: 'inherit' });

        // Switch back to the original branch and rebase
        execSync(`git checkout ${currentBranch} && git rebase main`, { stdio: 'inherit' });

    } catch (error) {
        console.error('An error occurred:', error.message);
    }
}

rebaseFeature();
