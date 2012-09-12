From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: Re: Improving ARM7 platform performance with CONFIG_PREEMPT_RT
Date: Wed, 12 Sep 2012 20:50:31 +0200
Message-ID: <CA+69FtBs63aXUmrF-z2Lwt-G5Z2Xw9u12aF0orbamDi-sX0Nwg@mail.gmail.com>
References: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
	<50507454.2030607@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51168 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760578Ab2ILSuc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Sep 2012 14:50:32 -0400
Received: by oago6 with SMTP id o6so1237363oag.19
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Sep 2012 11:50:31 -0700 (PDT)
In-Reply-To: <50507454.2030607@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you - that did the trick.

By disabling  CONFIG_OMAP_32K_TIMER and the "frequency scaling power
saving stuff" I now have an average latency around 26usec and max
around 40usec.


On Wed, Sep 12, 2012 at 1:39 PM, Carsten Emde <C.Emde@osadl.org> wrote:
> Hartmut,
>
>
>> I have patched a 3.2 kernel for a OMAP compatible processor (ARM
>> Cortex A8) to be used on an Gumstix Overo with the CONFIG_PREEMPT_RT
>> patch.
>>
>> I have noticed that the latency of the patched kernel on this platform
>> is<300usec (using cyclictest), similar to what is reported for the
>> ARM9 platforms at
>> https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch
>>
>> Is this the best performance that can be expected from ARM7/9 platforms?
>
> No, some of them have latencies below 100 us.
>
> For a comparison of the various ARM platforms, revisions and versions, you
> may refer to the OSADL QA Farm.
>
> Relatively long latencies (this is a know CPU cache issue):
> - Rack #2, Slot #1
>   ARM926EJ-S rev 4 (v5l), Phytec/phyCARD-i.MX27
>   Latency plot -> https://www.osadl.org/?id=990
> - Rack #2, Slot #2
>   ARMv7 rev 3 (v7l), Phytec/phyCARD-L OMAP3525
>   Latency plot -> https://www.osadl.org/?id=988
>
> Short latencies:
> - Rack #0, Slot #5
>   ARMv7 rev 5 (v7l), Freescale/MX53 Quickstart Board (LOCO)
>   Latency plot -> https://www.osadl.org/?id=1351
> - Rack #1, Slot #7
>   ARMv6-compatible rev 3 (v6l), (undisclosed)
>   Latency plot -> https://www.osadl.org/?id=1335
> - Rack #2, Slot #3
>   ARMv7 rev 7 (v7l), Texas Instruments/OMAP3517/AM3517 EVM
>   Latency plot -> https://www.osadl.org/?id=887
> - Rack #2, Slot #8
>   ARMv6-compatible rev 3 (v6l), Phytec/PhyCARD-M pca101
>   Latency plot -> https://www.osadl.org/?id=920
> - Rack #4, Slot #4
>   ARMv7 Processor rev 10 (v7l)x2, Texas Instruments OMAP4/Pandaboard
>   Latency plot -> https://www.osadl.org/?id=911
> - Rack #5, Slot #5
>   Feroceon 88FR131 rev 1 (v5l), Marvell/SheevaPlug
>   Latency plot -> https://www.osadl.org/?id=881
>
>
>> Could it be improved by using different kernel config settings - e.g.
>> CONFIG_LATENCY_TRACE=n  -
>> https://rt.wiki.kernel.org/index.php/Cyclictest mentions that latency
>> tracing adds significant kernel overhead?
>
> CONFIG_LATENCY_TRACE no longer is a valid kernel configuration item. But
> even if you configure a valid tracing configuration, this will not lead to a
> relevant increase of the system's latencies, since tracing must explicitly
> be enabled to become effective, such as
> # echo <your tracer here> >/sys/kernel/debug/tracing/current_tracer
> or using cyclictest's trace options.
>
> Of course, a particular kernel config may lead to long latencies. To check
> your kernel configuration, you may compare it to the kernel configurations
> of the OSADL QA Farm systems that are given at the bottom of the system
> profiles, the overview is here -> https://www.osadl.org/?id=1084.
>
> Hope this helps,
>         -Carsten.
