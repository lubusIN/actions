#!/bin/sh

# Exit if any command fails
set -eu

# Create zip archive
echo "\n⏳ Creating zip archive\n"

zip -r "$*.zip" . -x '/*node_modules/*' '/*.git/*' '/*.github/*' '/*.wordpress-org/*' '/*src/*' '/*.gitkeep' '/*.distignore' '/*.gitignore' '/*.editorconfig' '/*.eslintignore' '/*.eslintrc' '/*.nvmrc' '/*CHANGELOG.md' '/*CONTRIBUTING.md' '/*docker-compose.yml' '/*package-lock.json' '/*package.json' '/*README.md' '/*webpack.config.js'

echo "\n✅ All done 👌\n"
