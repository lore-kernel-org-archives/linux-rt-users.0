From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 13:30:53 -0700
Message-ID: <1190061053.3615.53.camel@sven.thebigcorporation.com>
References: <200709172012.21102.ak@suse.de>
	 <1190056047.3253.104.camel@imap.mvista.com>
	 <1190057923.3615.26.camel@sven.thebigcorporation.com>
	 <200709172220.43871.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Walker <dwalker@mvista.com>, mingo@elte.hu,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:53904 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbXIQUbD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 16:31:03 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2845347mue
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Sep 2007 13:31:01 -0700 (PDT)
In-Reply-To: <200709172220.43871.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-09-17 at 22:20 +0200, Andi Kleen wrote:
> On Monday 17 September 2007 21:38, Sven-Thorsten Dietrich wrote:
> > On Mon, 2007-09-17 at 12:07 -0700, Daniel Walker wrote:
> > > On Mon, 2007-09-17 at 21:00 +0200, Andi Kleen wrote:
> > > > > Since it's all got "__" in the front, not good to use this method all
> > > > > over .. If you just need a real spinlock best to use
> > > > > DEFINE_RAW_SPINLOCK() unless your a special situation ..
> >
> > die_lock has been RAW for a while, see older patches...
> 
> It's definitely not in 2.6.23-rc4-rt1 and also wasn't in the oops
> trace I looked at.
> 
> > but DEFINE_RAW or DECLARE_RAW should be used when possible.
> 
> I disagree for the oops case.  You want the simplest possible code
> here.

Looks like its raw for all but the x* archs.

# grep die_lock *
preempt-realtime-arm.patch:-DEFINE_SPINLOCK(die_lock);
preempt-realtime-arm.patch:+DEFINE_RAW_SPINLOCK(die_lock);
preempt-realtime-mips.patch:-static DEFINE_SPINLOCK(die_lock);
preempt-realtime-mips.patch:+static DEFINE_RAW_SPINLOCK(die_lock);
preempt-realtime-powerpc.patch:-DEFINE_SPINLOCK(die_lock);
preempt-realtime-powerpc.patch:+DEFINE_RAW_SPINLOCK(die_lock);
preempt-realtime-sh.patch:-static DEFINE_SPINLOCK(die_lock);
preempt-realtime-sh.patch:+static DEFINE_RAW_SPINLOCK(die_lock);

Sven

> 
> -Andi
> 
