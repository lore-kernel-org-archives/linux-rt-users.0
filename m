From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: at kernel/sched.c:4031 __schedule()
Date: Fri, 08 Jun 2007 12:52:27 +0200
Message-ID: <1181299947.4404.306.camel@chaos>
References: <4668112B.4090406@gmail.com>
	 <1181230780.10408.0.camel@localhost.localdomain>
	 <1181231910.3841.55.camel@bender>
	 <1181232783.10408.8.camel@localhost.localdomain>
	 <1181233286.11539.38.camel@imap.mvista.com>
	 <1181234037.11539.41.camel@imap.mvista.com>
	 <ce87d8040706080308r12735e27ne56a88d3c99b045f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Oleg Kechin <okechin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:51611 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937251AbXFHKwb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Jun 2007 06:52:31 -0400
In-Reply-To: <ce87d8040706080308r12735e27ne56a88d3c99b045f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-06-08 at 13:08 +0300, Oleg Kechin wrote:
> Sorry, OMAP5910 CPU is ARM 925 (v4).
> Thank you, Daniel, it's disapear.
> There is stil a bit unclearness for me. When I set config other than
> PREEMPT_RT this bug occure again.
> May be it's ok - if someone want -rt patch on ARM arch, he will want
> only PREEMPT_RT or I am wrong?

My bad. The check in schedule() is there whether PREEMPT_RT is enabled
or not. I'm going to look at this.

Thanks,

	tglx
