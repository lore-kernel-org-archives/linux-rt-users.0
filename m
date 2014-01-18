From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH] rcu: Eliminate softirq processing from rcutree
Date: Sat, 18 Jan 2014 04:30:44 +0100
Message-ID: <1390015844.5444.50.camel@marge.simpson.net>
References: <20131221193900.GA8427@linutronix.de>
	 <1387681647.5412.25.camel@marge.simpson.net>
	 <1387702631.5412.101.camel@marge.simpson.net>
	 <1387773533.5369.16.camel@marge.simpson.net>
	 <20131224193636.GD19211@linux.vnet.ibm.com>
	 <1387940854.5373.8.camel@marge.simpson.net>
	 <1388052212.5420.4.camel@marge.simpson.net>
	 <20140117172319.GH5785@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58473 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbaARDaw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jan 2014 22:30:52 -0500
In-Reply-To: <20140117172319.GH5785@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2014-01-17 at 18:23 +0100, Sebastian Andrzej Siewior wrote:

> So I had rtmutex-take-the-waiter-lock-with-irqs-off.patch in my queue
> which took the waiter lock with irqs off. This should be the same thing
> you try do here.

(yeah, these are just whacked mole body bags;)

