#!/bin/bash

cp -p $0 /tmp/save.$$

set -eux
git reset --hard master
git merge 'VRT_DirectorResolve' 'VRT_Format_Proxy'
commits=(
    1dc50a9f64c293031796d222747c6b914dcc8227
    0bf4e09a25420951aa0f15a5d9893d524c893731
    873879dc0852c1a6b4a5b25ed88bba28fb1e810d
    62ac5e8cb95e7dc7de2784c23b597b5768415cbc
    30744f9a4cf28f5144188c2d9039ecdc9264a8d4
    7bdc7cc25549d68b09423da4a134755264cbb6a5
)
for c in "${commits[@]}" ; do
    if ! git cherry-pick "${c}" ; then
	echo SHELL to resolve conflict
	bash
    fi
done

cp -p /tmp/save.$$ $0
git add $0
git commit -m 'add the update script'
