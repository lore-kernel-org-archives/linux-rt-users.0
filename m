From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3.0-rt1] ipc/mqueue: add a critical section to avoid a
 deadlock
Date: Sat, 23 Jul 2011 09:23:37 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107230923020.2702@ionos>
References: <4E2A38A0.1090601@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, dchinner@redhat.com, npiggin@kernel.dk,
	hch@lst.de, arnd@arndb.de
To: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52577 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1GWHXl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 03:23:41 -0400
In-Reply-To: <4E2A38A0.1090601@toshiba.co.jp>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 23 Jul 2011, KOBAYASHI Yoshitake wrote:

> (Repost for v3.0-rt1 and changed the distination addreses)
> I have tested the following patch on v3.0-rt1 with PREEMPT_RT_FULL.
> In POSIX message queue, if a sender process uses SCHED_FIFO and
> has a higher priority than a receiver process, the sender will
> be stuck at ipc/mqueue.c:452
> 
>   452                 while (ewp->state == STATE_PENDING)
>   453                         cpu_relax();
> 
> Description of the problem
>  (receiver process)
>    1. receiver changes sender's state to STATE_PENDING (mqueue.c:846)
>    2. wake up sender process and "switch to sender" (mqueue.c:847)
>       Note: This context switch only happens in PREEMPT_RT_FULL kernel.
>  (sender process)
>    3. sender check the own state in above loop (mqueue.c:452-453)
>    *. receiver will never wake up and cannot change sender's state to
>       STATE_READY because sender has higher priority

Good catch! Queued for -rt2.

Thanks,

	tglx
