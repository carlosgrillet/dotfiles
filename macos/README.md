# macOS migration

This directory restores programs and configuration, not personal data or
secrets. Back up SSH keys, GPG keys, documents, credentials, browser data, and
application data separately.

Before returning the old Mac, refresh the inventory:

```bash
cd ~/github/dotfiles/macos
./migrate.sh snapshot
git diff -- Brewfile apps.txt
```

Review the diff before committing. `Brewfile` may contain private company taps.
`apps.txt` is an audit list; it does not install software. Manually installed
applications with supported Homebrew casks are listed in `Brewfile.extra`.

On the new Mac, sign in to GitHub or restore your SSH access, then run:

```bash
mkdir -p ~/github
git clone git@github.com:carlosgrillet/dotfiles.git ~/github/dotfiles
cd ~/github/dotfiles/macos
./migrate.sh restore --dry-run
./migrate.sh restore
./migrate.sh audit
```

The restore is safe to rerun. Existing config files are moved under
`~/.migration-backups/<timestamp>` before symlinks are created.

Company-managed software, Mac App Store purchases not reported by Homebrew,
and applications without a current cask must be installed separately. Compare
the final machine with `apps.txt` after company enrollment is complete.
