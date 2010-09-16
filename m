From: Mike Galbraith <efault@gmx.de>
Subject: Re: TinxCore and PREEMPT_RT
Date: Thu, 16 Sep 2010 13:25:32 +0200
Message-ID: <1284636332.9142.150.camel@marge.simson.net>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	 <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com>
	 <201009151059.23039.klaas.van.gend@mvista.com>
	 <4C90A814.8020605@steinhoff.de> <4C91E59E.5010203@steinhoff.de>
	 <8762y6dmat.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: David Kastrup <dak@gnu.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:41950 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751818Ab0IPLZd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 07:25:33 -0400
In-Reply-To: <8762y6dmat.fsf@lola.goethe.zz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2010-09-16 at 12:18 +0200, David Kastrup wrote:
> Armin Steinhoff <armin@steinhoff.de> writes:
> 
> > Hi all,
> >
> > yes, it's running !
> >
> > TinyCore is very small (10MB) , works with the PREEMPT_RT patch (at
> > least version 2.6.29.6), full SMP support and boots in few seconds!
> > The MicroCore version needs only 6MB ...
> 
> Anybody else nostalgic about the times where it took around 10kB to host
> a realtime multi-tasking operating system including self-hosting target
> compiler?
> 
> And the challenge was to fit bootstrap loader and operating system on
> one track of the floppy disk?
> 
> Heck, the first UNIXes I used regularly were quite workable with 4MB of
> main memory.

Heh, my first ram weighed ~160 lbs per 512KB, high speed/low drag 4 wire
technology, 2 us cycle time, dual or quad ported for your SMP pleasure.

(a real bargain at slightly under $1000/lb)

> I'll go back hide under my rock again.  Thanks for listening.

Ditto :)

	-Mike

