From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH [RT] 00/14] RFC - adaptive real-time locks
Date: Sat, 23 Feb 2008 00:03:45 -0800
Message-ID: <20080223000345.e6be3280.akpm@linux-foundation.org>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	<20080221212420.GA20953@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, a.p.zijlstra@chello.nl,
	tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:33141 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763241AbYBWIFW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Feb 2008 03:05:22 -0500
In-Reply-To: <20080221212420.GA20953@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 21 Feb 2008 22:24:20 +0100 Ingo Molnar <mingo@elte.hu> wrote:

> regarding the concept: adaptive mutexes have been talked about in the 
> past, but their advantage is not at all clear, that's why we havent done 
> them. It's definitely not an unambigiously win-win concept.

When ext3 was converted from sleeping locks to spinlocks, dbench-on-numaq
throughput went up by a factor of ten.  I'd expect that what RT has done
was a truly awful change for lots of workloads on lots of machines.

Yeah, there's the dont-enable-it-if-you're-doing-that option, but that adds
the we-just-doubled-the-number-of-kernels-distros-need-to-ship problem.

Does -rt also make bit_spin_lock preemptible?  If not, I'd have thought the
change was of little benefit to ext3/jbd and it might as well go back to
spinning locks.
