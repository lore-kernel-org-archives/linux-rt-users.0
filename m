From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: v3.18.55-rt61 build: 0 failures 5 warnings (v3.18.55-rt61)
Date: Mon, 12 Jun 2017 10:14:40 -0400
Message-ID: <20170612101440.574cf4e9@gandalf.local.home>
References: <E1dJ3Pb-0000JK-4q@optimist>
        <CAK8P3a35VW9gPyyxT4o6ca51hKAD+TvBpjVuNjnHNTZR4kM1tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Build bot for Mark Brown <broonie@kernel.org>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
        Daniel Wagner <wagi@monom.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdFLOOr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2017 10:14:47 -0400
In-Reply-To: <CAK8P3a35VW9gPyyxT4o6ca51hKAD+TvBpjVuNjnHNTZR4kM1tg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Arnd,

Thanks for Ccing us. I'll have a look. Some of these small issues
probably should be fixed in upstream RT as well. I'll see if the #if
not #ifdef is in the RT development branch, as I usually just do
straight pulls from that.

-- Steve


On Mon, 12 Jun 2017 16:01:21 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Jun 8, 2017 at 9:48 PM, Build bot for Mark Brown
> <broonie@kernel.org> wrote:
> > Tree/Branch: v3.18.55-rt61
> > Git describe: v3.18.55-rt61
> > Commit: a2896fc906 Linux 3.18.55-rt61
> >
> > Build Time: 0 min 7 sec
> >
> > Passed:    6 / 6   (100.00 %)
> > Failed:    0 / 6   (  0.00 %)
> >
> > Errors: 0
> > Warnings: 5
> > Section Mismatches: 0
> >
> > -------------------------------------------------------------------------------
> > defconfigs with issues (other than build errors):
> >       9 warnings    0 mismatches  : arm-allmodconfig
> >       3 warnings    0 mismatches  : arm-multi_v7_defconfig
> >       2 warnings    0 mismatches  : arm-multi_v5_defconfig
> >       3 warnings    0 mismatches  : x86_64-defconfig
> >
> > -------------------------------------------------------------------------------  
> 
> stable/3.18.y builds cleanly these days, so most warnings are all
> regressions in -rt, possibly not the KM_TYPE_NR warning, which
> seems to be an actual bug in stable kernels.
> 
> > -------------------------------------------------------------------------------
> > arm-allmodconfig : PASS, 0 errors, 9 warnings, 0 section mismatches
> >
> > Warnings:
> >         ../block/blk-core.c:103:5: warning: "CONFIG_PREEMPT_RT_FULL" is not defined [-Wundef]
> >         ../block/blk-core.c:103:5: warning: "CONFIG_PREEMPT_RT_FULL" is not defined [-Wundef]  
> 
> harmless typo in commit 091971373443 ("block/mq: don't complete requests
> via IPI"), #if needs to be #ifdef
> 
> >         ../net/core/dev.c:2899:1: warning: no return statement in function returning non-void [-Wreturn-type]  
> 
> Caused by fd7ce3b6ea7e ("net: move xmit_recursion to per-task variable on -RT"):
> xmit_rec_dec() should return 'void', not 'int'. Harmless.
> 
> >         ../arch/arm/include/asm/kmap_types.h:7:0: warning: "KM_TYPE_NR" redefined
> >         ../arch/arm/include/asm/kmap_types.h:7:0: warning: "KM_TYPE_NR" redefined  
> 
> We should backport
> adec640e0366 ("mlx5: stop including <asm-generic/kmap_types.h>")
> 
> In stable/linux-3.18.y, this is also wrong, but no warning shows up, since
> we don't include the right header there, only the wrong one. It's probably
> harmless, but I'm not completely sure about htis one.
> 
> Greg, maybe you can just add this to 3.18.y?
> 
> > -------------------------------------------------------------------------------
> > arm-multi_v7_defconfig : PASS, 0 errors, 3 warnings, 0 section mismatches
> >
> > Warnings:
> >         ../include/linux/spinlock.h:253:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]  
> 
> Caused by e09f810843a2 ("drivers-tty-pl011-irq-disable-madness.patch"),
> which removes the workaround for the warning.
> 
> > -------------------------------------------------------------------------------
> > x86_64-defconfig : PASS, 0 errors, 3 warnings, 0 section mismatches
> >
> > Warnings:
> >         ../drivers/thermal/x86_pkg_temp_thermal.c:414:1: warning: no return statement in function returning non-void [-Wreturn-type]  
> 
> Caused by 87df656d74fe ("thermal: Defer thermal wakups to threads"),
> thermal_notify_work_cleanup() needs to return 'void', not 'int'.
> 
> I'm guessing that the same problems exist in the other stable-rt kernels,
> so we probably need to fix them on all branches.
> 
>         Arnd

