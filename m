From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [RFC v0 0/3] Simple wait queue support
Date: Thu, 6 Aug 2015 15:22:45 -0400
Message-ID: <20150806192243.GD1342@windriver.com>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <bigeasy@linutronix.de>,
	<tglx@linutronix.de>, <paulmck@linux.vnet.ibm.com>,
	<rostedt@goodmis.org>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:53572 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbbHFTXo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Aug 2015 15:23:44 -0400
Content-Disposition: inline
In-Reply-To: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[[RFC v0 0/3] Simple wait queue support] On 05/08/2015 (Wed 15:30) Daniel Wagner wrote:

> Hi,
> 
> It's a while since the last attempt by Paul to get simple wait ready
> for mainline [1]. At the last realtime workshop it was discussed how
> the swait implementation could be made preempt aware. Peter posted an
> untested version of it here [2].

So, from memory, here are the issues or questions that need answers
before we can consider trying mainline IMO.

1) naming: do we keep the swait, do we try and morph complex wait users
   into using cwait, or some mix of the two, or ... ?

2) placement: as I think I said before, the standalone files works for
   the -rt patches because it is the lowest maintenance solution, but
   IMO for mainline, the simple and complex versions should be right
   beside each other so they can be easily contrasted and compared and
   so any changes to one will naturally also flow to the other.

3) barrier usage:  we'd had some questions and patches in the past that
   futz'd around with the use of barriers, and as a mainline requirement
   we'd need someone to check, understand and document them all properly.

4) poll_wait: currently it and poll_table_entry are both hard coupled
   to wait_queue_head_t -- so any users of poll_wait are not eligible
   for conversion to simple wait. (I just happened to notice that
   recently.)  A quick grep shows ~500 poll_wait users.

5) the aforementioned "don't do an unbounded number of callbacks while
   holding the raw lock" issue.

We should solve #5 for -rt regardless; I wouldn't attempt to make a
new "for mainline" set again w/o some consensus on #1 and #2, and I
think it would take someone like peterz/paulmck/rostedt to do #3
properly.  I don't know if #4 is an issue we need to worry about
right away; probably not.  And I'm sure I'll think of some other
issue five seconds after I hit send...

Paul.
--

> 
> In order to test it, I used Paul's two patches which makes completion
> and rcu using swait instead of wait. Some small renamings were
> necessary to get it working, e.g. s/swait_head/swait_queue_head/.
> 
> My test system didn't crash or showed any obvious defects, so I
> decided to apply some benchmarks utilizing mmtests. I have picked some
> random tests (kernbench aim9 vmr-stream ebizz), which didn't require a
> lot of tinker around to get them running. The results are here:
> 
>   baseline: v4.2-rc5-22-ged8bbba
> 
>   http://monom.org/mmtests-swait-peterz-v1/
> 
> I don't think the numbers are trustworthy yet. Mabye one could read
> it as it doesn't explode and the numbers aren't to far away from
> baseline. I need to figure out which tests are fitting for these
> patches and what are the 'right' parameters for them.
> 
> Sebastian had some comments on Peter's patch. I haven't addressed them
> yet [3].
> 
> cheers,
> daniel
> 
> [1] https://lwn.net/Articles/616857/
> [2] http://www.spinics.net/lists/linux-rt-users/msg12703.html
> [3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg832142.html
> 
> Paul Gortmaker (2):
>   sched/completion: convert completions to use simple wait queues
>   rcu: use simple wait queues where possible in rcutree
> 
> Peter Zijlstra (1):
>   KVM: use simple waitqueue for vcpu->wq
> 
>  include/linux/completion.h |   8 +--
>  include/linux/swait.h      | 172 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/rcu/tree.c          |  13 ++--
>  kernel/rcu/tree.h          |   6 +-
>  kernel/rcu/tree_plugin.h   |  18 ++---
>  kernel/sched/Makefile      |   2 +-
>  kernel/sched/completion.c  |  32 ++++-----
>  kernel/sched/swait.c       | 122 ++++++++++++++++++++++++++++++++
>  8 files changed, 334 insertions(+), 39 deletions(-)
>  create mode 100644 include/linux/swait.h
>  create mode 100644 kernel/sched/swait.c
> 
> -- 
> 2.4.3
> 
