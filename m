Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-it1-f193.google.com ([209.85.166.193]:51096 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeJLJMx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Oct 2018 05:12:53 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so10422669ite.0
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Oct 2018 18:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAF_EZTMMAkxfCxjAVTJCqVHTUbPQNyUXDgbDk8xmGvp-hKdwcQ@mail.gmail.com>
 <20181005165525.vmgxqdyymcuc6xkd@linutronix.de> <CAF_EZTPTnxu5ZxMJsgk=K_Toe9MzNe1m_7gG32nfi_fFoyS6Bg@mail.gmail.com>
 <CAF_EZTMNMR-764_acuA1XGwStbGUonfJ8Qayda-Ge=s3E805EA@mail.gmail.com>
In-Reply-To: <CAF_EZTMNMR-764_acuA1XGwStbGUonfJ8Qayda-Ge=s3E805EA@mail.gmail.com>
From: Anup Pemmaiah <anup.pemmaiah@gmail.com>
Date: Thu, 11 Oct 2018 18:42:43 -0700
Message-ID: <CAF_EZTMUavf_yTLmvohwnksxZNqBQnVPYjMEzndw9DsdiS8aXg@mail.gmail.com>
Subject: Re: Floating point register corruption on ARM Cortex A57 (ARMv8) with
 RT_PREEMPT linux
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: sebastian.siewior@linutronix.de
Cc: linux-rt-users@vger.kernel.org

Just wanted to give a quick update. Since, I could not get a 4.18 BSP
from the vendor, I could not move to 4.18 kernel as they only release
BSP's for LTS releases. I did a diff of arch/arm64/kernel/fpsimd.c
between my 4.14 version and the 4.18. I did not port SVE part, but
just ported back the preempt_enable/preempt_disable in fpsimd* around
local_bh_enable/disable. With that fix, I do not see the floating
point corruption anymore.
On Sun, Oct 7, 2018 at 10:35 PM Anup Pemmaiah <anup.pemmaiah@gmail.com> wrote:
>
> Some more observations with RT_PREEMPT configs enabled.
>
> 1) I re-ran the tests disabling all crypto including NEON related
> crypto and EFI kernel config options. I still see randomly floating
> point register getting corrupted
>
> 2) I noticed that, when I run the tests with RT schedulers and RT
> priorities, eg: ("chrt -f 5 ./test_float" or "chrt -r 5
> ./test_float"),  I am not able  reproduce the corruption issue. But,
> when I run the tests (just ./test_float) without any RT scheduler and
> priority  (i.e SCHED_OTHER) can easily reproduce the issue.
>
> I tried disabling PREEMPT_LAZY, by "echo NO_PREEMPT_LAZY >
> /sys/kernel/debug/sched_features". It did not help and am able to
> reproduce the problem
>
> 3) I have another Cortex ARM A57 system from a different vendor(cannot
> name the vendors because of proprietary reasons) with Linux kernel
> version 4.9.38 and RT_PREEMPT enabled. I do not see any floating point
> corruption issue, even if I run the test as SCHED_OTHER or with real
> time settings. So, that tells me moving to 4.18 may not help. What do
> you think?
>
> Thanks
> Anup
> On Sun, Oct 7, 2018 at 9:58 AM Anup Pemmaiah <anup.pemmaiah@gmail.com> wrote:
> >
> > > nope, should work by default. Do you have NEON related crypto code or
> > > EFI enabled?
> >
> > Sebastian, Thank you for the comments. I have NEON related crypto code
> > enabled right now, but I remember disabling
> > it and it did not make a difference. I will disable it again and will
> > give it a try. In the mean time, when I disabled the following 4 lines
> > from the config file
> > and re-compiled the kernel, the test code works fine without the issue
> > described earlier related to floating point. Are you suspecting that
> > NEON related crypto interferes with real time kernel and not with non-rt kernel?
> >
> >
> >   # CONFIG_PREEMPT_RT_BASE=y
> >
> >   # CONFIG_HAVE_PREEMPT_LAZY=y
> >
> >   # CONFIG_PREEMPT_LAZY=y
> >
> >   # CONFIG_PREEMPT_RT_FULL=y
> >
> >
> > > Could you please try the latest v4.18? I believe it is fixed there and
> > > needs just backporting. Could you please try?
> >
> > I will try it as a last resort because I am not sure if the board BSP
> > supports v4.18. Right now, I am
> > trying to figure out, why it works fine with non-rt kernel and only
> > see the issue when the above four RT_PREEMPT config
> > options are turned on.
> >
> >
> > On Fri, Oct 5, 2018, 9:55 AM Sebastian Andrzej Siewior
> > <sebastian.siewior@linutronix.de> wrote:
> > >
> > > On 2018-10-04 19:12:53 [-0700], Anup Pemmaiah wrote:
> > > > 1) Is there any floating point related kernel setting that I should
> > > > set in the RT_PREEMPT kernel? I have set eagerfpu=on (even though it
> > > > is on by default)
> > >
> > > nope, should work by default. Do you have NEON related crypto code or
> > > EFI enabled?
> > >
> > > > 2) Was reading about "Lazy Stacking" for Cortex-M4, but not sure if it
> > > > applies for Cortex A57
> > > >
> > > > Any comments will be greatly appreciated.
> > >
> > > Could you please try the latest v4.18? I believe it is fixed there and
> > > needs just backporting. Could you please try?
> > >
> > >
> > > Sebastian
> >
> >
> > On Fri, Oct 5, 2018 at 9:55 AM Sebastian Andrzej Siewior
> > <sebastian.siewior@linutronix.de> wrote:
> > >
> > > On 2018-10-04 19:12:53 [-0700], Anup Pemmaiah wrote:
> > > > 1) Is there any floating point related kernel setting that I should
> > > > set in the RT_PREEMPT kernel? I have set eagerfpu=on (even though it
> > > > is on by default)
> > >
> > > nope, should work by default. Do you have NEON related crypto code or
> > > EFI enabled?
> > >
> > > > 2) Was reading about "Lazy Stacking" for Cortex-M4, but not sure if it
> > > > applies for Cortex A57
> > > >
> > > > Any comments will be greatly appreciated.
> > >
> > > Could you please try the latest v4.18? I believe it is fixed there and
> > > needs just backporting. Could you please try?
> > >
> > > Sebastian
