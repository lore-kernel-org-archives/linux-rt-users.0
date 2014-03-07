From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] rt,blk,mq: Make blk_mq_cpu_notify_lock a raw spinlock
Date: Fri, 7 Mar 2014 17:00:02 +0100
Message-ID: <20140307160002.GB18441@linutronix.de>
References: <1393822646.5816.4.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393822646.5816.4.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2014-03-03 05:57:26 [+0100]:

> block/blk-mq-cpu.c |   14 +++++++-------

This got in v3.13-rc1, are you running some kind of backported version
of this in v3.12 or do you have your own v3.13-rt?

Sebastian
