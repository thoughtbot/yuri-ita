# Releasing

## Prepare
1. Update the version number in `lib/yuriita/version.rb`.
1. Update `NEWS.md` to reflect the changes since last release.
1. Open and merge a PR with the changes.

## Tag
1. Tag the release:       `git tag -s vVERSION`
1. Sign the release:      `git tag -s vVERSION -m "the best version yet"`
   [notes on signing releases]
1. Verify the signed tag: `git tag --verify vVERSION`
1. Push changes: `git push --tags`

## Publish
1. Build and publish:
    ```bash
    gem build yuri-ita.gemspec
    gem push yuri-ita-*.gem
    ```

## Announce
1. Add a new GitHub release using the recent `NEWS.md` as the content. Sample
   URL: https://github.com/thoughtbot/yuri-ita/releases/new?tag=vVERSION
1. Announce the new release,
   making sure to say "thank you" to the contributors
   who helped shape this version!

[notes on signing releases]: http://gitready.com/advanced/2014/11/02/gpg-sign-releases.html
