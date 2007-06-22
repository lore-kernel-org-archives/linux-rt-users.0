From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Sporadic server implementation
Date: Sat, 23 Jun 2007 00:39:28 +0200
Message-ID: <1182551968.20203.142.camel@chaos>
References: <JK1U9G$D52764843ADF4807127CBE557A79E846@libero.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	David Miller <davem@davemloft.net>
To: fla83tn <fla83tn@libero.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:33977 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751266AbXFVWja (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 18:39:30 -0400
In-Reply-To: <JK1U9G$D52764843ADF4807127CBE557A79E846@libero.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Flavio,

first off, please use a mail client which does proper line wraps at
column 78, when sending mail to mailing lists, or configure your mail
client to do so.

On Fri, 2007-06-22 at 20:05 +0200, fla83tn wrote:
> Hi to all,
> I'm a Computer Science student who has patched the linux-2.6.19 for
> supporting the POSIX Sporadic server specifications.

Interesting.

>  It is not yet perfect (mainly because actually it does not use
> hrtimers) because it was only a kind of exercise but I think it can be
> a very good point where to start. If you think this  work can be
> useful in the RT patch let me know about it and I will post the
> patch..

Post it in any case. It implements something which is not yet there and
that's the best way to get some feedback (which might be negative as
well).

Thanks,

	tglx
