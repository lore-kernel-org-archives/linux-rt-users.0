From: jordan <triplesquarednine@gmail.com>
Subject: Re: 2.6.33-7-rt30 and 2.6.38 comparison
Date: Sat, 19 Mar 2011 04:35:16 -0400
Message-ID: <AANLkTim9aK3vPEiVKQVm3tFZufuYUwSe+=qL8xf=gDb8@mail.gmail.com>
References: <76D8B96C9CCF479A864872F2092B0C8F@e1705>
	<SNT110-W3899829B3D225E2BEC8CDDA8B30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Victor henri <nadaeck@hotmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63256 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab1CSIfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Mar 2011 04:35:18 -0400
Received: by eyx24 with SMTP id 24so1111944eyx.19
        for <linux-rt-users@vger.kernel.org>; Sat, 19 Mar 2011 01:35:16 -0700 (PDT)
In-Reply-To: <SNT110-W3899829B3D225E2BEC8CDDA8B30@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Victor,

> Same results (very few X-runs, if any) with :
>
> =A0-=A0 on one hand, on an Asus laptop with a Core i3=A0 : latency 2.=
3 msec
> with the 2.6.33.7.2-rt kernel and 23 msec with a 2.6.37 preempt kerne=
l;

23msec with 2.6.37 preemptive kernel is terrible. Not one of my
machines would perform that badly (and most use 2.6.37.3). Some are
also considerably older (like 5years older) than your asus laptop..

> =A0-=A0 on the other hand, on a Lenovo Thinkpad Core i5 : =A0latency =
2.3 msec
> with the 2.6.33.7.2-rt kernel and 2.3 msec (yes the same) with a 2.6.=
37
> preempt kernel !!

that's not surprising, that is what i would expect to see. 2.6.33-rt
is getting quite dated, and old. For industrial / embedded
applications it might be the only option but for Linux audio / video
editing, there are preemptive kernels that work very well.

> Of course the Lenovo Thinkpad is a very good laptop, but how come tha=
t there is such a big difference?

someone can probably answer this better, but i think it comes down to
hardware / software design / implementation - some PCs work better
because of the quality of parts, the software and how well they
integrate.

*** ....and how well-supported each component is under Linux. ***

> So, I have observed the same quality of performance as Madovsky but n=
ot
> on every machine I've used... I don't have a clue why....

I also have observed the same thing.  i actually only use RT on 1
computer right now. On the Rest of my machines, 2.6.37.3-zen (PREEMPT,
BFS and BFQ v2.0 + optimizations) works wonders.
In every use i have 2.6.37 is better ( i am a pro-audio person ).

I will say between 2.6.33 and 2.6.38 they have been many MANY changes,
so i am not surprised that 2.6.38 performs as well as 2.6.33-rt 9or
even just close). 2.6.38 (i believe) is the First kernel to have BKL
(Big kernel Lock) completely removed ....and also CFS (completely fair
scheduler) have changed quite a bit (since .33) and has been more
optimized. those 2 factors alone, should reduce latency. Coupled with
other fixes and changes in the kernel - should explain these kinds of
observations.

just my 2 cents

jordan
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
