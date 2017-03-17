From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v4.1.38-rt46 build: 1 failures 46 warnings (v4.1.38-rt46)
Date: Fri, 17 Mar 2017 21:21:35 +0100
Message-ID: <CAK8P3a37VfnxHPxNs7A=3s-cOzZsZSK93f_wk-WaJpnCqk-6Bw@mail.gmail.com>
References: <E1cmQcG-0002cE-Cd@optimist>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>
To: Build bot for Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <E1cmQcG-0002cE-Cd@optimist>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Mar 10, 2017 at 8:54 PM, Build bot for Mark Brown
<broonie@kernel.org> wrote:

> -------------------------------------------------------------------------------
> defconfigs with issues (other than build errors):
>      36 warnings    3 mismatches  : arm64-allmodconfig
>       4 warnings    0 mismatches  : arm-multi_v5_defconfig
>       5 warnings    0 mismatches  : arm-multi_v7_defconfig
>       3 warnings    0 mismatches  : x86_64-defconfig
>      31 warnings    0 mismatches  : arm-allmodconfig
>       2 warnings    0 mismatches  : arm64-defconfig

For some reason, neither kernelci.org nor broonie's built bot include
the stable/v4.1.y
tree, but we do get reports for v4.1-rt, which unlike v4.4-rt show a number of
warnings. Sasha, are you interested in backporting the fixes for these so we can
eventually get a clean build and spot regressions more easily? A lot of these
are just patches to shut up harmless warnings, but some also address real bugs.

> Errors summary: 1
>           1 ERROR: "handle_bad_irq" [drivers/gpio/gpio-omap.ko] undefined!

9d67dc5da59d ("genirq: Export handle_bad_irq")

> Section Mismatches:
>         WARNING: drivers/staging/fsl-mc/bus/mc-bus-driver.o(.init.text+0x164): Section mismatch in reference from the function init_module() to the function .exit.text:dprc_driver_exit()
>         WARNING: drivers/staging/fsl-mc/bus/mc-bus-driver.o(.init.text+0x164): Section mismatch in reference from the function init_module() to the function .exit.text:dprc_driver_exit()
>         WARNING: drivers/staging/fsl-mc/bus/mc-bus-driver.o(.init.text+0x164): Section mismatch in reference from the function init_module() to the function .exit.text:dprc_driver_exit()

3c7b67f9065d ("staging: fsl-mc: section mismatch bug fix")

> -------------------------------------------------------------------------------
> arm-multi_v5_defconfig : PASS, 0 errors, 4 warnings, 0 section mismatches
>
> Warnings:
>         ../net/core/dev.c:2930:1: warning: no return statement in function returning non-void [-Wreturn-type]

This is a harmless bug introduced in -rt:

5acab7cf4e6bc   (Sebastian Andrzej Siewior      2016-01-13 15:55:02
+0100       2927)static inline int xmit_rec_dec(void)
5acab7cf4e6bc   (Sebastian Andrzej Siewior      2016-01-13 15:55:02
+0100       2928){
5acab7cf4e6bc   (Sebastian Andrzej Siewior      2016-01-13 15:55:02
+0100       2929)   __this_cpu_dec(xmit_recursion);
5acab7cf4e6bc   (Sebastian Andrzej Siewior      2016-01-13 15:55:02
+0100       2930)}

>         ../include/linux/blkdev.h:625:26: warning: switch condition has boolean value [-Wswitch-bool]

10fbd36e362a ("blk: rq_data_dir() should not return a boolean")

>         ../net/ipv6/ip6_offload.c:261:25: warning: 'sit_gro_receive' defined but not used [-Wunused-function]

