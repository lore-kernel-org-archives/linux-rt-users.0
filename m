From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Problem with 2.6.31-rt11 + iptables on shutdown
Date: Wed, 30 Sep 2009 11:02:55 -0300
Message-ID: <20090930140255.GO3466@uudg.org>
References: <20090930131054.GM3466@uudg.org> <alpine.LFD.2.00.0909301513230.2518@nanos> <alpine.LFD.2.00.0909301542000.2518@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:31884 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbZI3OCt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Sep 2009 10:02:49 -0400
Received: by fg-out-1718.google.com with SMTP id 22so2113048fge.1
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Sep 2009 07:02:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0909301542000.2518@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 30, 2009 at 03:42:52PM +0200, Thomas Gleixner wrote:
| On Wed, 30 Sep 2009, Thomas Gleixner wrote:
| 
| > On Wed, 30 Sep 2009, Luis Claudio R. Goncalves wrote:
| > 
| > > Hello,
| > > 
| > > This is apparently a new manifestation of the same issue I have been chasing
| > > for quite a while and have been failing in a very shameful way to fix. In
| > > the original issue, whenever I run deluge (bit torrent client) at
| > > SCHED_FIFO, I got the error message below and system would freeze / panic
| > > during shutdown:
| > > 
| > >   ================================================
| > >   [ BUG: lock held when returning to user space! ]
| > >   ------------------------------------------------
| > >   deluged/3035 is leaving the kernel with locks still held!
| > >   1 lock held by deluged/3035:
| > >    #0:  (&lock->lock){......}, at: [<ffffffffa02ae965>] ipt_do_table+0x10c/0x5f3 [ip_tables]
| > 
| > Yikes. Can you please decode the code line for ffffffffa02ae965 ? Does
| > the bug happen with function tracer enabled ? If yes, enable
| > ftrace_dump_on_oops hook up a serial console and capture the dump.
| 
| I'm quite sure that I know what breaks. Working on a fix.

I will get the ftrace data anyway. I tried at first converting xt_info_lock
to atomic_spin_lock but it lead to a bigger series of warnings :)

Thanks for looking at this issue!

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

