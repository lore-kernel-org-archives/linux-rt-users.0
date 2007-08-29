From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2.6.21.5-rt17] IPV6: estalished connections are not shown
 with "cat /proc/net/tcp6"
Date: Wed, 29 Aug 2007 08:36:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708290831380.22945@gandalf.stny.rr.com>
References: <46D4CED2.4060302@ncos.nec.co.jp> <20070828.215636.99202736.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: nakagawa.msy@ncos.nec.co.jp, dwalker@mvista.com, mingo@elte.hu,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de,
	rlrevell@joe-job.com
To: David Miller <davem@davemloft.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:44882 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbXH2MhN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Aug 2007 08:37:13 -0400
In-Reply-To: <20070828.215636.99202736.davem@davemloft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
When I'm asked what language is my mother tongue,
I simply answer "C".

On Tue, 28 Aug 2007, David Miller wrote:

> From: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>
> Date: Tue, 28 Aug 2007 18:41:38 -0700
>
> > +static inline void __inet_hash_setbit(unsigned long *bitmask,
> > +	unsigned int index)
> > +{
> > +	if (bitmask)
> > +		set_bit(index, bitmask);
> > +}
> > +
> > +static inline void __inet_hash_clearbit(unsigned long *bitmask,
> > +	unsigned int index)
> > +{
> > +	if (bitmask)
> > +		clear_bit(index, bitmask);
> > +}
> > +
>
> A new atomic operation every single socket hashing insert or delete
> operation is way too much amount of overhead for what should be a
> trivial problem.

Indeed it is.

>
> Please fix this in another way that does not add new locks or atomics
> to the socket creation and destruction fast paths, thank you.
>

This was originally written back when there was a bh lock around the
entire loop (IIRC).  It caused quite a bit of latency problems back then.

I'll have to take a look to see if it is even still a problem.

If it is, then we'll need to find another fix for it. Unfortunately, it's
not that trivial (if it is still a problem). Since we need a way to look a
a large number of buckets without looping through checking each one.

Lee, I think you were the one to notice this source of latency back when
it was first discovered. If I write a patch to back this out of the -rt
kernel, could you see if it is still an issue?

Thanks,

-- Steve
