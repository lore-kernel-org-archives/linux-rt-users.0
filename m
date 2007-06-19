From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] Don't call mcount from vsyscall_fn's
Date: Tue, 19 Jun 2007 10:41:16 +0200
Message-ID: <20070619084116.GA1663@elte.hu>
References: <1182220869.15228.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46080 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbXFSIlZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jun 2007 04:41:25 -0400
Content-Disposition: inline
In-Reply-To: <1182220869.15228.10.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> This bit me in the butt.
> 
> I couldn't understand why my init app was segfaulting, with a kernel 
> address, but a user RIP and RSP.  Well, the RIP I think was bogus, but 
> the kernel address was always the start of "mcount".  Looking deeper, 
> I printed out what was in the RSP (even though it was a user stack).  
> It ended up showing me that the calling address was from the VDSO 
> area. Looking even further, I found the offending culprit, which was 
> vread_hpet.
> 
> Looking at the assembly dump, I saw the vread_hpet was calling mcount, 
> but I could not see it in the code. Nor could I see it in hpet.i (-E 
> option of compiling).
> 
> Well, I guess Ingo is a magician when it comes to compiler tricks, and 
> has the mcount being called by "every!!" function, unless you add the 
> "notrace" option.
> 
> This patch adds the notrace to vsyscall_fn, so that we don't have user 
> land apps calling mcount and crashing!

doh - applied. Thanks!

	Ingo
