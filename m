From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/7] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Wed, 14 Jan 2015 16:29:02 +0100
Message-ID: <20150114152902.GH22386@worktop.programming.kicks-ass.net>
References: <1413591782-23453-1-git-send-email-paul.gortmaker@windriver.com>
 <1413591782-23453-4-git-send-email-paul.gortmaker@windriver.com>
 <20150114103834.GN23965@worktop.programming.kicks-ass.net>
 <20150114091849.501a0a72@gandalf.local.home>
 <20150114143102.GE22386@worktop.programming.kicks-ass.net>
 <20150114100102.55c78715@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59656 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbbANP3H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Jan 2015 10:29:07 -0500
Content-Disposition: inline
In-Reply-To: <20150114100102.55c78715@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 14, 2015 at 10:01:02AM -0500, Steven Rostedt wrote:
> Then why even bother with the wake_up_state, and not just call
> wake_up_process()?

Ah indeed. TASK_NORMAL should be fine for all.
