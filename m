From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.14.23-rt20 - aio: fix rcu garbage collection might_sleep()
 splat
Date: Tue, 17 Feb 2015 13:53:42 +0100
Message-ID: <20150217125342.GJ26177@linutronix.de>
References: <20141031170326.1491a63f@gandalf.local.home>
 <1414910967.5380.81.camel@marge.simpson.net>
 <1414913488.5380.115.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43621 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283AbbBQMxp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 07:53:45 -0500
Content-Disposition: inline
In-Reply-To: <1414913488.5380.115.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2014-11-02 08:31:28 [+0100]:

>(not pretty)

You do the RCU thingy and replace locking. Is this required after the
patch I've sent in "Re: [RFC PATCH V2] rt/aio: fix rcu garbage
collection might_sleep() splat"? From a quick browse I've seen that
ffs_epfile_aio_write() invokes kiocb_set_cancel_fn(, ffs_aio_cancel) and
the function does hold a sleeping lock.

Sebastian
