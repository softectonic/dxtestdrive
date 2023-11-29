const { execSync } = require('child_process');

function mergeFeature() {
    const RED = '\x1b[31m';    // Red color
    const GREEN = '\x1b[32m';  // Green color
    const PURPLE = '\x1b[35m'; // Purple color
    const RESET = '\x1b[0m';   // Reset to default color

    try {
        // Get the current branch name
        const currentBranch = execSync('git branch --show-current').toString().trim();

        // Check if the current branch is 'main'
        if (currentBranch === 'main') {
            console.error(`${RED}Error: Attempting to merge into the main branch directly is not allowed.${RESET}`);
            return;
        }

        // Checkout and pull the main branch
        execSync('git checkout main && git pull', { stdio: 'inherit' });

        // Switch back to the original branch and merge
        execSync(`git checkout ${currentBranch} && git merge main`, { stdio: 'inherit' });

        // Check if merge was successful
        const mergeStatus = execSync('git status').toString();
        if (mergeStatus.includes('conflict')) {
            console.error(`${RED}Please resolve the merge conflicts and run ${PURPLE}"git merge --continue"${RED}. Then, as a final step, run ${PURPLE}"git push origin ${currentBranch}"${RED} to update the remote feature branch.${RESET}`);
            return;
        }

        // Push the changes to the remote branch
        execSync(`git push origin ${currentBranch}`, { stdio: 'inherit' });
        console.log(`${GREEN}Successfully merged and updated the remote branch '${currentBranch}'.${RESET}`);
       
    } catch (error) {
        console.error(`${RED}An error occurred: ${error.message}${RESET}`);
    }
}

mergeFeature();