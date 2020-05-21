
# Creating local repository then link with remote
<pre><code>
git init
git remote add origin https://github.com/maladaska/dev-tools-config.git
git branch --set-upstream-to=origin/master master
git pull origin master --allow-unrelated-histories
</code></pre>
