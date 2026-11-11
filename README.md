# Antinode

A physics survival game: you are a pair of crossed standing waves, and every force is the Gor'kov radiation potential, computed live.

Private source for the paid Google Play release. Package: `com.k1ll.antinode`.

    npm install
    npm test
    npm run typecheck
    npm run android   # dist/antinode-<version>-<code>.aab, signed with the upload key
    npm run itch      # dist/antinode-web-<version>.zip, the page as an itch.io upload

The upload key lives outside this repo in `~/.config/antinode/`. Never commit it, and keep the encrypted backup current.

`packaging/itch/cover.png` is a 630x500 cover for itch.io, drawn from the same crossed standing-wave field.
