From: Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] fix might sleep oops in irq affinity callback hook
Date: Wed, 21 Aug 2013 17:09:28 -0400
Message-ID: <20130821210928.GA14467@tsunami.ccur.com>
References: <20130820175918.GA18125@tsunami.ccur.com>
 <20130821155347.GB16913@linutronix.de>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flusers.ccur.com ([173.221.59.2]:11620 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752688Ab3HUVJl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Aug 2013 17:09:41 -0400
Content-Disposition: inline
In-Reply-To: <20130821155347.GB16913@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 21, 2013 at 11:53:47AM -0400, Sebastian Andrzej Siewior wrote:
> Joe could you please test this one? In 3.10 we have one user of
> __irq_set_affinity_locked() and we might get more.

Hi Sebastian,
I backported the patch to 3.6.11.6-rt38 and added a few printk's so that
when daemon started I would see that and when each affinity hook was
executed I would see that too.

The system came up and the printk for daemon start showed up near where
the sfc driver started, but no affinity action printk appeared.  Thus
the patch as written does not seem to work.

Joe
