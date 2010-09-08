From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC 3/4] Disable scheduler tick when we are running SCHED_FIFO tasks
Date: Wed, 08 Sep 2010 15:25:13 +0200
Message-ID: <87vd6gweo6.fsf@basil.nowhere.org>
References: <1283948964-6418-1-git-send-email-jblunck@suse.de>
	<1283948964-6418-4-git-send-email-jblunck@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, peterz@infradead.org,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Michael Galbraith <MGalbraith@novell.com>
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:40316 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709Ab0IHNZO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Sep 2010 09:25:14 -0400
In-Reply-To: <1283948964-6418-4-git-send-email-jblunck@suse.de> (Jan Blunck's
	message of "Wed, 8 Sep 2010 14:29:23 +0200")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Jan Blunck <jblunck@suse.de> writes:

> This patch is disabling the scheduler tick to go off when there is a task
> with SCHED_FIFO policy running. Since these tasks are not timesliced anyway
> we only care about timers, softirqs and such stuff just like when we disable
> the tick during idle periods.

How would these tasks accounted for then? 

The CPU time accounting relies on the timer tick currently.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
