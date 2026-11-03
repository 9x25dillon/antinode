# Hand-off — Antinode on Google Play

## Resume here
**Newest close:** 2 November 2026, 18:15 PST · Claude Code / Opus 5.5 · session `1077e2ac`
**Where things stand:** Antinode's closed test is live on Play (track "Alpha", build 235271, $0.99, 173 countries) with one tester, the owner. It is not on public sale. Personal Play accounts need 12 testers opted in for 14 straight days before they can apply for production, and only the owner is on the list so far. A one-use promo code exists, and the owner has downloaded the file. Whether it works for a closed tester is untested.
**Decision needed:** none. Waiting on the owner's result from redeeming the code and on testers' Google Play emails.
**Start with:**
1. Ask the owner two things: did the promo code show Antinode as free, and did the tester email go out? Check Gmail Sent or Drafts if they aren't sure.
2. Open Play Console > Antinode > Test and release > Closed testing > Alpha > Testers, to see the list and opt-in state.
3. Add testers' emails to the "Owner testers" list, then make that many one-use codes if the test code worked.

## Console reference
- Developer account `7044879908246219466` (personal, name 9xK1ll); app ID `4973060386278017636`; package `com.k1ll.antinode`.
- Closed track `4698175437350662330`; opt-in link https://play.google.com/apps/testing/com.k1ll.antinode
- Internal track `4699206755757726519`; opt-in link https://play.google.com/apps/internaltest/4699206755757726519
- Promotion `131628690`: 1 code, Nov 3 4:00 AM to Dec 31 12:00 AM in the form's time zone. The code is deliberately not recorded here.
- Privacy policy: https://9x25dillon.github.io/k1ll-legal/antinode.html (repo `9x25dillon/k1ll-legal`, public, in `~/k1ll-apps/legal-site`).
- Listing text and graphics: `~/k1ll-apps/antinode-listing` (`listing.md`, `tester-invite.md`, `screenshots-upload/`).

## Progress track (newest first)
| Date | Session | Shipped (hash / PR) | State after |
|---|---|---|---|
| 2026-11-02 | Opus 5.5 `1077e2ac` | App created; build 235271 on internal, then closed; 10 declarations, rating, listing, price, countries; submitted and published; policy `9ecf5ab`; promo code | Closed test live with 1 tester; public sale blocked by the 12-tester rule |
| 2026-11-02 | Opus 5.5 `eabaed48` | Touch fixes `d1891d7`; AAB 235271 | Touch controls finished, tested on Pixel only |
| 2026-11-02 | Opus 5.5 `c341` | Repo created `3fd0b35`; renamed from Sonic Drifter; upload key | Private repo, signed AAB |

## In flight
- **Promo code test:** the owner has the code. Left: redeem at https://play.google.com/redeem after joining the test. Verify: Play shows the game as owned at no charge.
- **Tester recruiting:** an email draft was in the owner's Gmail with 9 BCC addresses, two under the owner's own name. Whether it was sent is unknown. Text-message wording is in this session's chat only; rewrite it from `tester-invite.md` if needed.

## Decisions (why things are the way they are)
- 2026-11-02 **Paid from the start at $0.99:** a free Play app can't later become paid. Rejected: free during testing.
- 2026-11-02 **Automatic protection left on:** it stops sideloaded copies from running free. It adds `CHECK_LICENSE`; Console bundle details list no `INTERNET`.
- 2026-11-02 **Privacy policy on GitHub Pages:** one command, and it can't affect the live site. Rejected for now: `astra-arcana.com/legal/`, which needs a production frontend rebuild for a static page. The address can change in Console later.
- 2026-11-02 **AI label "Don't label":** the owner's choice, against Claude's recommendation to label. The descriptions and graphics were AI-made, and AI helped build the game. Google's page says regulations require labels "under certain circumstances"; its details weren't read.
- 2026-11-02 **Screenshots padded to exact 16:9 (2432x1368):** Play's form demanded 16:9, and cropping would cut off the on-screen controls.
- 2026-11-02 **Content rating:** violence against non-humans, fantastical, unrealistic reactions, distant view, no blood, plus Yes to dark overtones as a cautious call. Fear No, all else No. Result looks like ESRB E and about 7+ in much of Europe, with some 12s. Target age is 13+.

