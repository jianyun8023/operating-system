---
name: haos-pantherx2-maintainer
description: Maintain this Home Assistant Operating System fork for Panther X2. Use when upgrading the panther-x2 branch to a new upstream HAOS release tag, merging home-assistant/operating-system changes, comparing Panther X2 with HAOS Green, updating buildroot-external/configs/panther_x2_defconfig kernel or board-adjacent settings, preserving Panther-specific packages and firmware, or auditing GitHub Actions release behavior for this fork.
---

# HAOS Panther X2 Maintainer

## Overview

Use this skill to upgrade the `panther-x2` branch of this HAOS fork while preserving the local Panther X2 board support and fork-only release behavior. Panther X2 is maintained as a Green-aligned RK3566 target, but it keeps its own board paths, DTS, U-Boot config, firmware, and local utility packages.

For historical Panther upgrade patterns, read [references/history-patterns.md](references/history-patterns.md) when the task involves a new HAOS release or asks why a Panther setting exists.

## Ground Rules

- Prefer Chinese when reporting results to the maintainer.
- Start with `git status --short --branch` and protect unrelated user changes.
- Use `up` as the upstream remote (`home-assistant/operating-system`) and `origin` as this fork.
- Fetch upstream refs/tags before trusting a target release tag. If tag fetch reports old tag clobber failures but the target tag appears locally, continue with the target tag.
- Use `git merge --no-commit --no-ff <release-tag>` unless the user explicitly asks you to commit.
- Keep `.github/workflows/matrix.json` limited to Panther X2.
- Keep `workflow_dispatch` defaults in `.github/workflows/build.yaml` fork-friendly: `boards: panther-x2`, `publish: false`, `run_tests: false`.
- Release builds may upload artifacts to `github.event.release.upload_url`; do not restore upstream R2 publishing, artifact index updates, or channel bump jobs for this fork.

## Upgrade Workflow

1. Verify the release:
   - Run `git fetch up --tags`.
   - Confirm the tag exists with `git tag --list <version>`.
   - Inspect upstream changes with `git log --oneline <previous-tag>..<version>` and `git diff --name-status <previous-tag> <version>`.

2. Review Panther history:
   - Run `git log --all --oneline --decorate --grep=panther`.
   - For recent Panther updates, inspect patches with `git show --stat <commit>` and `git show <commit> -- buildroot-external/configs/panther_x2_defconfig`.
   - Load `references/history-patterns.md` for known upgrade motifs.

3. Merge upstream:
   - Run `git merge --no-commit --no-ff <version>`.
   - Resolve conflicts by preserving local fork policy where it intentionally differs from upstream.
   - Common conflict: `.github/workflows/build.yaml`; absorb routine action pin bumps, but keep the Panther-only and release-to-this-repo behavior.

4. Align Panther X2 with Green:
   - Compare `buildroot-external/configs/green_defconfig` and `buildroot-external/configs/panther_x2_defconfig`.
   - Usually copy only `BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE` from Green to Panther X2.
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
   - Check whitespace with `git diff --check`.
   - Confirm Panther and Green kernel versions match.
   - Confirm `.github/workflows/matrix.json` still has only `panther-x2`.
   - Confirm `.github/workflows/build.yaml` still uploads release assets to the current release and does not reintroduce upstream channel bump jobs.
   - Do not run a full HAOS build unless requested; it is expensive.

## Reporting

Summarize the upstream release merged, Panther X2-specific changes made, workflow policy preserved, and any validation not run. Mention if the merge is intentionally left uncommitted.
