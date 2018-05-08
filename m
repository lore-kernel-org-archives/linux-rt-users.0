Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-io0-f194.google.com ([209.85.223.194]:46903 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbeEHPzQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 May 2018 11:55:16 -0400
Received: by mail-io0-f194.google.com with SMTP id f21-v6so38937019iob.13
        for <linux-rt-users@vger.kernel.org>; Tue, 08 May 2018 08:55:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507131505.tv6qz4rzvya5o3no@linutronix.de>
References: <CALC81-sg=86AZgZv4bGSNPJEmw3r_j=yNv5HuGPBWKMYVoXJ1A@mail.gmail.com>
 <20180507131505.tv6qz4rzvya5o3no@linutronix.de>
From: Iain Hunter <drhunter95@gmail.com>
Date: Tue, 8 May 2018 16:55:15 +0100
Message-ID: <CALC81-uM_23mu-EGhGSrW=-yUpZh+f_-hQQ=7Xa1Ka3mKygObQ@mail.gmail.com>
Subject: Re: RT Patch and Xen
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 7 May 2018 at 14:15, Sebastian Andrzej Siewior <bigeasy@linutronix.de> w=
rote:
> On 2018-04-30 12:05:52 [+0100], Iain Hunter wrote:
>> Hi,
> Hi,
>
>> I am using 4.9-rt1 on an Ultrascale+ device which is running Xen.
>
> I strongly suggest to use a more recent kernel.
>

Latest xilinx kernel is 4.14

>>
>> By default whenever I enable RT Linux then Xen is disabled according
>> to the patch "arm64/xen: Make XEN depend on !RT" in
>>
>> https://marc.info/?l=3Dlinux-rt-users&m=3D144509814328860&w=3D2
>>
>>
>> Can someone explain the background to this patch (which appears to
>> still be in latest 4.14 development release)?
>>
>> Is it simply because Xen drivers in the kernel fail to build due to an
>> include file problem (which I have worked around)
>> Is there a fundamental stability problem on 64 bit ARM when RT Linux
>> is running in a DomU? Initial runs of cyclictest don=E2=80=99t show any.
>
> I can't find the history behind this. Speaking as of v4.16-RT it builds
> and I have no XEN setup.
> If CONFIG_DEBUG_PREEMPT, CONFIG_DEBUG_ATOMIC_SLEEP and lockdep isn't
> complaining then I might drop that patch with your tested-by :)
>

Is your suggestion that I try just dropping the restriction in the
patch on CONFIG_PREEMPT_RT_FULL and just see if it works?
If it is I will try on 4.14 with latest RT patch as I'd rather stick
with an official Xilinx release.

Thanks, Iain
>> Thanks,
>>
>> Iain
>
> Sebastian
