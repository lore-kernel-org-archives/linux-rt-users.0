From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2.6.21.5-rt17] IPV6: estalished connections are not shown
 with "cat /proc/net/tcp6"
Date: Wed, 29 Aug 2007 08:31:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708290829500.22945@gandalf.stny.rr.com>
References: <46D4CED2.4060302@ncos.nec.co.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dwalker@mvista.com, mingo@elte.hu, linux-rt-users@vger.kernel.org,
	tglx@linutronix.de, rlrevell@joe-job.com
To: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:59400 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbXH2McW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Aug 2007 08:32:22 -0400
In-Reply-To: <46D4CED2.4060302@ncos.nec.co.jp>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Tue, 28 Aug 2007, Masayuki Nakagawa wrote:

> > On Sat, 2007-06-23 at 08:25 -0400, Steven Rostedt wrote:
> >
> >> --- linux-2.6.21.orig/net/ipv4/tcp_ipv4.c       2007-06-17 17:19:02.000000000 +0200
> >> +++ linux-2.6.21/net/ipv4/tcp_ipv4.c    2007-06-17 17:20:27.000000000 +0200
> >> @@ -2033,7 +2033,12 @@ static void *established_get_first(struc
> >>         struct tcp_iter_state* st = seq->private;
> >>         void *rc = NULL;
> >>
> >> -       for (st->bucket = 0; st->bucket < tcp_hashinfo.ehash_size; ++st->bucket) {
> >>
> >> The above is a linear search through out a very large array, where most
> >> of the items are NULL.  I believe it was Lee that noticed this creating
> >> a large latency. This was back in 2.6.14. I'll check to see if this
> >> still is a source of latency with the latest kernels.
> >
> > It looks fairly generic, is it a latency that could be fix the same way
> > up stream?
> >
> > Daniel
> >
> Hi Steven,
>
> I believe that we should push the following patch to upstream(netdev).
> (This is a patch which extracted a part of the hash code from real-time patch.)
> How do you think?
>

Hi Masayuki,

I really need to investigate if this is even still needed. This code was
originally added when a bh lock was held for the entire for loop. I see
that it is done per entry now.  I'll take a look to see if there's a
better way to do this.

Thanks for bringing this back to the fore front.

-- Steve
