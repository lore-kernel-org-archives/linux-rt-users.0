From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v4.4.12-rt20 build: 0 failures 5 warnings (v4.4.12-rt20)
Date: Fri, 15 Jul 2016 09:07:20 +0200
Message-ID: <4402302.GjsxlnvCX4@wuerfel>
References: <E1bNugf-00064t-KA@optimist>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E1bNugf-00064t-KA@optimist>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday, July 15, 2016 5:25:17 AM CEST Build bot for Mark Brown wrote:
> Tree/Branch: v4.4.12-rt20
> Git describe: v4.4.12-rt20
> Commit: b4059f165a Linux 4.4.12-rt20
> 
> Build Time: 79 min 2 sec
> 
> Passed:    9 / 9   (100.00 %)
> Failed:    0 / 9   (  0.00 %)
> 
> Errors: 0
> Warnings: 5
> Section Mismatches: 0
> 
> -------------------------------------------------------------------------------
> defconfigs with issues (other than build errors):
>       1 warnings    0 mismatches  : arm64-allnoconfig
>       2 warnings    0 mismatches  : arm64-allmodconfig
>       1 warnings    0 mismatches  : arm-multi_v5_defconfig
>       2 warnings    0 mismatches  : arm-multi_v7_defconfig
>       1 warnings    0 mismatches  : x86_64-defconfig
>       3 warnings    0 mismatches  : arm-allmodconfig
>       1 warnings    0 mismatches  : arm-allnoconfig
>       1 warnings    0 mismatches  : x86_64-allnoconfig
>       2 warnings    0 mismatches  : arm64-defconfig
> 
> -------------------------------------------------------------------------------

Cc linux-rt-users@vger.kernel.org, let's have a look at the individual warnings:

> Warnings Summary: 5
> 	  9 ../kernel/sched/core.c:3473:12: warning: 'preemptible_lazy' defined but not used [-Wunused-function]

This was introduced by the rt patchset, I'd suggest adding a fix to the next
v4.4-rt release. This is almost certainly harmless.

> 	  2 ../include/linux/spinlock.h:246:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]

I'm missing context here, so I don't know what caused it, but the warning is
not present in v4.4.12 (without -rt), so it's worth looking into.

It happens for both arm-multi_v7_defconfig and arm64-defconfig.

> 	  1 ../lib/lz4/lz4hc_compress.c:514:1: warning: the frame size of 1472 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 	  1 ../drivers/xen/balloon.c:155:13: warning: 'release_memory_resource' declared 'static' but never defined [-Wunused-function]
> 	  1 ../drivers/mtd/chips/cfi_cmdset_0020.c:651:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]

These three are present in v4.4.12 and only got fixed upstream later.
I have some hope that the fixes will make it into stable kernels
eventually. The "frame size" warnings are a side-effect of a gcc
problem with gcov profiling, and the xen warning was introduced by
a stable backport patch.

	Arnd
