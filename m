From: John Kacur <jkacur@redhat.com>
Subject: Re: [RFC] [rt-tests] change to cyclictest behavior
Date: Wed, 6 Jan 2010 20:39:25 +0100
Message-ID: <520f0cf11001061139j2af13403qfcbf567647bdfaa8@mail.gmail.com>
References: <20100106130400.7f30ae55@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:40332 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab0AFTj1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Jan 2010 14:39:27 -0500
In-Reply-To: <20100106130400.7f30ae55@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 6, 2010 at 8:04 PM, Clark Williams <williams@redhat.com> wr=
ote:
> RT-ers,
>
> I have a problem with the way cyclictest sets up measurement threads,
> but before I went and changed things I thought I would ask if people
> cherished this particular behavior.
>
> Currently, when cyclictest is run with multiple threads (i.e. -t
> option) it distributes both the sample interval and the realtime
> priority by adding the 'distance' parameter to the interval and
> decrementing the priority by one. This means if you have a distance o=
f
> 500us (default), a specified RT priority of 95 and start four threads=
,
> they will be started with the following parameters:
>
> $ cyclictest -t4 -p95
>
> Will give you:
>
> thread =A0 =A0 =A0 =A0 =A0priority =A0 =A0 =A0 =A0sample interval
> 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 95 =A0 =A0 =A0 =A0 =A0 =A0 =A0500
> 1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 94 =A0 =A0 =A0 =A0 =A0 =A0 =A01000
> 2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 93 =A0 =A0 =A0 =A0 =A0 =A0 =A01500
> 3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 92 =A0 =A0 =A0 =A0 =A0 =A0 =A02000
>
> What I'd like to do is modify this logic so that when '-a' (affinity)=
 is
> specified, the priority and sample interval will not be altered. I
> don't think there's any point in distributing the priority's and
> sample intervals when the measurement threads are pinned to their own
> CPU.
>
> So:
>
> $ cyclictest -t4 -p95 -a
>
> Would have each thread at SCHED_FIFO 95 and a sample interval of 500u=
s.
>
> Note that this behavior also occurs when the histogram (-h) option is
> specified).
>
> Thoughts?
>

Seems reasonable to me. Maybe it would also be nice to have a flag to
get the old behaviour back even with -a?

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
