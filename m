From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Improving ARM7 platform performance with CONFIG_PREEMPT_RT
Date: Wed, 12 Sep 2012 13:39:00 +0200
Message-ID: <50507454.2030607@osadl.org>
References: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:46279 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112Ab2ILLlJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Sep 2012 07:41:09 -0400
In-Reply-To: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hartmut,

> I have patched a 3.2 kernel for a OMAP compatible processor (ARM
> Cortex A8) to be used on an Gumstix Overo with the CONFIG_PREEMPT_RT
> patch.
>
> I have noticed that the latency of the patched kernel on this platform
> is<300usec (using cyclictest), similar to what is reported for the
> ARM9 platforms at
> https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch
>
> Is this the best performance that can be expected from ARM7/9 platforms?
No, some of them have latencies below 100 us.

For a comparison of the various ARM platforms, revisions and versions, 
you may refer to the OSADL QA Farm.

Relatively long latencies (this is a know CPU cache issue):
- Rack #2, Slot #1
   ARM926EJ-S rev 4 (v5l), Phytec/phyCARD-i.MX27
   Latency plot -> https://www.osadl.org/?id=990
- Rack #2, Slot #2
   ARMv7 rev 3 (v7l), Phytec/phyCARD-L OMAP3525
   Latency plot -> https://www.osadl.org/?id=988

Short latencies:
- Rack #0, Slot #5
   ARMv7 rev 5 (v7l), Freescale/MX53 Quickstart Board (LOCO)
   Latency plot -> https://www.osadl.org/?id=1351
- Rack #1, Slot #7
   ARMv6-compatible rev 3 (v6l), (undisclosed)
   Latency plot -> https://www.osadl.org/?id=1335
- Rack #2, Slot #3
   ARMv7 rev 7 (v7l), Texas Instruments/OMAP3517/AM3517 EVM
   Latency plot -> https://www.osadl.org/?id=887
- Rack #2, Slot #8
   ARMv6-compatible rev 3 (v6l), Phytec/PhyCARD-M pca101
   Latency plot -> https://www.osadl.org/?id=920
- Rack #4, Slot #4
   ARMv7 Processor rev 10 (v7l)x2, Texas Instruments OMAP4/Pandaboard
   Latency plot -> https://www.osadl.org/?id=911
- Rack #5, Slot #5
   Feroceon 88FR131 rev 1 (v5l), Marvell/SheevaPlug
   Latency plot -> https://www.osadl.org/?id=881

> Could it be improved by using different kernel config settings - e.g.
> CONFIG_LATENCY_TRACE=n  -
> https://rt.wiki.kernel.org/index.php/Cyclictest mentions that latency
> tracing adds significant kernel overhead?
CONFIG_LATENCY_TRACE no longer is a valid kernel configuration item. But 
even if you configure a valid tracing configuration, this will not lead 
to a relevant increase of the system's latencies, since tracing must 
explicitly be enabled to become effective, such as
# echo <your tracer here> >/sys/kernel/debug/tracing/current_tracer
or using cyclictest's trace options.

Of course, a particular kernel config may lead to long latencies. To 
check your kernel configuration, you may compare it to the kernel 
configurations of the OSADL QA Farm systems that are given at the bottom 
of the system profiles, the overview is here -> 
https://www.osadl.org/?id=1084.

Hope this helps,
	-Carsten.
