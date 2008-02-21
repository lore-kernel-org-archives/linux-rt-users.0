From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH [RT] 00/14] RFC - adaptive real-time locks
Date: Thu, 21 Feb 2008 22:24:20 +0100
Message-ID: <20080221212420.GA20953@elte.hu>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:50878 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933007AbYBUV0a (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 16:26:30 -0500
Content-Disposition: inline
In-Reply-To: <20080221152504.4804.8724.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


hm. Why is the ticket spinlock patch included in this patchset? It just 
skews your performance results unnecessarily. Ticket spinlocks are 
independent conceptually, they are already upstream in 2.6.25-rc2 and 
-rt will have them automatically once we rebase to .25.

and if we take the ticket spinlock patch out of your series, the the 
size of the patchset shrinks in half and touches only 200-300 lines of 
code ;-) Considering the total size of the -rt patchset:

   652 files changed, 23830 insertions(+), 4636 deletions(-)

we can regard it a routine optimization ;-)

regarding the concept: adaptive mutexes have been talked about in the 
past, but their advantage is not at all clear, that's why we havent done 
them. It's definitely not an unambigiously win-win concept.

So lets get some real marketing-free benchmarking done, and we are not 
just interested in the workloads where a bit of polling on contended 
locks helps, but we are also interested in workloads where the polling 
hurts ... And lets please do the comparisons without the ticket spinlock 
patch ...

	Ingo
