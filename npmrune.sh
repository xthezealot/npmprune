#!/bin/sh

TARGET_DIR=node_modules

if [ ! -d "$TARGET_DIR" ]; then
	echo "$TARGET_DIR" does not exist
	exit 1
fi

PATTERNS="
	__tests__
	_config.yml
	.babel*
	.circle*
	.documentup*
	.ds_store
	.editorconfig
	.env*
	.git*
	.idea
	.lint*
	.npm*
	.nyc*
	.prettier*
	.tern-project
	.yarn-integrity
	.yarn-metadata.json
	.yarnclean
	.yo-*
	*.coffee
	*.flow*
	*.jst
	*.markdown
	*.md
	*.mkd
	*.swp
	*.tgz
	*appveyor*
	*coveralls*
	*eslint*
	*htmllint*
	*jshint*
	*readme*
	*stylelint*
	*travis*
	*tslint*
	*vscode*
	*wallaby*
	authors
	changelog
	changes
	circle.yml
	component.json
	contributors
	coverage
	doc
	docs
	example
	examples
	grunt*
	gulp*
	images
	jenkins*
	jest*
	jsconfig.json
	karma.conf*
	license
	license.txt
	makefile
	powered-test
	prettier.*
	test
	test.*
	tests
	tsconfig.json
	website
"

PROD_PATTERNS="
	*.map
	*.ts
"

if [ "$1" = "-p" ]; then
	PATTERNS="$PATTERNS $PROD_PATTERNS"
fi

echo "$TARGET_DIR size before: $(du -sh "$TARGET_DIR" | awk '{print $1}')"

for pattern in $PATTERNS; do
	find "$TARGET_DIR" -iname "$pattern" -exec rm -rf {} +
done

echo "$TARGET_DIR size after:  $(du -sh "$TARGET_DIR" | awk '{print $1}')"
