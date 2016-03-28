From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v0] Use swait in completion
Date: Mon, 28 Mar 2016 14:57:02 -0400
Message-ID: <20160328145702.589da4bd@gandalf.local.home>
References: <1457452754-24029-1-git-send-email-wagi@monom.org>
	<20160308175206.GD21842@linutronix.de>
	<20160308182656.GA27081@jcartwri.amer.corp.natinst.com>
	<20160309122423.GD10517@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Josh Cartwright <joshc@ni.com>, Daniel Wagner <wagi@monom.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:47634 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751639AbcC1S5H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Mar 2016 14:57:07 -0400
In-Reply-To: <20160309122423.GD10517@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 9 Mar 2016 13:24:23 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Josh Cartwright | 2016-03-08 12:26:56 [-0600]:
> 
> >Is it really just about latency?  Does this deferral not lead to an
> >inversion in the case where the single woken task isn't the highest
> >priority waiter on the completion (and doesn't run due to a
> >middle-priority thing spinning)?  
> 
> This would be case, yes. Not only with deferral. Say you have two
> waters: 1st one is MID-prio and the second is HI-prio. Currently after
> the wakeup of the MID-prio waiter you get preempted. Waking all of them
> at once would put the second waiter first on the CPU.
> Samething without the deferral flag.
> 
> >In order for this to work, it seems like the chosen waiter would need to
> >inherit the highest priority of all waiters (which AFAICT isn't
> >happening).  
> 
> sorting the waiters by priority? This will be fun. This is only done for
> the rtmutex waiters.
> 

Hmm, perhaps we should use an rbtree to sort simple waiters by
priority :-)

Probably wont make them simple anymore.

-- Steve
