From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: Latency problem
Date: Tue, 1 Nov 2011 16:24:20 -0500
Message-ID: <CAFQPvXch7YqaRdhtzhf5j1vLsGEGFhZc7idA0aWrcfCdotz3kg@mail.gmail.com>
References: <CAE_Gge02PZyZ93wSyH8uSJAQ6wdZRqG-L-qumV23g4Tam7BUmQ@mail.gmail.com>
	<1319741477.6197.26.camel@marge.simson.net>
	<CAE_Gge3nBE4_Jm39qnVz_6ieBpJL6b9qNd41snW=6bi9cggm3g@mail.gmail.com>
	<1319777643.6150.7.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38897 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab1KAVYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Nov 2011 17:24:22 -0400
Received: by vws1 with SMTP id 1so414491vws.19
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Nov 2011 14:24:21 -0700 (PDT)
In-Reply-To: <1319777643.6150.7.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2011/10/27 Mike Galbraith <efault@gmx.de>:
> On Thu, 2011-10-27 at 15:03 -0400, Rapha=EBl Beamonte wrote:
>
>> Moreover, the use of hwlatdetect seems to confirm that the problem i=
s
>> from hardware.
>
> Yeah, skimmed over your message too quick, thinking nsecs instead of
> usecs. =A0Probably SMIs.
>
> =A0 =A0 =A0 =A0-Mike
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

One way to find out whether the spikes in the latency are due to
SMI(System Management Interrupt) is to read the MSR register that
keeps the count of SMIs. So, read the MSR in the start of the test
program and the end of the test and see whether the count has
increased. Unfortunately, it is model-specific-register and I am not
sure whether AMD supports it. I don't think all Intel processors
support it either. I know that Nehalem based Intel Core-i7 arrandale
processor supports counting SMI thru MSR 0x34 and I have not found it
documented in any Intel documentation but found in some reference BIOS
source. I have tested it with legacy USB interrupts and found it to
work. RDMSR is a privilege-0 instruction though.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
