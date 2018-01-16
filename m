From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v4.14.12-rt10
Date: Tue, 16 Jan 2018 07:35:31 -0500
Message-ID: <201801160735.31931.gheskett@shentel.net>
References: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de> <201801152227.58933.gheskett@shentel.net> <20180116081614.106781c2@archlinux.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda1.shentel.net ([204.111.1.144]:27593 "EHLO
        barracuda3.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751996AbeAPMfi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jan 2018 07:35:38 -0500
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda3.shentel.net with ESMTP id bycRMHWZ6m0RQdXU for <linux-rt-users@vger.kernel.org>; Tue, 16 Jan 2018 07:35:23 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 3FB5922730
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jan 2018 07:35:23 -0500 (EST)
In-Reply-To: <20180116081614.106781c2@archlinux.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 16 January 2018 02:16:14 Ralf Mardorf wrote:

> On Mon, 15 Jan 2018 22:27:58 -0500, Gene Heskett wrote:
> >rock64@rock64:/media/slash/home/rock64/Downloads$
> >git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> >v4.14.12-rt10
> >
> >-bash:
> >git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git:
> >No such file or directory
> >
> >The git installed is: 2.11.0 if thats a clue.
>
> Hi,
>
> I'm not an advanced git user, but shouldn't you use a command instead
> of just an URL?
>
> [rocketmouse@archlinux .tmp]$ git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> Cloning into 'linux-rt-devel'...
> remote: Counting objects: 6197952, done.
> remote: Compressing objects: 100% (944316/944316), done.
> remote: Total 6197952 (delta 5210675), reused 6196073 (delta 5209729)
> Receiving objects: 100% (6197952/6197952), 1.11 GiB | 708.00 KiB/s,
> done. Resolving deltas: 100% (5210675/5210675), done.
> [rocketmouse@archlinux .tmp]$
> [rocketmouse@archlinux .tmp]$
> [rocketmouse@archlinux .tmp]$
> [rocketmouse@archlinux .tmp]$
> [rocketmouse@archlinux .tmp]$ cd linux-rt-devel/
> [rocketmouse@archlinux linux-rt-devel]$
> [rocketmouse@archlinux linux-rt-devel]$
> [rocketmouse@archlinux linux-rt-devel]$
> [rocketmouse@archlinux linux-rt-devel]$
> [rocketmouse@archlinux linux-rt-devel]$ git branch
> * master
> [rocketmouse@archlinux linux-rt-devel]$ git describe --tags $(git
> rev-list --tags --max-count=10) v4.14.12-rt10-patches
> v4.14.12-rt10
> v4.14.12-405-g5536f5491a2e
> v4.14.12-rt10-rebase
> v4.14.12-380-g038ecb81aa81
> v4.14.12-379-gca6de2d16341
> v4.14.12-378-g278da228d04c
> v4.14.12-377-g85db952da1f4
> v4.14.12-376-g0cc094ba4d14
> v4.14.12-375-g54a259a815f7
> [rocketmouse@archlinux linux-rt-devel]$ git checkout v4.14.12-rt10
> Note: checking out 'v4.14.12-rt10'.
>
> You are in 'detached HEAD' state. You can look around, make
> experimental changes and commit them, and you can discard any commits
> you make in this state without impacting any branches by performing
> another checkout.
>
> If you want to create a new branch to retain commits you create, you
> may do so (now or later) by using -b with the checkout command again.
> Example:
>
>   git checkout -b <new-branch-name>
>
> HEAD is now at df269158d3f0... v4.14.12-rt10
> [rocketmouse@archlinux linux-rt-devel]$ git branch
> * (HEAD detached at v4.14.12-rt10)
>   master
> [rocketmouse@archlinux linux-rt-devel]$ git checkout master
> Previous HEAD position was df269158d3f0... v4.14.12-rt10
> Switched to branch 'master'
> Your branch is up to date with 'origin/master'.
> [rocketmouse@archlinux linux-rt-devel]$ git describe
> v4.14
> [rocketmouse@archlinux linux-rt-devel]$ git remote update
> Fetching origin
> [rocketmouse@archlinux linux-rt-devel]$ git pull --all
> Fetching origin
> Already up to date.
>
> Regards,
> Ralf

All of which makes sense, so I'll give it a shot after the morning coffee 
has kicked in.

Thanks Ralf.
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers, Gene Heskett
The above content, added by Maurice E. Heskett, is Copyright 2018 by 
Maurice E. Heskett.
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
