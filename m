From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.33.7-rt29 PREEMPT_RT worse latency than PREEMPT_DESKTOP on
 AT91?
Date: Wed, 15 Sep 2010 18:08:27 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1009151805540.2416@localhost6.localdomain6>
References: <4C72A438.2080301@cgglobal.com>     <alpine.LFD.2.00.1008271234300.2768@localhost.localdomain> <4C90E959.80306@cgglobal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Agustin Ferrin Pozuelo <agustin.ferrin@cgglobal.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:40802 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701Ab0IOQIf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 12:08:35 -0400
In-Reply-To: <4C90E959.80306@cgglobal.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 15 Sep 2010, Agustin Ferrin Pozuelo wrote:
>  On 27/08/10 11:35, Thomas Gleixner wrote:
> > On Mon, 23 Aug 2010, Agustin Ferrin Pozuelo wrote:
> Sorry, my test setup is not very comprehensive at the moment. I have some
> overnight/overweekend results at hand with millions of loops:
> 
>     PREEMPT-DESKTOP:
>     root@at91sam9263cpc:~# time cyclictest -i 70000 -p 80 -h 700 -r

Oh, you are running cyclictest with a signal based timer and relative
time. Any reason for this ?

What happens if you change the command line to

   cyclictest -i 70000 -p 80 -n

> I am assuming context switching is more expensive on PREEMPT-RT under ARM9,
> where it seems already a bit expensive.

No, the context switch is equally expensive, but signal delivery might
be a bit more overhead on -RT

Thanks,

	tglx
