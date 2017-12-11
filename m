From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Do not pull from current CPU if only one cpu
 to pull
Date: Mon, 11 Dec 2017 14:34:42 -0500
Message-ID: <20171211143442.3beb2ff8@gandalf.local.home>
References: <20171202130454.4cbbfe8d@vmware.local.home>
        <20171211164732.b5axwxwzenlerd7n@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbdLKTep (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Dec 2017 14:34:45 -0500
In-Reply-To: <20171211164732.b5axwxwzenlerd7n@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 11 Dec 2017 17:47:32 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> > Link: http://lkml.kernel.org/r/8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org
> > Fixes: 4bdced5c9 ("sched/rt: Simplify the IPI based RT balancing logic")
> > Cc: stable@vger.kernel.org
> > Reported-by: Daniel Wagner <wagi@monom.org>  
> 
> I've added:
> 
>   Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Which I suspect you just forgot to add?

Ug, not sure how that happened, but yes, I simply forgot to add that
(probably did it using quilt and expected to use git commit -s)

Thanks Ingo!

-- Steve
