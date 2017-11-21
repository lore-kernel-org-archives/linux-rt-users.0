From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 5/8] sched: Remove TASK_ALL
Date: Tue, 21 Nov 2017 11:27:32 -0500
Message-ID: <20171121112732.503a0a32@gandalf.local.home>
References: <20171121160654.493640386@goodmis.org>
        <20171121160706.405135518@goodmis.org>
        <20171121161907.ovg4ye7czrqlqkx2@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbdKUQ1f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Nov 2017 11:27:35 -0500
In-Reply-To: <20171121161907.ovg4ye7czrqlqkx2@hirez.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 21 Nov 2017 17:19:07 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Nov 21, 2017 at 11:06:59AM -0500, Steven Rostedt wrote:
> > 4.4.97-rt111-rc1 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> No real objection, just curious as to why its -stable material.

Good question ;-) But it was marked with the stable-rt tag, Thomas
said it was dangerous, and it applied nicely.

-- Steve
