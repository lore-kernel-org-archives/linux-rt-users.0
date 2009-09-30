From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Problem with 2.6.31-rt11 + iptables on shutdown
Date: Wed, 30 Sep 2009 15:42:52 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909301542000.2518@nanos>
References: <20090930131054.GM3466@uudg.org> <alpine.LFD.2.00.0909301513230.2518@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42956 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbZI3Nm5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Sep 2009 09:42:57 -0400
In-Reply-To: <alpine.LFD.2.00.0909301513230.2518@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 30 Sep 2009, Thomas Gleixner wrote:

> On Wed, 30 Sep 2009, Luis Claudio R. Goncalves wrote:
> 
> > Hello,
> > 
> > This is apparently a new manifestation of the same issue I have been chasing
> > for quite a while and have been failing in a very shameful way to fix. In
> > the original issue, whenever I run deluge (bit torrent client) at
> > SCHED_FIFO, I got the error message below and system would freeze / panic
> > during shutdown:
> > 
> >   ================================================
> >   [ BUG: lock held when returning to user space! ]
> >   ------------------------------------------------
> >   deluged/3035 is leaving the kernel with locks still held!
> >   1 lock held by deluged/3035:
> >    #0:  (&lock->lock){......}, at: [<ffffffffa02ae965>] ipt_do_table+0x10c/0x5f3 [ip_tables]
> 
> Yikes. Can you please decode the code line for ffffffffa02ae965 ? Does
> the bug happen with function tracer enabled ? If yes, enable
> ftrace_dump_on_oops hook up a serial console and capture the dump.

I'm quite sure that I know what breaks. Working on a fix.

Thanks,

	tglx
