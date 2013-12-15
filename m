From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] migrate_disable pushd down in rt_read_trylock
Date: Sun, 15 Dec 2013 14:16:43 +0100
Message-ID: <20131215131643.GC31090@linutronix.de>
References: <20131123005158.GA16338@opentech.at>
 <20131129151401.GD31099@linutronix.de>
 <20131129154425.GE31099@linutronix.de>
 <20131130023026.GB8114@opentech.at>
 <20131130064755.GA12036@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55532 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab3LONQq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 08:16:46 -0500
Content-Disposition: inline
In-Reply-To: <20131130064755.GA12036@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-11-30 07:47:55 [+0100]:

>given that the broken patch was disabling once and enabling potentially a
>number of times it should have triggert the
>WARN_ON_ONCE(p->migrate_disable <= 0); in migrate_enable() if the recursive
>case would have ever bin hit... so much to testing and locking...

And is why I removed the line
> No change of functionality

from the change log because it was not obvious to me that is a
zero-change patch :)

Are you going to redo this one?

>thx!
>hofrat

Sebastian
