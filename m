From: Lukasz Majewski <majess1982@gmail.com>
Subject: Re: [linux-2.6.26.8-rt14] RT Page Fault.
Date: Mon, 23 Feb 2009 17:21:36 +0100
Message-ID: <49A2CD10.4080605@gmail.com>
References: <49A1BA49.7060308@gmail.com> <3efb10970902221329h89b18cbl60c8d3365009e2d9@mail.gmail.com> <49A1D930.4010600@gmail.com> <20090223124016.GH5367@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:2819 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204AbZBWQVl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 11:21:41 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1200937mue.1
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Feb 2009 08:21:38 -0800 (PST)
In-Reply-To: <20090223124016.GH5367@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Robert.

I'm building toolchain for AT572D940HF Atmel chip. It's ARM9 combined 
with DSP. I'd like to build toolchain for ARM9 (ARMv5tej) with 
-msoft-float support, EABI and full glibc ,to support all stuff 
connected with PREEMPT_RT patch - especially librt.

Now I've downloaded:
ptxdist-1.99.11 and ptxdist-1.99.11-patches.

and
OSELAS.Toolchain-1.99.3

I've selected 
./ptxconfigs/arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized

I need toolchain with -msoft-float support and EABI.

Unfortunately there is an error about mismatch in the linux-kernel 
headers. My Host PC has linux-kernel of 2.6.24 and not 2.6.27. My target 
is working under 2.6.26.8-rt14 kernel.
The error is in building of NTPL library, after successfully compilation 
of gcc compiler.

How can I provide proper kernel headers?

Now I'm trying with 
arm-v5te-linux-gnueabi-gcc-4.1.2-glibc-2.5-binutils-2.17-kernel-2.6.18 
ptxconfig. I hope that this will be sufficiently new to provide priority 
inheritance, futexes , librt with all features.

I'm building it now and hope that I won't encounter any problems.


Regards,
Lukasz

Robert Schwebel wrote:
> On Mon, Feb 23, 2009 at 12:01:04AM +0100, Lukasz Majewski wrote:
>   
>> Now some explanation about uClibc. I know that this C library lacks of
>> many features (for instance NTPL support for ARM). Unfortunately, for
>> ARM architecture, there is nice utility -> buildroot  for building
>> toolchain and  root filesystems.
>>     
>
> You can use ptxdist do do almost the same.
>
>   
>> I've tried pxtdist tool from pengutronix.de, but I cannot build proper
>> toolchain without errors for my Atmel's ARM9 device (ARMv5tej arch to be
>> precise). Or saying it in another way -> I gave up after spending some
>> time and moved back toward working uClibc.
>>     
>
> Well, you could have reported that to the OSELAS.Toolchain maintainers :)
>
> What kind of problem do you see? We are using the the v5te toolchain
> quite intensively on AT91SAM9260 and AT91SAM9263 without problems.
>
> So send us your error output and let's see what we can do. The ptxdist
> mailing list is probably the right list for that kind of discussion.
>
> rsc
>   