## Dead ends (don't retry without new information)
- Ticking legal terms or declarations for the owner: auto mode refuses with "Consent Given For The User". Ask the owner to click, then continue.
- Uploading several assets at once in the store listing picker: only the first landed. Upload one set per asset slot.
- Console URLs `.../payment-settings` and `.../main-store-listing` redirect home. Use `download-reports/financial` and `store-listings/default/edit`.
- Promotion start times: the form rejects anything already past in its own time zone, which isn't local (Nov 3 12:00 AM was refused at about 6 PM PST).
- Gmail connector needs re-authentication (`/mcp`); drafting in Chrome worked.

## Open questions (settle these first)
- Does a promo code work for a paid app in a closed test? Only a community post suggests so. Settle by redeeming. Fallback: testers pay $0.99 and the owner reimburses them, as the email promises.
- Does Google's processed build run correctly with the license check? Nobody has installed from Play yet. Settle by installing on the Pixel.
- Google's closed-test wording reads per app. Will Eternity High (formerly Pogo) need its own 12 testers? Settle in Console when that app is created.
- Why 173 track countries against 177 priced? Probably harmless; check if a specific market matters.
- "We don't receive personal data" from the license check rests on the app having no internet permission and no data-sending code. Google's own description wasn't read.

## State (verified 18:11–18:15 PST)
- **antinode** `main`: level with origin before this hand-off, last code commit `d1891d7`, private, no CI.
- **k1ll-apps/legal-site** `main`: level with origin at `9ecf5ab`, public; license-check sentence confirmed live.
- **Production server:** on `4ecf721`, untouched this session. Read over SSH at about 16:45 PST.
- Pixel still has the sideloaded Antinode 235271 (`installerPackageName=null`). The Samsung wasn't connected.

## Project health
- Checks: no code changed this session. The other session reported typecheck clean and 342/342 tests on this source.
- Not tested on 235271: Samsung, run export and import, gamepad, long sessions, the Play-installed copy.
- Touchscreen is listed among the required features although the manifest marks it optional. Phones are unaffected.
- Still open: Antinode trademark uncleared; signing key backup unconfirmed; free Sonic Drifter APK and old key still public in `NEW_REPOSITORY_30`, removal needs the owner's OK.

## Next steps, in order
1. Record the promo code result. If it works, create one code per confirmed tester; each works once.
2. Add testers to "Owner testers", send them the closed opt-in link and a code. Track opt-in dates in the tracker format from `~/k1ll-apps/phase0/tester-invite.md`.
3. Install from Play on the Pixel after uninstalling the sideloaded copy (it deletes that copy's test runs). Check launch, save and resume.
4. Run the key backup: `~/k1ll-apps/phase0/backup-signing-keys.sh`.
5. Fix anything testers report. New builds need a higher versionCode, then go through the closed track.
6. After 12 testers have been opted in for 14 straight days, draft the production application. Keep a feedback record, because Google asks for a summary.

## One-shot check
    bash ~/.claude/skills/hanoffed/scripts/scan.sh --root ~/antinode --fetch
    bash ~/.claude/skills/hanoffed/scripts/checks.sh ~/antinode --run

## Rules that still apply
- Never touch `app.sonicdrifter` on the Samsung; it holds the owner's real run.
- Never print the keystore password in `~/.config/antinode/`, and never commit the key.
- Don't write contacts' addresses, phone numbers, or promo codes into repos or hand-offs.
- Never send tester messages or accept terms for the owner without a specific OK. Downloads need a named OK too.
- The owner is new to this: give one next action at a time, in plain words.
- Don't build Eternity High from the `the-tithe` checkout; another session owns that work.

## Vocabulary so far
See `~/.claude/skills/hanoffed/vocabulary.md`. Newest: attestation, opt-in (Claude Opus 5.5, 2026-11-02).

## Opening prompt for next session (edit the brackets)
> Read `~/antinode/Hand_off.md` and run its one-shot check. The promo code [worked / failed with this message: ...]. These testers said yes: [emails]. Add them to the closed test and make [n] codes. Stipulate: live work, ask me before anything that accepts terms or messages people. When we wrap up: /hanoffed ~/antinode.
