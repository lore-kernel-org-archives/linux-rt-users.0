From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 6/6] Create an rt-tests.tar file using git-archive
Date: Tue, 14 Jul 2015 22:28:58 +0200 (CEST)
Message-ID: <alpine.LFD.2.11.1507142226300.14459@riemann>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com> <1436531131-9186-7-git-send-email-jkacur@redhat.com> <20150714161324.GG21820@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f65.google.com ([74.125.82.65]:36731 "EHLO
	mail-wg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbGNU3H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 16:29:07 -0400
Received: by wgbbj7 with SMTP id bj7so1651146wgb.3
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2015 13:29:06 -0700 (PDT)
In-Reply-To: <20150714161324.GG21820@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 14 Jul 2015, Sebastian Andrzej Siewior wrote:

> * John Kacur | 2015-07-10 14:25:31 [+0200]:
> 
> >diff --git a/Makefile b/Makefile
> >index 1f7640b82fa6..07394e1292f7 100644
> >--- a/Makefile
> >+++ b/Makefile
> >@@ -165,6 +166,10 @@ release: distclean changelog
> > 	rm -f ChangeLog
> > 	cp rt-tests-$(VERSION).tar.gz rt-tests-$(VERSION).tar.asc releases
> > 
> >+.PHONY: tarball
> >+tarball:
> >+	git archive --worktree-attributes --prefix=rt-tests-${VERSION}/ -o rt-tests-${VERSION}.tar v${VERSION}
> 
> Okay. So this looks like the release target could go :)
> 
> > .PHONY: push
> > push:	release
> > 	scripts/do-git-push $(VERSION)
> 

Right, like I said in Patch [0/6] - I'm planning on ripping everything out 
that is for maintainence purposes, and either doing without it, or at 
least putting it in the scripts dir, I don't think it should be in the 
standard Makefile, but doing it in some baby steps, not making Clark quit 
cold turkey. :)

John
