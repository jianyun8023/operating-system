---
name: haos-pantherx2-maintainer
description: Maintain this Home Assistant Operating System fork for Panther X2. Use when upgrading the panther-x2 branch to a new upstream HAOS release tag, merging home-assistant/operating-system changes, comparing Panther X2 with HAOS Green, updating buildroot-external/configs/panther_x2_defconfig kernel or board-adjacent settings, preserving Panther-specific packages and firmware, or publishing an authorized Panther X2 GitHub release and checking its build artifacts.
---

# HAOS Panther X2 Maintainer

## Overview

Use this skill to upgrade the `panther-x2` branch of this HAOS fork while preserving the local Panther X2 board support and fork-only release behavior. Panther X2 is maintained as a Green-aligned RK3566 target, but it keeps its own board paths, DTS, U-Boot config, firmware, and local utility packages.

For historical Panther upgrade patterns, read [references/history-patterns.md](references/history-patterns.md) when the task involves a new HAOS release or asks why a Panther setting exists.

## Ground Rules

- Prefer Chinese when reporting results to the maintainer.
- Start with `git status --short --branch` and protect unrelated user changes.
- Use `up` as the upstream remote (`home-assistant/operating-system`) and `origin` as this fork.
- Fetch the live fork branch before choosing the upgrade baseline; a clean checkout and cached `origin/panther-x2` can both be stale.
- Keep upstream release refs separate from fork release tags. A local tag name alone does not prove which repository it came from.
- Use `git merge --no-commit --no-ff refs/haos-upstream/tags/<version>`; commit only when the user explicitly requests committing or publishing these changes.
- Keep `.github/workflows/matrix.json` limited to Panther X2.
- Keep `workflow_dispatch` defaults in `.github/workflows/build.yaml` fork-friendly: `boards: panther-x2`, `publish: false`, `run_tests: false`.
- Release builds may upload artifacts to `github.event.release.upload_url`; do not restore upstream R2 publishing, artifact index updates, or channel bump jobs for this fork.

## Upgrade Workflow

1. Verify the baseline and release:
   - Fetch `origin` without importing tags: `git fetch --no-tags origin panther-x2`. Verify its live SHA with `git ls-remote origin refs/heads/panther-x2` or the GitHub API, and compare it with `HEAD` and `origin/panther-x2`.
   - If the clean local branch is only behind, fast-forward with `git merge --ff-only origin/panther-x2`. If it has unrelated changes, diverges, or has an in-progress merge based on an older head, preserve the work and resolve the baseline before continuing. Do not overwrite it or blindly repeat the upgrade.
   - Fetch the official tag into a separate ref: `git fetch --no-tags up refs/tags/<version>:refs/haos-upstream/tags/<version>`. Verify the tag object/peeled commit against `git ls-remote up refs/tags/<version> 'refs/tags/<version>^{}'` and the official release notes. Do not force-replace an existing mismatched ref.
   - Inspect only the missing upstream commits with `git log --oneline HEAD..refs/haos-upstream/tags/<version>` and the upstream delta with `git diff --name-status HEAD...refs/haos-upstream/tags/<version>`. Do not infer the baseline from a possibly fork-specific `<previous-tag>`.
   - Check which boards the release affects. A Raspberry Pi-only release need not change Panther's kernel if it already matches Green.

2. Review Panther history:
   - Run `git log --all --oneline --decorate --grep=panther`.
   - For recent Panther updates, inspect patches with `git show --stat <commit>` and `git show <commit> -- buildroot-external/configs/panther_x2_defconfig`.
   - Load `references/history-patterns.md` for known upgrade motifs.

3. Merge upstream:
   - Run `git merge --no-commit --no-ff refs/haos-upstream/tags/<version>`.
   - Resolve conflicts by preserving local fork policy where it intentionally differs from upstream.
   - Common conflict: `.github/workflows/build.yaml`; absorb routine action pin bumps, but keep the Panther-only and release-to-this-repo behavior.

4. Align Panther X2 with Green:
   - Compare `buildroot-external/configs/green_defconfig` and `buildroot-external/configs/panther_x2_defconfig`.
   - Usually copy only `BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE` from Green to Panther X2. Also inspect shared filesystem and boot-recovery fixes; do not reapply changes already present in the fork baseline.
   - Consider firmware or package additions only when Green gained a generic RK3566/wireless capability that Panther X2 also needs.
   - Preserve Panther-specific differences:
     - `board/panther/x2` paths.
     - `rockchip/rk3566-panther-x2` DTS.
     - `BR2_TARGET_UBOOT_BOARD_DEFCONFIG="panther-x2"`.
     - `BR2_PACKAGE_OS_AGENT_BOARD="panther-x2"`.
     - `BR2_PACKAGE_HASSIO_MACHINE="green"`.
     - `BR2_PACKAGE_FIRMWARE_AP6236=y`.
     - Local utility packages such as `WGET`, `HTOP`, `VIM`, `UNZIP`, `DOCKER_COMPOSE`, `RNG_TOOLS`, NTP/timezone, and root login settings unless the maintainer asks to remove them.

5. Verify:
   - Check conflict markers with `rg -n "^(<<<<<<< .+|=======|>>>>>>> .+)$" .github buildroot-external skills`.
   - Check both unstaged and staged changes with `git diff --check` and `git diff --cached --check`.
   - Update the clean Buildroot checkout with `git submodule update --init buildroot`, and verify its HEAD matches the staged gitlink. Preserve any existing submodule work.
   - If Linux patches move between version-specific and common directories, verify their content is preserved and Panther still receives the complete patch set.
   - Confirm Panther and Green kernel versions match.
   - Confirm `.github/workflows/matrix.json` still has only `panther-x2`.
   - Confirm `.github/workflows/build.yaml` still uploads release assets to the current release and does not reintroduce upstream channel bump jobs.
   - Do not run a full HAOS build unless requested; it is expensive.

## Authorized Commit and Release

For an explicit request to commit, push, or publish a release, read [references/release-workflow.md](references/release-workflow.md). Otherwise leave the prepared merge uncommitted as above. Publishing a release triggers the repository's image build; it does not mean the images are already available.

## Reporting

Summarize the upstream release merged, Panther X2-specific changes made, workflow policy preserved, and any validation not run. Mention if the merge is intentionally left uncommitted. For publication, report the verified remote commit, release link, build status, and whether image/checksum assets are actually available.
