From: Jan Blunck <jblunck@novell.com>
Subject: Re: [RFC 3/4] Disable scheduler tick when we are running
	SCHED_FIFO tasks
Date: Wed, 8 Sep 2010 16:47:08 +0200
Message-ID: <20100908144708.GK7436@bolzano.suse.de>
References: <1283948964-6418-1-git-send-email-jblunck@suse.de> <1283948964-6418-4-git-send-email-jblunck@suse.de> <87vd6gweo6.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, peterz@infradead.org,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Michael Galbraith <MGalbraith@novell.com>
To: Andi Kleen <andi@firstfloor.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39715 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931Ab0IHOrM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Sep 2010 10:47:12 -0400
Content-Disposition: inline
In-Reply-To: <87vd6gweo6.fsf@basil.nowhere.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 08, Andi Kleen wrote:

> Jan Blunck <jblunck@suse.de> writes:
> 
> > This patch is disabling the scheduler tick to go off when there is a task
> > with SCHED_FIFO policy running. Since these tasks are not timesliced anyway
> > we only care about timers, softirqs and such stuff just like when we disable
> > the tick during idle periods.
> 
> How would these tasks accounted for then? 
> 
> The CPU time accounting relies on the timer tick currently.
> 

Yes, that is a known issue.

Jan

> -Andi
> 
> -- 
> ak@linux.intel.com -- Speaking for myself only.
