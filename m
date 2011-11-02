From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: Latency problem
Date: Wed, 2 Nov 2011 11:28:47 -0500
Message-ID: <CAFQPvXdHr2Vq5bOwNt8z8yd8nm-i3nz5VNUqymduPHKa9kgASA@mail.gmail.com>
References: <CAE_Gge02PZyZ93wSyH8uSJAQ6wdZRqG-L-qumV23g4Tam7BUmQ@mail.gmail.com>
	<1319741477.6197.26.camel@marge.simson.net>
	<CAE_Gge3nBE4_Jm39qnVz_6ieBpJL6b9qNd41snW=6bi9cggm3g@mail.gmail.com>
	<1319777643.6150.7.camel@marge.simson.net>
	<CAFQPvXch7YqaRdhtzhf5j1vLsGEGFhZc7idA0aWrcfCdotz3kg@mail.gmail.com>
	<CAE_Gge2hbE0Shg4NrNvYswCDHhgAEwZsSUACuM5Tsmt8CqCP=g@mail.gmail.com>
	<CAE_Gge3z2zMnSqUEssbNwCFO-ZmqPOLz2-xBJHKtLMFaxHsHfg@mail.gmail.com>
	<CAFQPvXcyLpisRJ11=-5w7tSwN+A+oKYc_ExGCYSZxMov1-zHxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47881 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338Ab1KBQ2s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Nov 2011 12:28:48 -0400
Received: by vcge1 with SMTP id e1so314593vcg.19
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Nov 2011 09:28:47 -0700 (PDT)
In-Reply-To: <CAFQPvXcyLpisRJ11=-5w7tSwN+A+oKYc_ExGCYSZxMov1-zHxg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2011/11/2 Sankara Muthukrishnan <sankara.m@gmail.com>:
>
>
> 2011/11/1 Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
>>
>> Thank you very much for your answers.
>>
>> > The hwlatdetect application detects system management interrupts
>> > (SMIs). Such interrupts are installed by the BIOS and are used to =
manage
>> > various things such as battery management, overheat protection and
>> > emulation of legacy devices (e.g. IDE, PS/2 etc.). You may try to =
check
>> > your BIOS settings and disable all these or similar features.
>>
>> In fact, after disabling almost all features in the bios, the proble=
m
>> is still here but a little bit reducted (there is just about 20ms
>> latency now.. I think it's linked to the fact the thermal controller
>> is disabled). But I didn't find any reference to SMIs in the bios,
>> neither in the motherboard documentation (Supermicro X7DAL). The
>> computer was not bought for doing realtime, so if it isn't working I
>> think I'll change the computer to use one which has good latency
>> during the tests.
>>
>> > One way to find out whether the spikes in the latency are due to
>> > SMI(System Management Interrupt) is to read the MSR register that
>> > keeps the count of SMIs. So, read the MSR in the start of the test
>> > program and the end of the test and see whether the count has
>> > increased. Unfortunately, it is model-specific-register and I am n=
ot
>> > sure whether AMD supports it. I don't think all Intel processors
>> > support it either. I know that Nehalem based Intel Core-i7 arranda=
le
>> > processor supports counting SMI thru MSR 0x34 and I have not found=
 it
>> > documented in any Intel documentation but found in some reference =
BIOS
>> > source. I have tested it with legacy USB interrupts and found it t=
o
>> > work. RDMSR is a privilege-0 instruction though.
>>
>> 0x34 is not working for me, it's not returning anything (just that h=
e
>> can't read)
>> > root@station9:/home/xaf/RT# rdmsr 0x34
>> > rdmsr: CPU 0 cannot read MSR 0x00000034
>> The CPU I use here are two Intel(R) Xeon(R) CPU =A0E5405 @ 2.00GHz, =
and
>> I am unable to find any documentation about the results of MSR to kn=
ow
>> what argument I must use to see the number of SMIs. I'll investigate
>> more on this...
>>
>> Thanks one more time !
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

If you are building your own kernel, you can try to disable some SMI
sources, even if BIOS does not have an option to disable that. [Note:
Most BIOSes provide more options to configure only in their
development version and not in the release version]. However, you need
to be cautious about what SMIs you are turning off and what the
consequences of turning them off are. Again, I don't know what the
chipset you are using.=A0 To give you an idea, for SMI on ICH9, search
for GLB_SMI_EN bit=A0 and SMI_LOCK in
http://www.intel.com/assets/pdf/datasheet/316972.pdf

Regarding MSR for SMI, like I said, that is specific to CPU
architectures and CPUs. I tried to find where I got that information
for arrandale processors. It is at http://biosbits.org/download/. You
may have to find out or ask the manufacturer whether SMI counter is
supported and what the MSR is. Good luck.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
