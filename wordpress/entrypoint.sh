#!/bin/sh

# Exit if any command fails
set -eu

# DATA
WP_VERSION=${GITHUB_REF#refs/tags/}
ROOT_PATH="/github/"
SVN_REPO_DIR=${ROOT_PATH}"${WP_SLUG}-svn"
SVN_REPO_URL="http://plugins.svn.wordpress.org/${WP_SLUG}/"

# CHECKOUT SVN DIR
echo "\n⬇️ Checking out repository from WordPress.org\n"
svn checkout $SVN_REPO_URL $SVN_REPO_DIR || { echo "\n⛔️ Unable to checkout SVN repository. \n"; exit 1; }

# Extract release archive to trunk
echo "\n🗂️ Extracting release archive to trunk.\n"
cd "${SVN_REPO_DIR}/trunk/"
unzip -o "${GITHUB_WORKSPACE}/${WP_SLUG}" || { echo "\n⛔️ Unable to extract zip.\n"; exit 1; }

# Update assets
echo "\n🗂️ Copying assets\n"
cp -a ${GITHUB_WORKSPACE}/.wordpress-org/* ${SVN_REPO_DIR}/assets/ || { echo "\n⛔️ Unable to copy assets.\n"; exit 1; }
ls -la "${SVN_REPO_DIR}/assets/"

# CREATE TAGS/${WP_VERSION} FROM TRUNK
echo "\n🏷️ Creating tag ${WP_VERSION} from trunk\n"
svn copy "${SVN_REPO_DIR}/trunk" "${SVN_REPO_DIR}/tags/${WP_VERSION}" || { echo "\n⛔️ Unable to create tag.\n"; exit 1; }

# ADD FILES
echo "\n➕ Add files to commit\n"
cd ${SVN_REPO_DIR}
svn add --force * --auto-props --parents --depth infinity -q || { echo "\n⛔️ Unable to add file(s).\n"; exit 1; }
svn status

# CREATE RELEASE COMMIT
echo "\n✍️ Committing release to wordpress.org ...\n"
svn commit -m "Release ${WP_VERSION}, see readme.txt for the changelog."  --username "${WP_USERNAME}" --password "${WP_PASSWORD}" || { echo "\n⛔️ Unable to create release commit.\n"; exit 1; }

# PUBLISH TO WORDPRESS.ORG
echo "\n⬆️ Publishing release.\n"
svn up || { echo "\n⛔️ Unable to update SVN.\n"; exit 1; }

# DONE
echo "\n🚀 All right sparky ✔️\n"