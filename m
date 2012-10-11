From: Mike Galbraith <efault@gmx.de>
Subject: Re: Crap, ksoftirqd/0 looping forever in softirq
Date: Thu, 11 Oct 2012 04:38:33 +0200
Message-ID: <1349923113.6989.14.camel@marge.simpson.net>
References: <20121011001637.GA18628@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:36375 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932159Ab2JKCii (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Oct 2012 22:38:38 -0400
In-Reply-To: <20121011001637.GA18628@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-10-10 at 20:16 -0400, Paul Gortmaker wrote: 
> Seeing the above message, I added a trivial change to print out the
> Mask and Pending, and I consistently saw it was (both p/m) in every
> case `was __IRQF_TIMER (0x200).
> 
> Looking at do_current_softirqs, it seems that it implicitly expects
> two entrance paths:
> 
>    /*
>     * Called with interrupts disabled. Process softirqs which were raised
>     * in current context (or on behalf of ksoftirqd).
>     */
>    static void do_current_softirqs(int need_rcu_bh_qs)
> 
> In there, we loop on current->softirqs_raised, but there is no "filter"
> for the case where we spawn from ksoftirqd with __IRQF_TIMER, or more
> specifically IRQF_NO_THREAD.  Asking ksoftirqd to handle IRQF_NO_THREAD?
> 
> So based on my dain-bramaged and limited understanding, it seems that
> we are waiting on completion from ksoftirqd on something that we've
> asked to be not run from a thread.  I'd propose a patch but I'd probably
> only manage to hurt myself, so I'll stop at reporting the above data,
> and leave it to the folks more in the know to suggest a proper fix...

FWIW, I saw the same trying to get rt1 running an my 64 core test box.
Box has other seemingly unrelated issues, so haven't poked at it yet,
only saw it say oh crap while fighting for its life (R.I.Pieces).

-Mike

