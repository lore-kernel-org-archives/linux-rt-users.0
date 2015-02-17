From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: 3.14.23-rt20 - aio: fix rcu garbage collection might_sleep()
 splat
Date: Tue, 17 Feb 2015 15:01:37 +0100
Message-ID: <1424181697.2955.6.camel@gmail.com>
References: <20141031170326.1491a63f@gandalf.local.home>
	 <1414910967.5380.81.camel@marge.simpson.net>
	 <1414913488.5380.115.camel@marge.simpson.net>
	 <20150217125342.GJ26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33340 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933096AbbBQOBl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 09:01:41 -0500
In-Reply-To: <20150217125342.GJ26177@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2015-02-17 at 13:53 +0100, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2014-11-02 08:31:28 [+0100]:
> 
> >(not pretty)
> 
> You do the RCU thingy and replace locking. Is this required after the
> patch I've sent in "Re: [RFC PATCH V2] rt/aio: fix rcu garbage
> collection might_sleep() splat"? From a quick browse I've seen that
> ffs_epfile_aio_write() invokes kiocb_set_cancel_fn(, ffs_aio_cancel) and
> the function does hold a sleeping lock.

Yeah, I don't think that's changed, it should still gripe.

	-Mike

