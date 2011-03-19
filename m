From: Victor henri <nadaeck@hotmail.com>
Subject: RE: 2.6.33-7-rt30 and 2.6.38 comparison
Date: Sat, 19 Mar 2011 12:07:42 +0100
Message-ID: <SNT110-W53D268D6F9CDC81D542667A8B30@phx.gbl>
References: <76D8B96C9CCF479A864872F2092B0C8F@e1705>,<SNT110-W3899829B3D225E2BEC8CDDA8B30@phx.gbl>,<AANLkTim9aK3vPEiVKQVm3tFZufuYUwSe+=qL8xf=gDb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s21.snt0.hotmail.com ([65.55.90.32]:20295 "EHLO
	snt0-omc1-s21.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203Ab1CSLHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Mar 2011 07:07:43 -0400
In-Reply-To: <AANLkTim9aK3vPEiVKQVm3tFZufuYUwSe+=qL8xf=gDb8@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>




Hello Jordan

> > - on one hand, on an Asus laptop with a Core i3 : latency 2.3 msec
> > with the 2.6.33.7.2-rt kernel and 23 msec with a 2.6.37 preempt kernel;
>
> 23msec with 2.6.37 preemptive kernel is terrible.

For sure 23 msec is terrible; I was so surprised to see that!

 Not one of my
> machines would perform that badly (and most use 2.6.37.3). Some are
> also considerably older (like 5years older) than your asus laptop..
>
> > - on the other hand, on a Lenovo Thinkpad Core i5 : latency 2.3 msec
> > with the 2.6.33.7.2-rt kernel and 2.3 msec (yes the same) with a 2.6.37
> > preempt kernel !!
>
> that's not surprising, that is what i would expect to see. 2.6.33-rt
> is getting quite dated, and old. For industrial / embedded
> applications it might be the only option but for Linux audio / video
> editing, there are preemptive kernels that work very well.
>
> > Of course the Lenovo Thinkpad is a very good laptop, but how come that there is such a big difference?
>
> someone can probably answer this better, but i think it comes down to
> hardware / software design / implementation - some PCs work better
> because of the quality of parts, the software and how well they
> integrate.
>
> *** ....and how well-supported each component is under Linux. ***

Yes Lenovo Thinkpad are famous for having good performance... and furthermore the T410s is "Ubuntu certified". However I experience hang on with the 2.6.33.7.2-rt kernel, but I have a touchscreen (input = 4 fingers multitouch working natively under Maverick... really great) and I suspect the mutitouch screen is responsible of this. Hopefully the performaces og the preempt are great!

>
> > So, I have observed the same quality of performance as Madovsky but not
> > on every machine I've used... I don't have a clue why....
>
> I also have observed the same thing. i actually only use RT on 1
> computer right now. On the Rest of my machines, 2.6.37.3-zen (PREEMPT,
> BFS and BFQ v2.0 + optimizations) works wonders.
> In every use i have 2.6.37 is better ( i am a pro-audio person ).
>
> I will say between 2.6.33 and 2.6.38 they have been many MANY changes,
> so i am not surprised that 2.6.38 performs as well as 2.6.33-rt 9or
> even just close). 2.6.38 (i believe) is the First kernel to have BKL
> (Big kernel Lock) completely removed ....and also CFS (completely fair
> scheduler) have changed quite a bit (since .33) and has been more
> optimized. those 2 factors alone, should reduce latency. Coupled with
> other fixes and changes in the kernel - should explain these kinds of
> observations.
>
> just my 2 cents
>
> jordan

Thank you for those explanations

Victor
 		 	   		  