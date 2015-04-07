From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 07 Apr 2015 13:47:16 +0200
Message-ID: <1428407236.3152.81.camel@gmail.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	 <1428369962-74723-1-git-send-email-tmac@hp.com>
	 <1428369962-74723-2-git-send-email-tmac@hp.com>
	 <alpine.DEB.2.11.1504071255410.3845@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thavatchai Makphaibulchoke <tmac@hp.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36085 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbbDGLrU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2015 07:47:20 -0400
In-Reply-To: <alpine.DEB.2.11.1504071255410.3845@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2015-04-07 at 13:23 +0200, Thomas Gleixner wrote:
> On Mon, 6 Apr 2015, Thavatchai Makphaibulchoke wrote:
> 
> > This patch fixes the problem that the ownership of a mutex acquired
> > by an interrupt handler(IH) gets incorrectly attributed to the
> > interrupted thread.
> 
> An hard interrupt handler is not allowed to take a mutex. End of
> story, nothing to fix here.

Well, the patch that started this thread..

timers-do-not-raise-softirq-unconditionally.patch

..(attributed to you) was picked up in -rt (perhaps erroneously) to 
get nohz_full working, and then reverted due to the deadlock detector 
getting properly angry.  All of this is about reinstating it.

I posted a patchlet to simply subtract softirqd from the ->nr_running 
check, which gets nohz_full working in -rt sans illegal activity.

        -Mike
