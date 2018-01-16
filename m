From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: [ANNOUNCE] v4.14.12-rt10
Date: Tue, 16 Jan 2018 08:16:14 +0100
Message-ID: <20180116081614.106781c2@archlinux.localdomain>
References: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de>
        <201801152227.58933.gheskett@shentel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail150c50.megamailservers.eu ([91.136.10.160]:48340 "EHLO
        mail50c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750716AbeAPHQP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jan 2018 02:16:15 -0500
Received: from archlinux.localdomain (x4e32166e.dyn.telefonica.de [78.50.22.110])
        (authenticated bits=0)
        by mail50c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id w0G7GB7w023213
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jan 2018 07:16:13 +0000
In-Reply-To: <201801152227.58933.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 15 Jan 2018 22:27:58 -0500, Gene Heskett wrote:
>rock64@rock64:/media/slash/home/rock64/Downloads$ 
>git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git 
>v4.14.12-rt10
>
>-bash: 
>git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git:
>No such file or directory
>
>The git installed is: 2.11.0 if thats a clue.

Hi,

I'm not an advanced git user, but shouldn't you use a command instead of just an URL?

[rocketmouse@archlinux .tmp]$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
Cloning into 'linux-rt-devel'...
remote: Counting objects: 6197952, done.
remote: Compressing objects: 100% (944316/944316), done.
remote: Total 6197952 (delta 5210675), reused 6196073 (delta 5209729)
Receiving objects: 100% (6197952/6197952), 1.11 GiB | 708.00 KiB/s, done.
Resolving deltas: 100% (5210675/5210675), done.
[rocketmouse@archlinux .tmp]$ 
[rocketmouse@archlinux .tmp]$ 
[rocketmouse@archlinux .tmp]$ 
[rocketmouse@archlinux .tmp]$ 
[rocketmouse@archlinux .tmp]$ cd linux-rt-devel/
[rocketmouse@archlinux linux-rt-devel]$ 
[rocketmouse@archlinux linux-rt-devel]$ 
[rocketmouse@archlinux linux-rt-devel]$ 
[rocketmouse@archlinux linux-rt-devel]$ 
[rocketmouse@archlinux linux-rt-devel]$ git branch
* master
[rocketmouse@archlinux linux-rt-devel]$ git describe --tags $(git rev-list --tags --max-count=10)
v4.14.12-rt10-patches
v4.14.12-rt10
v4.14.12-405-g5536f5491a2e
v4.14.12-rt10-rebase
v4.14.12-380-g038ecb81aa81
v4.14.12-379-gca6de2d16341
v4.14.12-378-g278da228d04c
v4.14.12-377-g85db952da1f4
v4.14.12-376-g0cc094ba4d14
v4.14.12-375-g54a259a815f7
[rocketmouse@archlinux linux-rt-devel]$ git checkout v4.14.12-rt10
Note: checking out 'v4.14.12-rt10'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at df269158d3f0... v4.14.12-rt10
[rocketmouse@archlinux linux-rt-devel]$ git branch
* (HEAD detached at v4.14.12-rt10)
  master
[rocketmouse@archlinux linux-rt-devel]$ git checkout master
Previous HEAD position was df269158d3f0... v4.14.12-rt10
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
[rocketmouse@archlinux linux-rt-devel]$ git describe
v4.14
[rocketmouse@archlinux linux-rt-devel]$ git remote update
Fetching origin
[rocketmouse@archlinux linux-rt-devel]$ git pull --all
Fetching origin
Already up to date.

Regards,
Ralf
