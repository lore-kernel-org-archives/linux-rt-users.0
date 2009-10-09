From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH RFC] BKL not necessary in cpuid_open
Date: Fri, 9 Oct 2009 17:55:21 -0400 (EDT)
Message-ID: <571973584.1452471255125321659.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
References: <1033457751.1452271255124941735.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934529AbZJIV4G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Oct 2009 17:56:06 -0400
In-Reply-To: <1033457751.1452271255124941735.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


----- "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Wednesday 07 October 2009, John Kacur wrote:
> > 
> > I've been staring at the BKL lock in cpuid_open, and I can't see
> what it 
> > is protecting. However, I may have missed something - even something
> 
> > obvious, so comments are welcome.
> > 
> 
> Hi John,
> 
> In general, the lock_kernel() calls in any chardev open() file
> operation
> are the result of the BKL pushdown by Jon Corbet and others, which has
> happened
> some time last year[1]. I'd assume that the vast majority is not
> needed
> at all, so these are an easy target for removal.
> 
> 	Arnd
> 
> [1] http://lkml.indiana.edu/hypermail/linux/kernel/0805.2/0257.html

yup - I'm aware of all the hard work that many people put in before I ever looked at this.
Thomas asked the -rt folks to have a look at removing the bkl look during the rt-mini summit
in Dresden. I was looking for low hanging fruit to get started. The confusion was over what
was already implemented in tip/rt/bkl. I merely looked at the latest linus/master build.
The result was a good one though, because basically Thomas' work got pushed from tip/rt/bkl
into tip/master, and can hopefully be pushed upstream during the next merge window.

Even if getting starting means just reviewing what is in rt/bkl and not yet in linus/master,
I think that would be positive. I'm sure Thomas will stomp on me if I start to annoy him. :)

Thanks

John
