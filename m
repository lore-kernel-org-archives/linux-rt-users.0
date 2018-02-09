From: "t-v.k@gmx.net" <t-v.k@gmx.net>
Subject: Re: Building the Raspberry Pi kernel with RT PREEMPT
Date: Fri, 9 Feb 2018 12:16:48 +0100
Message-ID: <8fdb37b4-1c38-fd6a-2cc9-c2bf7fddd036@gmx.net>
References: <e5469b0b-fc0e-95b1-0a80-69a6afab3f12@gmx.net>
 <5367606.tDxCejrBfR@ada>
 <trinity-5732b42c-ae56-43bf-8369-571fb16fd685-1518106786845@3c-app-gmx-bs70>
 <8999c4a9-7389-3335-1175-935cc79d7abe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Alexander Dahl <ada@thorsis.com>,
        Mirza Krak <mirza.krak@gmail.com>,
        Roland Hieber <r.hieber@pengutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:55141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbeBILQy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Feb 2018 06:16:54 -0500
In-Reply-To: <8999c4a9-7389-3335-1175-935cc79d7abe@pengutronix.de>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey,

the commit that I checked out was from the raspberrypi kernel
repository, but it does indeed not have the 'bcm2709_defconfig':
https://github.com/raspberrypi/linux/tree/a16134b082346b7e7c34f594a0763eafacdcea92/arch/arm/configs
The problem is that when that file was added, the branch was at 4.14.17
already. But as I said, I need 4.14.15. :/
Maybe I could just use the old 4.14.15 commit and add that one file from
the 4.14.17 state?

 - T-vK

On 02/09/2018 11:35 AM, Roland Hieber wrote:
> Hi,
> 
> the bcm2709_defconfig is an addition of the Raspberry Pi version of the
> kernel, and is therefore not available in the upstream 4.4.15 commit you
> checked out.
> 
>  - Roland
> 
> On 08.02.2018 17:19, t-v.k@gmx.net wrote:
>> Thanks for the answers!
>>
>> I'll need a DE in the end so I'll probably have to stick with the
>> Raspberry Pi kernel.
>> Also, I would like to have a very recent kernel. I'm using a Raspberry
>> Pi 3 Model B btw.
>> I think the issue with my patching was that I applied the patches for
>> '4.14.15-rt13' while the 'rpi-4.14.y' branch from the Raspberry Pi
>> kernel was a bit ahead (~4.14.17).
>> I went back in the commit history and found a commit that literally
>> said 'Linux 4.14.15', then I changed my script to check that out
>> instead of 'rpi-4.14.y'.
>> Now the patches apply successfully:
>> https://gitlab.com/T-vK/rpi-rt-kernel/-/jobs/51703707
>> But as you can see there is another issue now. 'make
>> bcm2709_defconfig' doesn't work:
>>> Can't find default configuration "arch/arm/configs/bcm2709_defconfig"!
>>
>> T-vK
>>     On 07 February 2018 at 08:55, "Alexander Dahl" <ada@thorsis.com>
>> wrote:
>>
>> Am Mittwoch, 7. Februar 2018, 00:02:52 CET schrieb t-v.k@gmx.net:
>>> this is my first time on a mailing list. I'm not sure how this works.
>>
>> You write to the list address, everyone also subscribed gets your mail,
>> including you. Some people will set you in Cc additionally.
>>
>>> I'm currently trying to automate the build of a Linux kernel with the RT
>>> PREEMPT patch. The kernel that I'm trying to build is in this git
>>> repository: https://github.com/raspberrypi/linux (branch rpi-4.14.y)
>>>
>>> It's the official kernel for the Raspberry Pi.
>>
>> Yes, and it has some patches on top of the upstream vanilla kernel, IIRC
>> around 200 the last time a looked at it.
>>
>>> But at the moment I am stuck. There are two problems. When I apply the
>>> patch "patch-4.14.15-rt13.patch.gz", I get errors like:
>>>
>>> Hunk #9 FAILED at 795.
>>> ...
>>> 1 out of 20 hunks FAILED -- saving rejects to file kernel/softirq.c.rej
>>> ...
>>>
>>> and as a result of this it exits with code 1.
>>>
>>> Here is the full build process output:
>>> https://gitlab.com/T-vK/rpi-rt-kernel/-/jobs/51343435[https://gitlab.com/T-vK/rpi-rt-kernel/-/jobs/51343435]
>>>
>>>
>>> When I just ignore it and continue I get to the point where I can run
>>> "make zImage", which then fails with this:
>>
>> This makes no sense, the patch must apply. You don't want to build
>> anything
>> with a half applied patch.
>>
>>> Can anyone help me with these issues?
>>
>> If you're on v4.14 anyway, I would recommend to run a vanilla kernel
>> and put
>> the RT patch(es) on top. At least for a system without graphics, this
>> should
>> work. (I had a RPi 1B running with vanilla v4.12 built with ptxdist
>> and the
>> DistroKit BSP some time ago, v4.14 and v4.15 also run fine headless.
>> Should
>> also work for RPi 2.)
>>
>> HTH & Greets
>> Alex
>>   --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
