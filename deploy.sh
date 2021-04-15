
# build
npm run build
# navigate into the build output directory
cd dist
# commit and push in order to commit
git init
git add -A
git commit -m 'deploy'
git push -f git@github.com:username/hello-world.git master:gh-pages
cd ..