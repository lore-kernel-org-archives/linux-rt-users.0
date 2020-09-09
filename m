Return-Path: <SRS0=FZAt=CS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1BFC43461
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 05:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9223121582
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 05:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FhHBpUIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgIIFqD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:46:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:35809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIFqB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Sep 2020 01:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599630322;
        bh=JY5lf4hMpyngH/x6kBEAs/Y3gjuzhO2g4mGe8s8uxdM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=FhHBpUIlcme82fq12e60Qb8EKbhoMYGON5V0PnRDBLCJklVGWtKJM3b9hOXfyaPSH
         jWDyOLzxUrsK0pMCLOGaTR1hm6k9mpgzGqU7EGPB0udsjohJE7eGIiflaO/f0rs7Es
         bdPWcSpcldZzN4hCLAer0lYIPPTPIYPShVqRkyqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1ktsMF2xaT-00mp6M; Wed, 09
 Sep 2020 07:45:22 +0200
Message-ID: <91828ea63ecd61d40bba0358e1c0efbe62976ba6.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.9-rc3-rt3
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 09 Sep 2020 07:45:22 +0200
In-Reply-To: <6ed14b9743f5ce400137a4ae5561604575e72b13.camel@gmx.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <6ed14b9743f5ce400137a4ae5561604575e72b13.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/wQbuB5JFjmmlJUylYOJxEhxLhWxHwLJwpeQZ31f/W55yPiVTAR
 QPlrXdNgXga+ZVAr4zWYpMg+0wagIZI+f05+dKg9cFyyA/QppkSlBZtZW0+ZG+seUgU/A3n
 EtvA9lP5AVw2aB9vicAZDLaF/UirbfTGuguSYNfxkIFxQtlh4EPmrCix3tOo2HPxsiLu8uX
 te5dCd5OgzYrbLyVOjP9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fQOowdHrsXE=:lgOIJLL8oaqgnEBAt+9he4
 5/Ew6vAJhoc5a88ZVm+gz85kp7K2dHQip4KdpfD8XRJftBl/1s7KVa36ftWpB947S0Lgzu8Yw
 iz/vydz6agA6lH4E9lT66a/iPACM8Rw+uAnmkyXDZVhwySsfQldJe6iyaushqGLe0bJjNrGzg
 vnGkDnoeeDwTAuPz3g4wrvxVkjUh7MZlXEi0aUDbUNofw+ZqW1tBRzUtT/tjHTfEISUW3yTxz
 o9+dQR9MvwhS3oVayYV8WrSLm81RPVcMkf2oBx0EtA1u3EKUH2XWUHTB+kADUQLdpZWocNHrV
 HnKRbBVx1bwIlEQPFO76RA/DPFeHOnhkAJC1FxodHMTuSiQAqADd0LZbz9o7MqwX8YJH1RGrT
 ePvM8ubsvBPtJqtYiL3SvbK5LFhxOuWVMp+dNuzJY0XYmDcUWlhpGJVpbiQ40dFgLkmZB0gYs
 7rXn9c7xgGE1F3lq4ZRyVQsplOuQYFjpzLk1a985iYPcQZ5HDlb0IX91AxkFzXJPCZhF/74le
 JuT89H8g7odUYGbKpP/5yGOcHUZv7zb5rHhC4eF8ylBRmWQTG77HoFMZoSLZxwdSVzsvgfO4f
 XierrY2PPxHLi8gL+HTxTu+xwH+5bInrnv3oPUAb1aiW8sCmhYswBO8nGtQ30gteuPyogt3wB
 KlXN0Y50a+iBZ3FpyWcaz/wKOspCCY085ekvGkhdRUo0YeRUCTD6remcSiekuyWafjI5wLO8x
 1eBqJqu4EWt+O9wSzL0ffWq4F+PMk7zZ/YCtte6g6e47psfQAx5td32bUfT8zJeZYkau+wpBJ
 4EhXtCktkv1OwpFARuE2UAYlN7DWKtgHwQfgP7NpreBBXhbCThR5G47KmMr2r9Iz6SXZTpdEj
 SO8cNAA2lh5L4IGVWy/T2V9bugGQ7dbvbl7lWy4W3Xd4fkjndQNhtama8EHn5aJwB2zrPHrAy
 zwsZjh6THqEMQlfGJLVR3SyQeHBS9xxt4AnGwzI9U0yt2hAYGxo9CQ+icwt00DN+YrevKg1eb
 6MTcTWaTdajmef8HOI8XAHuYnKv/VHhzjQTndqV5dOLOo/AB3DtWdrdXp0G+dRUtZf8Ahx9bZ
 BsIPJ9QxqCgNJHVgJ6TsefxEAQwRhO747plb8H8+EsjH9wV6JoXIARKDHqQJYBtLMYqhIcknW
 df6aY0/O2whLnFyueHSDygli3CY8eroAlVIRlogWz/zQvo2qseqwT8DQMn0z0Va891D0lqHlB
 dnadZqxBBW5E+dL+R
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-09-09 at 05:12 +0200, Mike Galbraith wrote:
> On Wed, 2020-09-02 at 17:55 +0200, Sebastian Andrzej Siewior wrote:
> >
> > Known issues
> >      - It has been pointed out that due to changes to the printk code =
the
> >        internal buffer representation changed. This is only an issue i=
f tools
> >        like `crash' are used to extract the printk buffer from a kerne=
l memory
> >        image.
>
> Ouch.  While installing -rt5 on lappy via nfs, -rt5 server box exploded
> leaving nada in logs.  I have a nifty crash dump of the event, but...

After convincing crash (with club) that it didn't _really_ need a
log_buf, nfs had nothing to do with the crash, it was nouveau.

      KERNEL: vmlinux-5.9.0.gf4d51df-rt5-rt.gz
    DUMPFILE: vmcore
        CPUS: 8
        DATE: Wed Sep  9 04:41:24 2020
      UPTIME: 00:08:10
LOAD AVERAGE: 3.17, 1.86, 0.99
       TASKS: 715
    NODENAME: homer
     RELEASE: 5.9.0.gf4d51df-rt5-rt
     VERSION: #1 SMP PREEMPT_RT Wed Sep 9 03:22:01 CEST 2020
     MACHINE: x86_64  (3591 Mhz)
      MEMORY: 16 GB
       PANIC: ""
         PID: 2146
     COMMAND: "X"
        TASK: ffff994c7fad0000  [THREAD_INFO: ffff994c7fad0000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt -l
PID: 2146   TASK: ffff994c7fad0000  CPU: 0   COMMAND: "X"
 #0 [ffffbfffc11a76c8] machine_kexec at ffffffffb7064879
    /backup/usr/local/src/kernel/linux-master-rt/./include/linux/ftrace.h:=
 792
 #1 [ffffbfffc11a7710] __crash_kexec at ffffffffb7173622
    /backup/usr/local/src/kernel/linux-master-rt/kernel/kexec_core.c: 963
 #2 [ffffbfffc11a77d0] crash_kexec at ffffffffb7174920
    /backup/usr/local/src/kernel/linux-master-rt/./arch/x86/include/asm/at=
omic.h: 41
 #3 [ffffbfffc11a77e0] oops_end at ffffffffb702716f
    /backup/usr/local/src/kernel/linux-master-rt/arch/x86/kernel/dumpstack=
.c: 342
 #4 [ffffbfffc11a7800] exc_general_protection at ffffffffb79a2fc6
    /backup/usr/local/src/kernel/linux-master-rt/arch/x86/kernel/traps.c: =
82
 #5 [ffffbfffc11a7890] asm_exc_general_protection at ffffffffb7a00a1e
    /backup/usr/local/src/kernel/linux-master-rt/./arch/x86/include/asm/id=
tentry.h: 532
 #6 [ffffbfffc11a78a0] nvif_object_ctor at ffffffffc07ee6a7 [nouveau]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
vif/object.c: 280
 #7 [ffffbfffc11a7918] __kmalloc at ffffffffb72eea12
    /backup/usr/local/src/kernel/linux-master-rt/mm/slub.c: 261
 #8 [ffffbfffc11a7980] nvif_object_ctor at ffffffffc07ee6a7 [nouveau]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
vif/object.c: 280
 #9 [ffffbfffc11a79d0] nvif_mem_ctor_type at ffffffffc07eef48 [nouveau]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
vif/mem.c: 74
#10 [ffffbfffc11a7aa8] nouveau_mem_vram at ffffffffc08b5291 [nouveau]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
ouveau_mem.c: 155
#11 [ffffbfffc11a7b10] nouveau_vram_manager_new at ffffffffc08b594d [nouve=
au]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
ouveau_ttm.c: 76
#12 [ffffbfffc11a7b30] ttm_bo_mem_space at ffffffffc05af2ac [ttm]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/ttm/ttm_b=
o.c: 1065
#13 [ffffbfffc11a7b88] ttm_bo_validate at ffffffffc05afaca [ttm]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/ttm/ttm_b=
o.c: 1137
#14 [ffffbfffc11a7c18] ttm_bo_init_reserved at ffffffffc05afe70 [ttm]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/ttm/ttm_b=
o.c: 1330
#15 [ffffbfffc11a7c60] ttm_bo_init at ffffffffc05afff7 [ttm]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/ttm/ttm_b=
o.c: 1364
#16 [ffffbfffc11a7cc8] nouveau_bo_init at ffffffffc08b0f7b [nouveau]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
ouveau_bo.c: 317
#17 [ffffbfffc11a7d38] nouveau_gem_new at ffffffffc08b2f7b [nouveau]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
ouveau_gem.c: 206
#18 [ffffbfffc11a7d70] nouveau_gem_ioctl_new at ffffffffc08b3001 [nouveau]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
ouveau_gem.c: 272
#19 [ffffbfffc11a7da0] drm_ioctl_kernel at ffffffffc066f564 [drm]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/drm_ioctl=
.c: 793
#20 [ffffbfffc11a7de0] drm_ioctl at ffffffffc066f88e [drm]
    /backup/usr/local/src/kernel/linux-master-rt/./include/linux/uaccess.h=
: 168
#21 [ffffbfffc11a7ed0] nouveau_drm_ioctl at ffffffffc08abf56 [nouveau]
    /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/n=
ouveau_drm.c: 1163
#22 [ffffbfffc11a7f08] __x64_sys_ioctl at ffffffffb733255e
    /backup/usr/local/src/kernel/linux-master-rt/fs/ioctl.c: 49
#23 [ffffbfffc11a7f40] do_syscall_64 at ffffffffb79a25c3
    /backup/usr/local/src/kernel/linux-master-rt/arch/x86/entry/common.c: =
46
#24 [ffffbfffc11a7f50] entry_SYSCALL_64_after_hwframe at ffffffffb7a0008c
    /backup/usr/local/src/kernel/linux-master-rt/arch/x86/entry/entry_64.S=
: 125
    RIP: 00007f96707a6ac7  RSP: 00007ffc1cbc2998  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 000055743cf152e0  RCX: 00007f96707a6ac7
    RDX: 00007ffc1cbc29f0  RSI: 00000000c0306480  RDI: 000000000000000e
    RBP: 00007ffc1cbc29f0   R8: 0000000000000000   R9: 0000000000000003
    R10: fffffffffffffd98  R11: 0000000000000246  R12: 00000000c0306480
    R13: 000000000000000e  R14: 000055743ce99040  R15: 000055743c60cfd0
    ORIG_RAX: 0000000000000010  CS: 0033  SS: 002b

