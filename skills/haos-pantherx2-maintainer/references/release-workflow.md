# Panther X2 Release Workflow

Use only for the commit, push, and release actions the maintainer explicitly requested. An upgrade-only request leaves the merge uncommitted. Do not infer permission to overwrite an existing release/tag or force-push.

## Preflight

- Recheck the live `origin` branch, local HEAD, staged diff, merge parents, and any unrelated changes. The remote head must remain the intended first parent/base before a normal push.
- Check the fork's remote tag and GitHub release for `<version>`, including drafts, before creating either. If one already exists, inspect its commit and assets; do not recreate, retag, or replace it silently.
- Confirm `buildroot-external/meta` produces the exact requested version, and the matrix contains Panther X2 only. Release tags and metadata must match or the build fails.
- Run the skill's verification checks. Record any unavailable tools or tests without claiming they passed. A full local HAOS build is not required merely to publish the already configured release workflow.

## Commit and push

- Commit the reviewed merge and any requested maintenance documentation. Preserve both merge parents. Follow the repository's existing commit style, for example `Merge HAOS <version> into panther-x2`.
- Push only the intended branch with an explicit refspec, such as `git push origin HEAD:refs/heads/panther-x2`. Never use `--tags`: a fetched official `<version>` tag points to the upstream commit, not the Panther merge commit.
- If the configured SSH transport fails, an already authenticated GitHub CLI/connector or HTTPS transport for the same verified repository can be used. Do not change SSH keys, credential storage, or security settings as part of the upgrade.
- If the push outcome is uncertain, read the remote head before retrying. If the remote changed, inspect it before proceeding; do not force-push.
- Verify the remote branch SHA equals the intended release commit before creating the release.

## Create the fork release

When the tag and release are absent, create a published GitHub release targeting the exact verified fork commit, not the upstream tag. Use non-prerelease status for stable versions such as 18.5; use `--prerelease` for an authorized rc/beta release. For a stable release:

```sh
gh release create <version> --repo <fork-owner>/operating-system \
  --target <verified-fork-commit-sha> \
  --title "Home Assistant OS <version>" --notes-file <reviewed-notes-file>
```

GitHub creates the missing remote tag at that target commit. A same-named local upstream tag is not uploaded by this command. If retaining a local fork tag, preserve the official tag under `refs/haos-upstream/tags/<version>` first and verify both identities before updating the local tag. Never move an existing remote tag automatically.

Release notes should identify Panther X2, the actual upstream delta, the retained Panther/Green kernel version when relevant, the source commit, and the official release URL. Do not claim a new security fix for Panther when it was already included in an earlier fork release. State that image and RAUC assets appear only after the release build succeeds.

## Verify publication and artifacts

- Read back the release URL, published/draft/prerelease status, target tag, and peeled tag commit. All must match the intended release.
- Find the `OS build` workflow run triggered by the `release` event for that exact commit/tag. Avoid mistaking a manual run or an older version's run for this release.
- Report queued/running/failed/succeeded separately from release creation. If a run fails, inspect the failed job/logs and report the concrete blocker before retrying or modifying release state.
- The current release workflow builds and uploads:
  - `haos_panther-x2-<version>.img.xz`
  - `haos_panther-x2-<version>.raucb`
  - `SHA256SUMS`
  - `SHA256SUMS.sigstore.json`
- Verify all expected assets exist and have nonzero size before reporting the image/bundle as available. Keep release-only signing/upload behavior and the existing fork-only build policy; do not restore R2 publishing, upstream artifact-index updates, or channel bumps.
- If the build is still running, give the release/run links and remaining status, then continue the authorized status check. Do not represent source archives or an empty release page as completed firmware artifacts.
