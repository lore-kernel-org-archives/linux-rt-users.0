From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 4/6] Add .tar files to .gitignore
Date: Tue, 14 Jul 2015 22:33:13 +0200 (CEST)
Message-ID: <alpine.LFD.2.11.1507142230301.14459@riemann>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com> <1436531131-9186-5-git-send-email-jkacur@redhat.com> <20150714155830.GD21820@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f65.google.com ([74.125.82.65]:35504 "EHLO
	mail-wg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbGNUdO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 16:33:14 -0400
Received: by wgkl9 with SMTP id l9so1654352wgk.2
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2015 13:33:13 -0700 (PDT)
In-Reply-To: <20150714155830.GD21820@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 14 Jul 2015, Sebastian Andrzej Siewior wrote:

> * John Kacur | 2015-07-10 14:25:29 [+0200]:
> 
> >Ignore .tar files too
> >
> >Signed-off-by: John Kacur <jkacur@redhat.com>
> >---
> > .gitignore | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/.gitignore b/.gitignore
> >index 1924e73bef67..ceee8bfb6e9a 100644
> >--- a/.gitignore
> >+++ b/.gitignore
> >@@ -2,6 +2,7 @@
> > .*
> > *.o
> > *.tar.gz
> >+*.tar
> > *.d
> > *.patch
> > *.a
> 
> Wouldn't it make sense to remove *.tar* and *patch from that list?
> After all if "git status" shows you that those exists then step two
> should be remove them, right? Why would you want to them around?
> 

I don't know, I suppose it's a matter of taste, but there are a lot of 
legitimate reasons to have *.tar and *.patch files in your local repo, 
that you might not want to see in via git-status. This is pretty standard 
practice, the Linux kernel has these in .gitignore too, so I'm going to 
keep them in the list.

Cheers!

John
