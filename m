From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] time/hrtimer: disable that mode check
Date: Wed, 13 Dec 2017 15:22:57 +0100
Message-ID: <20171213142257.ok7xdag5p4wp4mfo@linutronix.de>
References: <20171213135835.rwtcf7kj45a6x4tt@linutronix.de>
 <20171213141919.ouizpou5erye4fgz@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35718 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbdLMOW7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Dec 2017 09:22:59 -0500
Content-Disposition: inline
In-Reply-To: <20171213141919.ouizpou5erye4fgz@hirez.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-13 15:19:19 [+0100], Peter Zijlstra wrote:
> On Wed, Dec 13, 2017 at 02:58:35PM +0100, Sebastian Andrzej Siewior wrote:
> > On -RT we push all timers by default into the soft-mode. The
> > "start/update" code does not use that SOFT bit so we always see that
> > warning.
> 
> Not _all_ timers I hope? There's a few the scheduler and perf use that
> really should stay in hardirq context.
That is correct, a few ones remain in the hardirq context.

Sebastian
