From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: threaded interrupt handlers: what if hardirq part not disables
 device interrupt?
Date: Mon, 01 Aug 2011 14:44:38 +0200
Message-ID: <1312202678.2617.460.camel@laptop>
References: <CANqCtQ+9ab1qt0WzuC6n6gX9Y8XNcDxaTosUBc94eecj0umuiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56055 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1HAMj5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 08:39:57 -0400
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qnrmm-0007iR-RK
	for linux-rt-users@vger.kernel.org; Mon, 01 Aug 2011 12:39:56 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1Qnrmm-00030f-4y
	for linux-rt-users@vger.kernel.org; Mon, 01 Aug 2011 12:39:56 +0000
In-Reply-To: <CANqCtQ+9ab1qt0WzuC6n6gX9Y8XNcDxaTosUBc94eecj0umuiQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2011-07-31 at 16:15 +0200, Remy Bohmer wrote:
> As alternative solution I can do the following as well:
> The driver now has a tasklet used for processing the queue. If I add
> IRQF_NO_THREAD as irq-flag, the thread is not created and the handler
> runs completely in hard-irq context. This seems to work okay, but it
> does not feel as the right solution.
> 
> How is this supposed to work? Do you have better ideas how to solve
> situations like this? 

This sounds like the total trainwreck known as tty/console, I believe
jwessel and tglx had some ideas on that. Maybe Jason can share what he
knows, I'm not up to speed on that issue.



