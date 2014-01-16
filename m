From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 0/2] preempt: Track unmatched preempt_enable() to
 preempt_disable()
Date: Thu, 16 Jan 2014 18:45:36 +0100
Message-ID: <20140116174536.GB9655@laptop.programming.kicks-ass.net>
References: <20140116171824.748919700@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43565 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaAPRpq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Jan 2014 12:45:46 -0500
Content-Disposition: inline
In-Reply-To: <20140116171824.748919700@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 16, 2014 at 12:18:24PM -0500, Steven Rostedt wrote:

Didn't see anything horrible in there, so fine with me.

Another thing I recently ran into was:

  local_irq_disable();
  preempt_disable();
  local_irq_enable();

  local_irq_disable();
  preempt_enable();
  local_irq_enable();

I'm not sure any of our debugging catches that, I meant to extend
lockdep, but maybe it could also be hooked into something else.
