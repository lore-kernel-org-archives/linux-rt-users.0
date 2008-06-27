From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] sched: newidle and RT wake-buddy fixes
Date: Fri, 27 Jun 2008 22:51:36 +0200
Message-ID: <1214599896.12348.9.camel@twins>
References: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, npiggin@suse.de, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50181 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759152AbYF0Uvw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2008 16:51:52 -0400
In-Reply-To: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2008-06-27 at 14:29 -0600, Gregory Haskins wrote:
> Hi Ingo,
>   The following patches apply to linux-tip/sched/devel and enhance the
> performance of the kernel (specifically in PREEMPT_RT, though they do
> not regress mainline performance as far as I can tell).  They offer
> somewhere between 50-100% speedups in netperf performance, depending
> on the test.
> 
> Should you be interested in these patches, you can optionally pull them
> from git at the following URL:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ghaskins/linux-2.6-hacks.git sched-devel
> 
> Comments/feedback/bugfixes welcome

Seem reasonable to me,

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

