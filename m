From: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: Question regarding RT patches for ARM
Date: Wed, 17 May 2017 15:40:10 +0200
Message-ID: <CAGgoGu4LHrZJHzwBFgpEYCzBRtH24N_Y1UUspkoZJKPPdQmuvQ@mail.gmail.com>
References: <CAGgoGu6=EKCkzbZ0=i+4e+9rJUvxG-SUix1AQVch8VF=OmokVw@mail.gmail.com>
 <3aa42082.b247.15c0c29ca5e.Coremail.qiledexin@163.com> <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
 <646e1a43-78a7-3d04-ee29-1299b7d9d4d8@nelint.com> <CAGgoGu7z1KUve8G_Ld_Yk-1umDq1qO=HCw2vjMuU=YXqxzt0tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: GuJiangfei <qiledexin@163.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-rt-users@vger.kernel.org
To: Eric Nelson <eric@nelint.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34805 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753774AbdEQNkc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 May 2017 09:40:32 -0400
In-Reply-To: <CAGgoGu7z1KUve8G_Ld_Yk-1umDq1qO=HCw2vjMuU=YXqxzt0tA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,


On 15 May 2017 at 16:20, Fawad Lateef <fawadlateef@gmail.com> wrote:
> Hi Eric,
>
>
> On 15 May 2017 at 16:12, Eric Nelson <eric@nelint.com> wrote:
>> Hi Fawad,
>>
>>> =E5=8F=91=E8=87=AA=E7=BD=91=E6=98=93=E9=82=AE=E7=AE=B1=E5=A4=A7=E5=B8=
=88
>>> On 05/15/2017 20:44, Fawad Lateef wrote:
>>>
>>> Hi All,
>>>
>>> I am working on custom i.MX6 quad hardware and using RT patches for
>>> almost latest stable kernel 4.9 and facing some weird system stall OR
>>> 'unhandled page fault - exceptions'.
>>>
>>
>> I'm not sure about the unhandled page fault, but the stalls may be
>> because of the SDMA driver.
>>
>> See this patch in the Freescale/NXP community for kernel 4.1:
>> https://github.com/Freescale/meta-freescale/blob/master/recipes-kernel/l=
inux/linux-fslc-imx-rt/0003-Work-around-CPU-stalls-in-the-imx-sdma-driver.p=
atch
>>
>
> Thanks for the patch link. I will give it a try.

Talked to hardware manufacturer and they applied the patch.

Still that SDMA is only used for NOR flash and only u-boot and its
environment are stored in nor flash. So not sure if that is going to
help in any case.

So I would really like few more suggestions OR confirmations about ARM
(cortex-A9 based imx6) (preemept)-RT support/patches are stable and
can be used for final products.

Thanks

>
>> Regards,
>>
>>
>> Eric
>
> Regards,
>
> Fawad Lateef
