From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt4
Date: Thu, 28 Jul 2011 10:06:26 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107280945080.2660@ionos>
References: <alpine.LFD.2.02.1107272222420.2660@ionos> <201107281133.09107@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	lasaine@lvk.cs.msu.su
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33150 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab1G1IGd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 04:06:33 -0400
In-Reply-To: <201107281133.09107@zigzag.lvk.cs.msu.su>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 28 Jul 2011, Nikita V. Youshchenko wrote:

> > The list of disabled config option is now:
> >
> >  - CONFIG_HIGHMEM [ see the mess it created in 33-rt ]
> 
> Could someone please point me to information on this?
> 
> In our setup, we do use PREEMPT_RT + HIGHMEM, on .33 for now (but want to 
> upgrade because of new hardware support issues with .33).  Up to now, we 
> did not face any issues related to PREEMPT_RT + HIGHMEM combination.

Yes, it works in 33-rt, but the way it's implemented is a horrible
hack. I had not enough capacity to implement that cleanly for 3.0-rt,
so I simply dropped it for now. The preliminary patches are there
(mainly distangling the disable_pagefault logic), so it should not be
that hard.

Thanks,

	tglx
