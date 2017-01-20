From: Mike Galbraith <efault@gmx.de>
Subject: Re: [rfc patch-rt] posix_cpu_timers: Kill hotplug cpu notifier
Date: Fri, 20 Jan 2017 18:29:54 +0100
Message-ID: <1484933394.20890.5.camel@gmx.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
         <1482735654.4476.62.camel@gmx.de>
         <20170120164608.2oorygs5nfpxgptj@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:58093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbdATRaL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Jan 2017 12:30:11 -0500
In-Reply-To: <20170120164608.2oorygs5nfpxgptj@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2017-01-20 at 17:46 +0100, Sebastian Andrzej Siewior wrote:
> On 2016-12-26 08:00:54 [+0100], Mike Galbraith wrote:
> > Shamelessly steal softirq.c thread initialization method.
> What is the problem here?

There is no problem in 4.9.  I did that for upstream, thought it might 
save someone a minute or two.

	-Mike
