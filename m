From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Fri, 13 Jul 2007 22:52:55 +1000
Message-ID: <1184331176.6059.225.camel@localhost.localdomain>
References: <46961E080200005A000276AE@mcclure.wal.novell.com>
	 <20070712163341.GA9622@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, jim.houston@ccur.com,
	joe.korty@ccur.com, rostedt@goodmis.org, tglx@linutronix.de,
	dwalker@mvista.com, David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	williams@redhat.com, abogani@texware.it,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58738 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757510AbXGMMyp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 08:54:45 -0400
In-Reply-To: <20070712163341.GA9622@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-12 at 18:33 +0200, Ingo Molnar wrote:
> * Gregory Haskins <ghaskins@novell.com> wrote:
> 
> >   For the most part, it seems you guys have resolved most of the 
> > issues that we ran into as well (e.g. early-flush-tlb, relocated 
> > die-notifier, etc, come to mind).  I found one patch that was missing 
> > that allows debug configurations to build properly.  Heres that patch:
> > 
> > --- linux-2.6.21.orig/kernel/latency_trace.c
> > +++ linux-2.6.21/kernel/latency_trace.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/utsrelease.h>
> >  #include <asm/uaccess.h>
> >  #include <asm/unistd.h>
> > +#include <asm/asm-offsets.h>
> 
> i think this breaks PPC (which has no asm-offsets.h file). In any case i 
> saw this build breakage too and the fix is in -rt2.

Nah, ppc and powerpc both have asm-offset.h

Cheers,
Ben.
