From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Subject: Re: Some benchmark results
Date: Mon, 25 Aug 2014 16:14:11 +0200
Message-ID: <1657147.MGSNxR1uXh@bs8>
References: <53FAFBA8.3050009@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58870 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbaHYOOT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 10:14:19 -0400
In-Reply-To: <53FAFBA8.3050009@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Montag, 25. August 2014, 11:02:32 schrieb Daniel Wagner:
> Hi,
> 
> I wanted to know how good or bad mainline vs RT is, therefore I let
> MMTests torture my laptop for a while. I selected a few of the supported
> benchmarks by MMTests in order to keep to a reasonable time frame.
> 
> The aim was to see the impact of normal (no RT) workloads with different
> preempt configurations on mainline and RT patched kernel. I tried to not
> to change other configuration flags except the preempt one. There are
> some small difference due to dependencies but the rest looks ok to me.
> 
> http://www.monom.org/rt/mmtests/
> 
> Suggestion, improvements, comments?
> 
> cheers,
> daniel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi Daniel,

I had a first look at the above mentioned page.

The thing I'am complety missing in the huge amount of numbers is: What is your 
demand, your primary topic to solve in or with RT?
And as I interprete the numbers: a RT kernel is a little bit more CPU-hungry 
then normal and this is nothing new.
---

Until now it's usual to characterize RT performance in terms of (missed) 
maximum latencies.

You define your specialized workload, run it with RT priorities and check if 
it fits its demands. BTW you can verify and document this over the lifetime of 
your hardware/software combination.
If misses happen it is mostly possible to track the problem down to the 
culprit piece of soft- or hardware. If so, an iteration process starts 
hopefully before real damage happens.

A measure to "stress" your workload in a conceptional phase is putting more or 
less unrelated software on your machine until you quasi saturate their 
ressources (I/O, interrupt, drivers, schedulers, CPU, memory, network). If 
your primary workload survives you'll get a much better feeling but still no 
guarantees.

Next is to understand and accept that certain parts even of a RT kernel are 
_not_ designed to guarantee limited latencies (memory allocation, disk-IO, 
suspend-resume comes to mind). If you trigger them in your RT task: back to 
start. If you trigger them elsewhere: perhaps it still works.

I hope this helps to understand the situation a little bit better.
Nevertheless thanks for the patience to do and document all the tests.


Bernhard
