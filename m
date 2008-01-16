From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt2
Date: Wed, 16 Jan 2008 09:12:05 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801160904200.9544@gandalf.stny.rr.com>
References: <1200336080.318.8.camel@localhost.localdomain>
 <200801150237.44029.caglar@pardus.org.tr> <24149.1200455417@turing-police.cc.vt.edu>
            <Pine.LNX.4.58.0801152302580.10869@gandalf.stny.rr.com>
 <31516.1200464589@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: caglar@pardus.org.tr, LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:62496 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbYAPOMv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 09:12:51 -0500
In-Reply-To: <31516.1200464589@turing-police.cc.vt.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> > > On Tue, 15 Jan 2008 02:37:37 +0200, =?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur said:
> > > > And because of mcount-add-basic-support-for-gcc-profiler-instrum.patch, closed
> > > > source nvidia-new module cannot be used with this release (mcount is exported
> > > > GPL only), i know this is not supported but i used it with that [2] patch up
> > > > until now without a single problem.
> > >
> > > Playing devil's advocate here - the claim is that EXPORT_SYMBOL_GPL is to
> > > indicate that code is getting too chummy with Linux internals.
> > >
> > > However, in *this* case, isn't it "code that is too chummy with *GCC* internals",
> > > and thus it isn't our place to say what can and can't be done with code that
> > > is derivative of the GCC compiler? ;)
> >
> > Actually, it got put in there by accident. I usually default all my
> > exports as GPL.  But this breaks pretty much everything, so I'll leave it
> > as EXPORT_SYMBOL.
>
> OK, I can live with that. ;)
>

We modified mcount now, and it is derived from an objdump of glibc. So
this is most definitely a "derived" work from glibc. But glibc is licensed
as LGPL, which IIRC allows for non GPL to link to it.

I personally could care less if we use EXPORT_SYMBOL or EXPORT_SYMBOL_GPL.
But I really want to do The Right Thing(tm). I'm not a lawyer and don't
claim that I know anything about the law, but I'm leaning towards the non
_GPL version because the code was from LGPL and not from strict GPL.

-- Steve
