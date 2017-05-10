From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v3.18.51-rt57 build: 0 failures 29 warnings (v3.18.51-rt57)
Date: Wed, 10 May 2017 15:25:15 +0200
Message-ID: <CAK8P3a30btVEKNCG_1jQjdpSLAXCsYE7TsTO+ZdasW7FcyGQUA@mail.gmail.com>
References: <E1d8Qi4-0005cK-RB@optimist>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
        gregkh <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        Build bot for Mark Brown <broonie@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <E1d8Qi4-0005cK-RB@optimist>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, May 10, 2017 at 2:27 PM, Build bot for Mark Brown
<broonie@kernel.org> wrote:

> defconfigs with issues (other than build errors):
>      11 warnings    0 mismatches  : arm64-allmodconfig
>       4 warnings    0 mismatches  : arm-multi_v5_defconfig
>       5 warnings    0 mismatches  : arm-multi_v7_defconfig
>       3 warnings    0 mismatches  : x86_64-defconfig
>      27 warnings    0 mismatches  : arm-allmodconfig
>       2 warnings    0 mismatches  : arm64-defconfig

Most of these should be fixed with 3.19.52, which is warning free now, but at
least two of them are regressions introduced by -rt.

> Warnings Summary: 29
>           6 ../net/core/dev.c:2899:1: warning: no return statement in function returning non-void [-Wreturn-type]

Introduced by

87b3087ab425 ("net: move xmit_recursion to per-task variable on -RT")

>           6 ../drivers/tty/sysrq.c:956:33: warning: array subscript is above array bounds [-Warray-bounds]

Will be fixed in 3.18.53.

>           6 ../arch/arm/include/asm/kmap_types.h:7:0: warning: "KM_TYPE_NR" redefined

It seems that 3.18.y still needs a backport of

adec640e0366 ("mlx5: stop including <asm-generic/kmap_types.h>")

For some reason this didn't show up with the other build tests without the
-rt patchset.

>           5 ../block/blk-core.c:103:5: warning: "CONFIG_PREEMPT_RT_FULL" is not defined [-Wundef]
>           3 ../block/blk-core.c:103:5: warning: "CONFIG_PREEMPT_RT_FULL" is not defined, evaluates to 0 [-Wundef]

Introduced by

091971373443 ("block/mq: don't complete requests via IPI")

>           2 ../include/linux/dynamic_debug.h:78:3: warning: unsupported argument to '__builtin_return_address'
>           2 ../drivers/scsi/ips.c:210:2: warning: #warning "This driver has only been tested on the x86/ia64/x86_64 platforms" [-Wcpp]
>           1 ../include/uapi/linux/swab.h:13:15: warning: integer overflow in expression [-Woverflow]
>           1 ../include/linux/spinlock.h:253:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>           1 ../include/linux/kernel.h:708:17: warning: comparison of distinct pointer types lacks a cast
>           1 ../drivers/usb/gadget/function/f_ncm.c:203:0: warning: "NCAPS" redefined
>           1 ../drivers/thermal/x86_pkg_temp_thermal.c:414:1: warning: no return statement in function returning non-void [-Wreturn-type]
>           1 ../drivers/staging/vt6655/device_main.c:2997:1: warning: the frame size of 1312 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>           1 ../drivers/staging/bcm/CmHost.c:1564:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>           1 ../drivers/staging/bcm/CmHost.c:1546:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>           1 ../drivers/staging/bcm/CmHost.c:1503:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>           1 ../drivers/pci/host/pcie-xilinx.c:154:22: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
>           1 ../drivers/net/ethernet/mellanox/mlx5/core/debugfs.c:467:46: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>           1 ../drivers/net/ethernet/mellanox/mlx5/core/debugfs.c:307:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>           1 ../drivers/net/ethernet/mellanox/mlx5/core/debugfs.c:303:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>           1 ../drivers/infiniband/ulp/iser/iser_verbs.c:1206:14: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>           1 ../drivers/infiniband/ulp/iser/iser_verbs.c:1201:14: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>           1 ../drivers/infiniband/ulp/iser/iser_verbs.c:1175:31: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>           1 ../drivers/infiniband/ulp/iser/iser_verbs.c:1174:33: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>           1 ../drivers/infiniband/hw/qib/qib_qp.c:44:0: warning: "BITS_PER_PAGE" redefined
>           1 ../drivers/block/drbd/drbd_bitmap.c:483:0: warning: "BITS_PER_PAGE_MASK" redefined
>           1 ../drivers/block/drbd/drbd_bitmap.c:482:0: warning: "BITS_PER_PAGE" redefined
>           1 ../arch/arm/mach-cns3xxx/pcie.c:313:1: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]

I think these are all fixed in 3.18.52.

>           1 ../drivers/mtd/chips/cfi_cmdset_0020.c:651:1: warning: the frame size of 1192 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This one is queued for 3.18.53.

      Arnd
