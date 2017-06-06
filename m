From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] sched: Prevent task state corruption by spurious lock
 wakeup
Date: Tue, 6 Jun 2017 14:16:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706061412290.1885@nanos>
References: <alpine.DEB.2.20.1706021834070.1899@nanos> <alpine.DEB.2.20.1706030940220.2228@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathias Koehrer <mathias.koehrer@etas.com>,
        David Hauck <davidh@netacquire.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdFFMQo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Jun 2017 08:16:44 -0400
In-Reply-To: <alpine.DEB.2.20.1706030940220.2228@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 3 Jun 2017, Thomas Gleixner wrote:
> If the to be woken task has state TASK_TRACED then the wakeup state check
> should not match. But for some stupid reason wake_up_lock_sleeper() should
> not use TASK_ALL. The lock sleepers are in state UNINTERRUPTIBLE, so the
> wake state should be UNINTERRUPTIBLE as well.
> 
> The extra check in try_to_wake_up() should stay though as it prevents
> spurious wake ups in general.

Further experimentation shows that it's not worth it. I'll send a V2 of
that patch with the proper fix.

Thanks,

	tglx
