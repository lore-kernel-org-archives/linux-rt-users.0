From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Latency difference between posix & non-posix timer
Date: Wed, 15 Feb 2017 18:12:25 +0100
Message-ID: <20170215171225.unyjy4ivykrfpnj6@linutronix.de>
References: <CAJ2oMhLAwf7AEjOGLTx9Lhd0DVH1Psd-rmOoQkiKVTAiVaDXMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48102 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdBORM1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2017 12:12:27 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMhLAwf7AEjOGLTx9Lhd0DVH1Psd-rmOoQkiKVTAiVaDXMQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-05 19:11:01 [+0200], Ran Shalit wrote:
> Hello,
Hi,

> We made some testing on out cpu, installed with 4.1.15-rt17 kernel,
> and we observed significant difference in latency between posic to
> non-posix cyclictest benchmark.
> 
> with non posix we reach max ~50usec
> while with posix we reach max ~170usec
> 
> On checking the exaples in cyclic test wiki, it seems that the
> difference should not be that big :
> https://rt.wiki.kernel.org/index.php/Cyclictest
> 
> What is the reason for such difference in behaviour ?
> Does it mean we better use non-posix timer in application ?
As written in the other thread (regarding posix-timer):
I tested today v4.9-RT and didn't notice such high spikes between
clock_nanosleep and the posix timer. You have the consider that the
wakeup happens from ktimersoftirq so you have one additional context
switch here.
I general the clock_nansleep interface should be preferred if possible
to avoid that ctx switch.

Sebastian
