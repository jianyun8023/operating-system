# Panther X2 HAOS Upgrade Patterns

Use this reference when upgrading Panther X2 to a new HAOS release or explaining historical local changes.

## Confirmed Local Patterns

- `d8ae697c8` / `2c07c5e1d` (`2025-09-24`): `.github/workflows/matrix.json` was reduced from upstream's full board matrix to only Panther X2.
- `5f2dcfc85` (`2025-09-24`): `panther_x2_defconfig` followed upstream kernel `6.12.41 -> 6.12.43` and added the empty `BR2_TARGET_LOCALTIME=""` default used by upstream.
- `ff25de5cf` (`2025-11-05`): `panther_x2_defconfig` followed upstream kernel `6.12.43 -> 6.12.51`; `BR2_PACKAGE_PIGZ=y` was kept but moved to the upstream-like package ordering.
- `84e20683d` (`2025-11-05`): Panther X2 added `BR2_PACKAGE_RNG_TOOLS=y`.
- `f24ba290d` (`2026-06-19`): Panther X2 was updated to HAOS `18.0`: renamed `HASSOS` paths/functions to `HAOS`, changed boot args variable names from `bootargs_hassos` to `bootargs_haos`, moved kernel config from `v6.12.y` to `v6.18.y`, updated kernel `6.12.85 -> 6.18.35`, updated U-Boot `2025.01 -> 2026.04`, added MT7920/MT7925 firmware and `USBIP`.
- `98efa1f27` (`2026-06-20`): Panther X2 kept/added AP6236 firmware package support through `BR2_PACKAGE_FIRMWARE_AP6236=y` and the `firmware_ap6236` package.

## Green Alignment Rule

Panther X2 tracks HAOS Green for shared RK3566/aarch64 base behavior:

- Linux kernel major/minor series and patch version.
- Shared `kernel/v*.y` fragments: `haos.config`, `docker.config`, `device-support.config`, `device-support-wireless.config`.
- Shared Buildroot package capabilities that are not board-identity-specific.
- Shared U-Boot version when Green changes it.

Panther X2 must keep its own board identity and local extras:

- Panther board directory and patches.
- Panther DTS and U-Boot board defconfig.
- `BR2_PACKAGE_OS_AGENT_BOARD="panther-x2"`.
- `BR2_PACKAGE_HASSIO_MACHINE="green"` because it intentionally maps Supervisor behavior to Green.
- AP6236 Wi-Fi firmware support.
- Local convenience/debug packages unless explicitly removed by the maintainer.

## GitHub Actions Rule

This fork builds/releases Panther X2 only:

- `.github/workflows/matrix.json` contains one entry: `id: panther-x2`, `defconfig: panther_x2`, `architecture: aarch64`.
- `.github/workflows/build.yaml` keeps manual defaults conservative: Panther X2 board, no publish, no tests by default.
- Release event assets upload to this repository release via `github.event.release.upload_url`.
- Do not restore upstream jobs that publish to R2, update Home Assistant artifact indexes, bump HAOS channels, or bump RPi Imager metadata.
