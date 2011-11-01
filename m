From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: Latency problem
Date: Tue, 1 Nov 2011 18:12:07 -0400
Message-ID: <CAE_Gge3z2zMnSqUEssbNwCFO-ZmqPOLz2-xBJHKtLMFaxHsHfg@mail.gmail.com>
References: <CAE_Gge02PZyZ93wSyH8uSJAQ6wdZRqG-L-qumV23g4Tam7BUmQ@mail.gmail.com>
 <1319741477.6197.26.camel@marge.simson.net> <CAE_Gge3nBE4_Jm39qnVz_6ieBpJL6b9qNd41snW=6bi9cggm3g@mail.gmail.com>
 <1319777643.6150.7.camel@marge.simson.net> <CAFQPvXch7YqaRdhtzhf5j1vLsGEGFhZc7idA0aWrcfCdotz3kg@mail.gmail.com>
 <CAE_Gge2hbE0Shg4NrNvYswCDHhgAEwZsSUACuM5Tsmt8CqCP=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63118 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab1KAWM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Nov 2011 18:12:28 -0400
Received: by ywf7 with SMTP id 7so2693157ywf.19
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Nov 2011 15:12:28 -0700 (PDT)
In-Reply-To: <CAE_Gge2hbE0Shg4NrNvYswCDHhgAEwZsSUACuM5Tsmt8CqCP=g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you very much for your answers.

> The hwlatdetect application detects system management interrupts
> (SMIs). Such interrupts are installed by the BIOS and are used to man=
age
> various things such as battery management, overheat protection and
> emulation of legacy devices (e.g. IDE, PS/2 etc.). You may try to che=
ck
> your BIOS settings and disable all these or similar features.

In fact, after disabling almost all features in the bios, the problem
is still here but a little bit reducted (there is just about 20ms
latency now.. I think it's linked to the fact the thermal controller
is disabled). But I didn't find any reference to SMIs in the bios,
neither in the motherboard documentation (Supermicro X7DAL). The
computer was not bought for doing realtime, so if it isn't working I
think I'll change the computer to use one which has good latency
during the tests.

> One way to find out whether the spikes in the latency are due to
> SMI(System Management Interrupt) is to read the MSR register that
> keeps the count of SMIs. So, read the MSR in the start of the test
> program and the end of the test and see whether the count has
> increased. Unfortunately, it is model-specific-register and I am not
> sure whether AMD supports it. I don't think all Intel processors
> support it either. I know that Nehalem based Intel Core-i7 arrandale
> processor supports counting SMI thru MSR 0x34 and I have not found it
> documented in any Intel documentation but found in some reference BIO=
S
> source. I have tested it with legacy USB interrupts and found it to
> work. RDMSR is a privilege-0 instruction though.

0x34 is not working for me, it's not returning anything (just that he
can't read)
> root@station9:/home/xaf/RT# rdmsr 0x34
> rdmsr: CPU 0 cannot read MSR 0x00000034
The CPU I use here are two Intel(R) Xeon(R) CPU =A0E5405 @ 2.00GHz, and
I am unable to find any documentation about the results of MSR to know
what argument I must use to see the number of SMIs. I'll investigate
more on this...

Thanks one more time !
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
