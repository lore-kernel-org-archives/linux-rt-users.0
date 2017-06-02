From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Where are the branches for stable/v1.0 and unstable/devel?
Date: Fri, 2 Jun 2017 10:42:27 +0200
Message-ID: <20170602084227.7pdrv4g5mcy4palz@linutronix.de>
References: <trinity-81b115be-c7aa-430f-a6bb-a9f8512e0222-1495478595984@3capp-webde-bap56>
 <1495483301.9833.3.camel@intel.com>
 <trinity-363cee20-7cf0-4d43-b5d7-058ae3582716-1495921425917@3capp-webde-bs06>
 <alpine.LFD.2.20.1705311645190.6177@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rolf.freitag@email.de, linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdFBIma (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2017 04:42:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1705311645190.6177@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-05-31 16:48:16 [+0200], John Kacur wrote:
> Here is how (one way) to check out the stable and the unstable
> branches.
> 
> git clone git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
> Cloning into 'rt-tests'...
> remote: Counting objects: 2914, done.
> remote: Total 2914 (delta 0), reused 0 (delta 0)
> Receiving objects: 100% (2914/2914), 554.11 KiB | 513.00 KiB/s, done.
> Resolving deltas: 100% (1760/1760), done.
> Checking connectivity... done.
> [jkacur@riemann tmp]$ cd rt-tests/
> [jkacur@riemann rt-tests]$ git branch -a
> * master
>   remotes/origin/HEAD -> origin/master
>   remotes/origin/devel/v0.96
>   remotes/origin/devel/v0.96-spikes
>   remotes/origin/devel/v0.97
>   remotes/origin/devel/v0.98
>   remotes/origin/master
>   remotes/origin/stable/devel/v1.0.1
>   remotes/origin/stable/v1.0
>   remotes/origin/unstable/devel/v1.1.1
>   remotes/origin/v0.93-devel
>   remotes/origin/v0.94-devel
> [jkacur@riemann rt-tests]$ git checkout -b stable/v1.0 origin/stable/v1.0
> Branch stable/v1.0 set up to track remote branch stable/v1.0 from origin.
> Switched to a new branch 'stable/v1.0'
> [jkacur@riemann rt-tests]$ git checkout -b unstable/devel/v1.1.1 
> origin/unstable/devel/v1.1.1
> Branch unstable/devel/v1.1.1 set up to track remote branch 
> unstable/devel/v1.1.1 from origin.
> Switched to a new branch 'unstable/devel/v1.1.1'

right, plain and simple. With the right interface you could point users
to your devel or stable branch with something like

	git symbolic-ref HEAD refs/heads/stable/v1.0

But since there a Readme file, could you add something like

For the stable branch branch please do
	git checkout stable/v1.0

and development do
	git checkout unstable/devel/v1.1.1

Sebastian
