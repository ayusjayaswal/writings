+++
title = "Git for babies"
date = 2025-10-11
draft = false

[taxonomies]
tags = ["git", "pcon", "notes"]
+++

![](https://blogbyte.in/media/blog/2025/git.png)
<br>
<br>
_These were once my notes from when I was first learning git so expect it to be a bit rough. This should help people learn and use git plus related tech. Anyways, Happy Learnin :)._

Now, if you are a programmer your work will always start with something git (afa it ain't CP) and will end with git too. So, it's a good investment of your time to learn this already.

There are several ways to use git; this blog talks about the CLI way. I usually use [Magit](https://magit.vc/) when I'm on [emacs](https://www.gnu.org/software/emacs/emacs.html) and CLI when I'm not. Any would do fine, but I'll hate you if yew use a GUI.
Also, If you're curious; yew may find it worthy to visit my github here [ayushjayaswal.xyz/github](https://ayushjayaswal.xyz/github).

# Git
Git is **The stupid content tracker**; is how the manual describes it. Anyhu. I'll let the manual define itself for you.
![git meme](https://felipec.wordpress.com/wp-content/uploads/2021/05/man_hack.jpg)

## Git Workflow
Basically, following is how you use git.
<br>
<br>
 You Initialize your Repository (or just clone)
<br>
<br>
 You Create your branch. main will be default or whatever you'd like to call it.
<br>
<br>
 Do your work; make changes; save them files. Then you STAGE them.
<br>
<br>
 STAGED files will be commited and only them.
<br>
<br>
 Then push to remote and your commits will arrive
<br>
<br>
![git workflow](https://git-scm.com/images/about/index1@2x.png)
<br>
<br>

## What is a Repository?

Your Project; is practically a directory has other directories and files in it.

## What is Staging?

Being Staged means this is ready to be committed and only this is ready to be commited not others(the non-staged)

## What is a Commit?

A Checkpoint; will have an id; you go back to this commit via its id; will have its authors too, yew may blame em.
Much like the many _Save Games_ you did in *GTA San Andreas*.

![GTA meme](https://cdn.gracza.pl/gallery/html/article/530336671.jpg)
## What is a Remote?
It’s your repo’s online twin; sitting on GitHub, GitLab, or Codeberg; where your code goes to socialize, show off, or get reviewed and roasted by ur crush.

## What is a Branch pointer?
Branch Pointer shows the latest commit of that branch; the commit you are on will have HEAD in bold and some color(maybe).
![head](https://acompiler.com//wp-content/uploads/2021/01/git-log-command-to-see-branch-HEAD.png)


# How to add SSH
You'll mostly push via ssh so this is almost always the way, [this should help](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) or just keep reading.
<br>
<br>
Generate an SSH key

```
ssh-keygen -t ed25519 -C "yourmail"
```
Creates a key pair (id_ed25519 & id_ed25519.pub). in your *.ssh*
<br>
<br>
Start the SSH agent

```
eval "$(ssh-agent -s)"
```
<br>
Add your key to the agent

```
ssh-add ~/.ssh/id_ed25519
```
<br>
Copy the public key (id_ed25519.pub)

<br>
<br>
Add it to your Git platform (GitHub, GitLab, etc.)
Usually in Settings → SSH and GPG keys → Add new key
<br>

# The How-to-git

## Initialize repo
Start tracking your project with Git. Like hitting “record” for your whatever. Nothing's actually tracked for now, that requires you telling git to start tracking.
```
git init
```
this will crate a **.git** directory; this contains all your git. Dont delete it (or maybe do).
## Clone a repo
Grab an existing project from the internet to your machine. use HTTPS or SSH whatever meets your ability ^.^
```
git clone <HTTPS|SSH>
```

## Connect to a remote
Link your local repo to a remote one (like on GitHub | Gitlab | Codeberg). Now you can push and pull or do whatever. Nowadays, the url should always be SSH
U'll choose different remote names for different web platforms like say origin for github; virgin for gitlab and so on.
```
git remote add origin(or whatever name you choose) <ssh url>
```
following will list all remotes you have
```
git remote -v
```

## Pull latest changes
Bring in updates from the remote repo so you’re up to date. Remember not to have something that conflicts with remote, for then u'll always endup with red errors not knowing what to do.
```
git pull
```

## Check status
See what’s changed, what’s staged, and what’s not.
```
git status
```

## Watch Create & switch branch
Make your own workspace to mess around without breaking main. Whatever shenanigans you do to a branch is unique to that branch only, that is unless you create its children or merge with parents.
```
git checkout -b <branch> # move to another branch
git branch  # see them branches
```

## Stage changes
Tell Git which files you want to include in the next commit. the '**.**' should usually capture everything in working directory; except for them mentioned in *.gitignore*
```
git add <file_name_1,file_name_2, ...>
```

## Commit Changes
You must commit or tis for nothing. good commits always have noice message :)
```
git commit -m "my ex used to question my commit-ment, but boy do I givafuk"
```

## Check commit history
gottabe some history between us ^o^
```
git log
```
## Diffs
Sometimes yew may want to see what changed here's how u do it.
```
git diff          # changes not staged
git diff --staged # changes staged for commit
```

## Need to Go back?
Now you dumdums would surely fukup; so here's a tip to go to a previous commit_id as mentioned by *git log*

### Git Restore
Undo changes in your working directory (stuff you haven’t committed yet). Should only affect your local wont touch commits
```
git restore ur_fkdup_file
```
or unstage something yew staged
```
git restore --staged <file>
```

### Git Revert
Makes a new commit that undoes the changes from a specific olden commit. When you’ve already pushed commits and want to safely undo something without breaking history.
```
git revert 3a6f9e2
```

### Git Reset
Moves your branch pointer to a specific commit (like rewinding your timeline). Can delete commits if you use *--hard*.  Ofc, If you're going hard you MUST KNOW WHAT YOU'RE DOING.
```
git reset --hard 3a6f9e2
```
## Delete Branch
delete branch ofc,
```
git branch -d <branch>
```
on the remote too
```
git push origin --delete <branch>
```

## Merger
Merge branches. yes.
```
git merge <branch>
```
your current branch will join the branch yew mention.

## On GitIgnore
Here, mention what you gotta hide from git, for example builds, envs, logs etc. This would be **.gitignore** file in the repository root.


# On signed Commits
Its professional to have have your commits signed; these will appear as verified on github etc.
I didnt do this for a long time and had to take a thrashing at work for this. Would save you the embarrasment if you do this already.
Traditionally this is via GPG but we'll do SSH for no reason but the aesthetics of it.
<br>
<br>
Make sure you have an SSH key

```
ls ~/.ssh/id_ed25519
```

If you don’t have one:
```
ssh-keygen -t ed25519 -C "your_email@example.com"
```
<br>
Register your SSH key on GitHub

Go to GitHub → Settings → SSH and GPG keys → New SSH key

Paste the public key (~/.ssh/id_ed25519.pub) there and set key type to Signing Key.

This is what GitHub uses to verify your signed commits.
<br>
<br>
Tell Git to use SSH for signing
```
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

# That's it!
That's 90% of what you'll ever need. So be good and learn em. Whatever slop you create with them GPTs, do have it controlled by git so you have some chance of a making somthing of worth.
<br>
<br>
<br>
best,

/porceylain.
