From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 07:03:17 -0700
Message-ID: <4C90D225.1080902@us.ibm.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com> <201009151059.23039.klaas.van.gend@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jordan <triplesquarednine@gmail.com>, Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Klaas van Gend <klaas.van.gend@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48669 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218Ab0IOOEJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 10:04:09 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FDmEV4027576
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 09:48:14 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8FE46bJ046432
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 10:04:06 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8FE45vA025603
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 08:04:05 -0600
In-Reply-To: <201009151059.23039.klaas.van.gend@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Klaas van Gend wrote:
> On Wednesday 15 September 2010 05:38:49 jordan wrote:
>> Which leads me to my last example. Most people are aware that since
>> about 1999-2000, Linux has dominated the movie industry. Beginning
>> with Titanic and even today with say, Avatar.
>>
>> I would be willing to bet, that all of those wonderful rendering farms
>> and production suites, are
>> in fact using rt-linux.
> 
> 
> Please put a lot of money on that bet, because I'd like to win it :-)
> 
> Why would those rendering farms use rt-linux?
> 
> Rendering is not done in real-time - far from it actually. It can take minutes 
> of the entire farm to render a single frame. So rendering is nothing but CPU-
> intensive (calculating how all those lightbeams are reflected by each surface) 
> - and everything I/O bound is about throughput: writing the rendered pixels to 
> disk and getting more surfaces from disk.
> 
> There are no deadlines for rendering, there are no penalties if a frame is 
> late by seconds - if the farm cannot complete its job overnight, they'll add 
> more CPU power.

While all of the above is true, I'll add that it's worth testing
RT because certain applications which have lock-step operations,
can be very negatively impacted in throughput by severe lack of
determinism.  If all of a set of operations need to complete before
they can do the next set of operations, and one of the threads takes
very long, the others all idle as a result. If this happens frequently,
you're better off trying to cap max latencies.

So RT actually provides improved *throughput* as well, despite the
increased overhead.

I don't know if these rendering type applications necessarily
fall into that bucket, but I would at least take a look.


thanks,
Nivedita


