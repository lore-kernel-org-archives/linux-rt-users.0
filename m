From: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: Question regarding RT patches for ARM
Date: Thu, 18 May 2017 13:08:32 +0200
Message-ID: <CAGgoGu7qJegvp8o_33rfVbSWHNH8N4bbiTORXJYziRvKB9=O3w@mail.gmail.com>
References: <CAGgoGu6=EKCkzbZ0=i+4e+9rJUvxG-SUix1AQVch8VF=OmokVw@mail.gmail.com>
 <3aa42082.b247.15c0c29ca5e.Coremail.qiledexin@163.com> <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
 <646e1a43-78a7-3d04-ee29-1299b7d9d4d8@nelint.com> <CAGgoGu7z1KUve8G_Ld_Yk-1umDq1qO=HCw2vjMuU=YXqxzt0tA@mail.gmail.com>
 <CAGgoGu4LHrZJHzwBFgpEYCzBRtH24N_Y1UUspkoZJKPPdQmuvQ@mail.gmail.com>
 <c0fc9f9b-ae0b-66d3-71c7-e2b98f6900e0@nelint.com> <20170517160213.go3fiyhf5vmr7bmj@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Eric Nelson <eric@nelint.com>, GuJiangfei <qiledexin@163.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170517160213.go3fiyhf5vmr7bmj@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,


On 17 May 2017 at 18:02, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-05-17 07:45:39 [-0700], Eric Nelson wrote:
>> Hi Fawad,
> Hi Fawad,
>
>> On 05/17/2017 06:40 AM, Fawad Lateef wrote:
>> > > > I'm not sure about the unhandled page fault, but the stalls may be
>> > > > because of the SDMA driver.
>> > > >
>> > > > See this patch in the Freescale/NXP community for kernel 4.1:
>> > > > https://github.com/Freescale/meta-freescale/blob/master/recipes-kernel/linux/linux-fslc-imx-rt/0003-Work-around-CPU-stalls-in-the-imx-sdma-driver.patch
>
> That is something I see for the first time. The description says that it
> leads to this stall but it fails to explain _how_ it got there.
>
>> > > Thanks for the patch link. I will give it a try.
>> >
>> > Talked to hardware manufacturer and they applied the patch.
>> >
>> > Still that SDMA is only used for NOR flash and only u-boot and its
>> > environment are stored in nor flash. So not sure if that is going to
>> > help in any case.
>> >
>>
>> SDMA is used for much more than NOR flash (SSI, USB, and sometimes
>> UARTs).
>>
>> > So I would really like few more suggestions OR confirmations about ARM
>> > (cortex-A9 based imx6) (preemept)-RT support/patches are stable and
>> > can be used for final products.
>> >
>>
>> I don't have any experience with the RT patches on 4.9 or later
>> kernels, but do know that they're being used on i.MX6 with the
>> vendor kernels (3.10.x, 4.1.x).
>
> I just looked into a few boot logs and it seems the Phyflex board (imx6
> quad) bootet v4.9.27-rt18, run cyclictest including some tests and
> nothing produced this "unhandled page fault" you mention here. This
> includes the previous RT version in the v4.9 line.
>

Thanks, seems like RT patches are quite stable for ARM then.

> Of this "page fault" happens on boot, it has to do something without
> your .config + hw combination. If it happens at rune-time it is probably
> triggered by a driver or an application is triggering this.
>

Yes, this happens at run-time and not always. Sometimes hardware just
hangs/stalls.

As now RT is widely used on ARM so to me seems like it something
related to hardware design/setting OR application.

Another question: Is RT user-space application can make kernel/system
crash? As to me kernel should kill the app but let itself running
_but_ not sure in the case of RT patched kernel.

>> Regards,
>>
>>
>> Eric
>
> Sebastian

Thanks,

Fawad Lateef
