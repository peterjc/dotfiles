# Peter's dotfiles repository

This uses a [bare git repository to track config
files](https://blog.anikethendre.dev/storing-dotfiles-with-bare-git-repository)
in my macOS and Linux home directory. This is to avoid accidentally checking in
anything under `$HOME` which is not explicitly tracked.

As of 25 May 2025, I moved the repository from
[GitHub](https://github.com/peterjc/dotfiles/) to
[Codeberg](https://codeberg.org/peterjc/dotfiles/), and archived the GitHub copy.

MIT Licensed.

## Setup on a new machine

Clone the repository with fetch on HTTPS (anyone can fetch without authentication)
but push on the git protocol (needs authentication).

```console
$ cd
$ mkdir -p repositories/
$ cd repositories/
$ git clone --bare https://github.com/peterjc/dotfiles.git
$ cd dotfiles.git
$ git remote set-url origin --push git@github.com:peterjc/dotfiles.git
$ git push --set-upstream origin main
$ git config --local status.showUntrackedFiles no
$ git config pull.rebase true
```

We will be using an alias for running git with this repositroy, and that should be
added to the `.zshrc` and/or `.bash_profile`:

```console
$ alias dotfiles-git='git --git-dir=$HOME/repositories/dotfiles.git/ --work-tree=$HOME'
````

Note this does not hard code where `git` is to be found, which could be a system
level install or a more recent version via conda for example.

Use this for the initial checkout:

```console
$ dotfiles-git checkout
````

On a clean/new account, there should be no conflicts. If you already have some local
configuration files in place, rename them first (e.g. `mv ~/.config ~/.config_old`).


## Making changes

> [!WARNING]
> You cannot do a git rebase with a bare repository, so always do a git pull BEFORE
> doing any commits, and remember to push the commits to GitHub too!

```console
$ dotfiles-git pull  # IMPORTANT!
$ dotfiles-git commit ~/.config/some-file -m "Some changes"
$ dotfiles-git push
```

## License

Copyright (c) 2025 Peter Cock

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
