From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt-tester testcase t4-l2-pi-deboost.tst failed
Date: Wed, 27 Feb 2013 23:16:59 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302272315460.22263@ionos>
References: <512E5D41.3000103@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Yao Zhao <yao.zhao@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60235 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab3B0WRC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Feb 2013 17:17:02 -0500
In-Reply-To: <512E5D41.3000103@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 27 Feb 2013, Yao Zhao wrote:

> Hi,
> 
> I tested rt-tester with mainline 3.8.0 kernel and
> the kernel scripts/rt-tester/t4-l2-pi-deboost.tst failed at
> 
> # Verify prio of T0 (still pending owner,
> # but T2 is enqueued due to the previous boost by T3
> T: prioeq:              0:      82
> 
> The current T0's prio is -21 so it failed.
> 
> Reading source code, it should be 82 as T2 is at prio 82 and
> T0 owns the L1 and T2 is waiting for the L1.
> 
> Can I ask
> 1.is the rt-tester test only for preempt-rt kernel?

No

> 2.any idea why it failed?

No

It would be nice if you could figure out whether that's a failure of
the test case or a failure in the kernel.

Thanks

	tglx
