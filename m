From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [patch] rt,blk,mq: Make blk_mq_cpu_notify_lock a raw spinlock
Date: Fri, 07 Mar 2014 18:16:21 +0100
Message-ID: <1394212581.9487.23.camel@marge.simpson.net>
References: <1393822646.5816.4.camel@marge.simpson.net>
	 <20140307160002.GB18441@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140307160002.GB18441@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-03-07 at 17:00 +0100, Sebastian Andrzej Siewior wrote: 
> * Mike Galbraith | 2014-03-03 05:57:26 [+0100]:
> 
> > block/blk-mq-cpu.c |   14 +++++++-------
> 
> This got in v3.13-rc1, are you running some kind of backported version
> of this in v3.12 or do you have your own v3.13-rt?

It's 3.12, but with a few (koff) backports.

-Mike
