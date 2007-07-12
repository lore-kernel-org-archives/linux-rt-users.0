From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Thu, 12 Jul 2007 18:33:41 +0200
Message-ID: <20070712163341.GA9622@elte.hu>
References: <46961E080200005A000276AE@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jim.houston@ccur.com, joe.korty@ccur.com, rostedt@goodmis.org,
	tglx@linutronix.de, dwalker@mvista.com,
	David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	williams@redhat.com, abogani@texware.it,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:36246 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763981AbXGLQfM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 12:35:12 -0400
Content-Disposition: inline
In-Reply-To: <46961E080200005A000276AE@mcclure.wal.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Gregory Haskins <ghaskins@novell.com> wrote:

>   For the most part, it seems you guys have resolved most of the 
> issues that we ran into as well (e.g. early-flush-tlb, relocated 
> die-notifier, etc, come to mind).  I found one patch that was missing 
> that allows debug configurations to build properly.  Heres that patch:
> 
> --- linux-2.6.21.orig/kernel/latency_trace.c
> +++ linux-2.6.21/kernel/latency_trace.c
> @@ -24,6 +24,7 @@
>  #include <linux/utsrelease.h>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
> +#include <asm/asm-offsets.h>

i think this breaks PPC (which has no asm-offsets.h file). In any case i 
saw this build breakage too and the fix is in -rt2.

> We did find a regression.  I was mistaken earlier when I mentioned our 
> T60p laptops couldn't boot.  It turns out that issue was resolved 
> somewhere along the way and our published patches based on 21.5-rt19 
> do allow the laptop to boot event with acpi=on.  With 22.1-rt1 the 
> laptop crashes unless acpi=off.  Now that we have your queue we will 
> bisect this and post that fix as well.

ok. Make sure you check rt2 as well - and note that it's not fully 
bisectable with PREEMPT_RT enabled (but should probably be fully 
bisectable with PREEMPT_RT disabled). So check out first whether the 
problem still persists with PREEMPT_RT disabled.

	Ingo
