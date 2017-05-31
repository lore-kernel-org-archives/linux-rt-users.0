From: John Kacur <jkacur@redhat.com>
Subject: Re: Where are the branches for stable/v1.0 and unstable/devel?
Date: Wed, 31 May 2017 16:48:16 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705311645190.6177@riemann>
References: <trinity-81b115be-c7aa-430f-a6bb-a9f8512e0222-1495478595984@3capp-webde-bap56> <1495483301.9833.3.camel@intel.com> <trinity-363cee20-7cf0-4d43-b5d7-058ae3582716-1495921425917@3capp-webde-bs06>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463806030-687213954-1496242110=:6177"
Cc: linux-rt-users@vger.kernel.org
To: rolf.freitag@email.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34488 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdEaOsd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 May 2017 10:48:33 -0400
Received: by mail-wm0-f44.google.com with SMTP id 123so34503461wmg.1
        for <linux-rt-users@vger.kernel.org>; Wed, 31 May 2017 07:48:32 -0700 (PDT)
In-Reply-To: <trinity-363cee20-7cf0-4d43-b5d7-058ae3582716-1495921425917@3capp-webde-bs06>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806030-687213954-1496242110=:6177
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 27 May 2017, rolf.freitag@email.de wrote:

> Hi Vedang, 
> 
> On Mon, 2017-05-22 at 20:43 +0200, vedang.patel@intel.com wrote:
> > ...
> > The following 2 branches in the above repository have been most
> > recently updated and correspond to the stable and unstable branch: 
> > 0e6c2ca28adbaeb668ca35210cec546f89938bfa        refs/heads/stable/devel
> > /v1.0.1
> > 44de1a494583c33e72335221360085f9e1faad2b        refs/heads/unstable/dev
> > el/v1.1.1
> > There is also a stable/v1.0 branch: 
> > d48504b8e85961afab1cb0bd346624eb31527197        refs/heads/stable/v1.0
> > 
> > the wiki page you mentioned in your email is outdated. Please refer to 
> > https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyc[https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyc]
> > lictest for the latest info.
> 
> Ok, due to https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/rt-tests
> i can get the stable/v1.0 via:
> 
> # git clone git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git 
> # cd rt-tests
> # git checkout stable/v1.0
> 
> But when i try it with the other two versions,
> 
> git checkout stable/devel
> git checkout unstable/dev
> 
> i get no checkout and an error:
> 
> error: pathspec 'stable' did not match any file(s) known to git.
> 
> Regards,
> 
> Rolf

Here is how (one way) to check out the stable and the unstable
branches.

git clone git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
Cloning into 'rt-tests'...
remote: Counting objects: 2914, done.
remote: Total 2914 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (2914/2914), 554.11 KiB | 513.00 KiB/s, done.
Resolving deltas: 100% (1760/1760), done.
Checking connectivity... done.
[jkacur@riemann tmp]$ cd rt-tests/
[jkacur@riemann rt-tests]$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/devel/v0.96
  remotes/origin/devel/v0.96-spikes
  remotes/origin/devel/v0.97
  remotes/origin/devel/v0.98
  remotes/origin/master
  remotes/origin/stable/devel/v1.0.1
  remotes/origin/stable/v1.0
  remotes/origin/unstable/devel/v1.1.1
  remotes/origin/v0.93-devel
  remotes/origin/v0.94-devel
[jkacur@riemann rt-tests]$ git checkout -b stable/v1.0 origin/stable/v1.0
Branch stable/v1.0 set up to track remote branch stable/v1.0 from origin.
Switched to a new branch 'stable/v1.0'
[jkacur@riemann rt-tests]$ git checkout -b unstable/devel/v1.1.1 
origin/unstable/devel/v1.1.1
Branch unstable/devel/v1.1.1 set up to track remote branch 
unstable/devel/v1.1.1 from origin.
Switched to a new branch 'unstable/devel/v1.1.1'
---1463806030-687213954-1496242110=:6177--
