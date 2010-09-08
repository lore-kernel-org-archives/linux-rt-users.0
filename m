From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 3/4] Disable scheduler tick when we are running
 SCHED_FIFO tasks
Date: Wed, 08 Sep 2010 14:45:43 +0200
Message-ID: <1283949943.23762.16.camel@laptop>
References: <1283948964-6418-1-git-send-email-jblunck@suse.de>
	 <1283948964-6418-4-git-send-email-jblunck@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Michael Galbraith <MGalbraith@novell.com>
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44202 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab0IHMqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Sep 2010 08:46:05 -0400
In-Reply-To: <1283948964-6418-4-git-send-email-jblunck@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-09-08 at 14:29 +0200, Jan Blunck wrote:
> This patch is disabling the scheduler tick to go off when there is a task
> with SCHED_FIFO policy running. Since these tasks are not timesliced anyway
> we only care about timers, softirqs and such stuff just like when we disable
> the tick during idle periods.
> 

Also, doesn't this break any and all jiffies users?

And you need to restart the tick on call_rcu() and everything else that
requires the tick for processing.