Here, upstream commit fac8e0f57969 ("tunnels: Don't apply GRO to multiple
 layers of encapsulation.") seems to have been incorrectly backported into
v4.1.y commit 066b300e5be4.

I have not analyzed why the function is now unused, but in the original patch
it is used, unlike in the backport.

>         ../drivers/rtc/rtc-pcf8563.c:444:5: warning: 'alm_pending' may be used uninitialized in this function [-Wmaybe-uninitialized]

cd1420d3a909 ("rtc: pfc8563: fix uninitialized variable warning")

>         ../drivers/net/wireless/brcm80211/brcmfmac/fwsignal.c:1478:8: warning: 'skb' may be used uninitialized in this function [-Wmaybe-uninitialized]

22f44150aad7 ("brcmfmac: avoid gcc-5.1 warning")

>         ../include/linux/spinlock.h:256:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]

I could not immediately find this one.

> -------------------------------------------------------------------------------
> x86_64-defconfig : PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>         ../arch/x86/kernel/cpu/mcheck/therm_throt.c:389:3: warning: right shift count >= width of type

I think this is
47edb65178cb ("x86/asm/msr: Make wrmsrl() a function")

> Warnings:
>         ../arch/arm/mach-cns3xxx/pcie.c:266:1: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This needs two patches, the first attempt introduced a regression

Fixes: 88e9da9a2a70 ("CNS3xxx: Fix PCI cns3xxx_write_config()")
Fixes: 498a92d42596 ("ARM: cns3xxx: pci: avoid potential stack overflow")

>         ../drivers/ata/pata_hpt366.c:376:9: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-array-qualifiers]
>         ../drivers/ata/pata_hpt366.c:379:9: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-array-qualifiers]
>         ../drivers/ata/pata_hpt366.c:382:9: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-array-qualifiers]

6ec0a86c645b ("ata: hpt366: fix constant cast warning")

>         ../arch/arm/include/asm/cmpxchg.h:207:3: warning: value computed is not used [-Wunused-value]

not sure.

>         ../sound/pci/oxygen/oxygen_mixer.c:91:43: warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses]

8ec7cfce3762 ("ALSA: oxygen: Fix logical-not-parentheses warning")

>         ../drivers/infiniband/hw/cxgb4/mem.c:147:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

b61e564af85b ("RDMA/cxgb4: re-fix 32-bit build warning")

>         ../arch/arm/include/asm/kmap_types.h:7:0: warning: "KM_TYPE_NR" redefined

not sure

>         ../drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm204.c:975:1: warning: the frame size of 1192 bytes is larger than 1024 bytes [-Wframe-larger-than=]

not sure

>         ../include/trace/ftrace.h:28:0: warning: "TRACE_SYSTEM_STRING" redefined
>         ../drivers/media/platform/coda/./trace.h:12:0: warning: "TRACE_SYSTEM_STRING" redefined

ae1c75d6ce3a ("[media] coda: remove extraneous TRACE_SYSTEM_STRING")

>         ../drivers/media/platform/s3c-camif/camif-capture.c:118:10: warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses]
>         ../drivers/media/platform/s3c-camif/camif-capture.c:134:10: warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses]

7e0d4e92269e ("[media] s3c-camif: fix compiler warnings")

>         ../drivers/rtc/rtc-armada38x.c:91:22: warning: unused variable 'flags' [-Wunused-variable]

d80238bbcad3 ("rtc: armada38x: Remove unused variable from
armada38x_rtc_set_time()")

>         ../drivers/scsi/be2iscsi/be_main.c:3168:18: warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses]

dd29dae00d39 ("be2iscsi: Fix bogus WARN_ON length check")

>         ../drivers/scsi/qla2xxx/qla_target.c:3086:6: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 8 has type 'uint32_t {aka unsigned int}' [-Wformat=]
>         ../drivers/scsi/qla2xxx/qla_target.c:3083:17: warning: unused variable 'se_cmd' [-Wunused-variable]

Commit 7359df25a533 ("qla2xxx: terminate exchange when command is
aborted by LIO")
got incorrectly backported into v4.1.y

>         ../drivers/scsi/ips.c:210:2: warning: #warning "This driver has only been tested on the x86/ia64/x86_64 platforms" [-Wcpp]

e03c2da65742 ("ips: remove pointless #warning")

   Arnd
