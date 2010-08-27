From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Fri, 27 Aug 2010 12:33:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1008271227370.2768@localhost.localdomain>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com> <AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com> <AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: John Culvertson <jculvertson@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:54427 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab0H0Kdt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Aug 2010 06:33:49 -0400
In-Reply-To: <AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John,

On Wed, 11 Aug 2010, John Culvertson wrote:

> I updated to 2.6.33.7-rt29, and I am seeing similar symptoms.
> 
> [ 2120.781166] BUG: unable to handle kernel paging request at c11cd497
> [ 2120.784018] IP: [<c11d5ce2>] tcp_set_skb_tso_segs+0x33/0x85

can you please try to reproduce the problem with the function tracer
enabled ? Make sure that /proc/sys/kernel/ftrace_dump_on_oops is set
to 1.

When the bug reproduces the kernel will spill out the trace over the
serial console, which will take a while but should show us what's
going on.

Thanks,

	tglx
