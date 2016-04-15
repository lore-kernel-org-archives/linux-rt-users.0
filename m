From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT PATCH] cputime: remove raw locks introduced by RT patchset
Date: Fri, 15 Apr 2016 09:13:34 +0200
Message-ID: <5710949E.1020407@linutronix.de>
References: <20160414220943.3d4d7dd2@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51964 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbcDOHNh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Apr 2016 03:13:37 -0400
In-Reply-To: <20160414220943.3d4d7dd2@sluggy.hsv.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/15/2016 05:09 AM, Clark Williams wrote:
> Sebastian,

Hi Clark,

> This patch removes the raw spinlock operations when updating cputtime
> in the vtime_* functions in kernel/sched/cputime.c.
> 
> Based on Frederic's commit b7ce2277f087fd052, there is no need for
> the raw spinlocks in vtime_* functions to guard against writer
> concurrency and the RT versions of write_seqcount_begin() and
> write_seqcount_end() make calls to preempt_disable_rt() and
> preempt_enable_rt(), so we'll be in atomic context while updating
> cputime.
> 
> I've run this patch on x86_64 4.4.6-rt14 and the RHEL-RT kernel, 
> with 12h rteval runs on systems with both no tuning and systems
> with isolcpus/rcu_nocbs/nohz_full cpus. No ill effects seen. 

Frederic's patch made it into 4.5-rc1. What I did yesterday was:

* sched/cputime: Convert vtime_seqlock to seqcount
* sched/cputime: Clarify vtime symbols and document them
* Revert "vtime: Split lock and seqcount"

which is what you want, correct?
> 
> Signed-off-by: Rik van Riel <riel@redhat.com>
> Signed-off-by: Clark Williams <williams@redhat.com>

Sebastian

