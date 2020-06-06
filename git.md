
# Creating local repository then link with remote
<pre><code>
git init
git remote add origin https://github.com/maladaska/dev-tools-config.git
git branch --set-upstream-to=origin/master master
git pull origin master --allow-unrelated-histories
</code></pre>

# Push repo to new remote
<pre><code>
Create a new repo at github.
Clone the repo from fedorahosted to your local machine.
git remote rename origin upstream
git remote add origin URL_TO_GITHUB_REPO
git push origin master
</code></pre>


