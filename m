Return-Path: <SRS0=ZIbK=ZE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893CEC43331
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8AC206A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyBWJ0/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKLUeA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:34:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34859 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLUeA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Nov 2019 15:34:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so19344785ljg.2
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Nov 2019 12:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwieZCpSIjY4bWZ+N1azlJQL2AXb8p+auJYfVWlUNJY=;
        b=FyBWJ0/CXxlfoinjps7VAlu78Cuh0fGVaI6DTrDFB8q11fGsmtPSLuxLOvScluN/Ez
         6twsTox6sJFW6d1q15FkEt+XSFiNGHVW55mI6yFhqqipm806MIkJtVUqTlzFfWTaVKk5
         JdxD8LbPaP8hMiza/itEQrkxrzodU0AK87oXGMe6R1NnDT6Eet42pxzU2oK/txhZm+Dz
         IVmhKQ/09wms0+eUWxSkRZ1wkoRPOGuSe9E+WzK2SPuomxYt8+F8XvnqfXf7WCurbndV
         gz5N2U0ONbLRzNfvgFN5JGkzJpYNdvkDt2F5FNVV85RMZDehkVTQFz0P9S4KcM0fQu6b
         E54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwieZCpSIjY4bWZ+N1azlJQL2AXb8p+auJYfVWlUNJY=;
        b=p7ft1o4O+i887jFQPPiWl5ah8pXwLOZ6Ih7U3n2cAkhZhDrllEqMBhP3in7/0pFWV4
         kcusJEacILzH9dF2hiDSvxGkkNJkcDdkEg2F8ocGBzRIS7vEGi9sg5Y3UHr+Zvz/Mzow
         6wbrctEjAmAKqrtfRvb+Eywkdl58U1cTL2X2S6lyMcX4440z3kDcOg/3Nm9qcmMFr/5q
         bARIAwKUjxJtNLDhyFlYd/gBdFRbzFqOF15cu8kXSHBs7zcvBcFzJslrvH6e+osW7Er9
         ZpWv8yyS958o05aqT+WzKSwvJqNLE6zP9P6ieNamfLsrbIzI1uwzg0dIHs0GWbRj+CGb
         6apg==
X-Gm-Message-State: APjAAAVMoBqCHms0cDvnlYfkM6H0lMqaWBEQdMbE8osV0GyJ8Hgiedw5
        +0KhNiGZlnHsmI4BSqNEKbWclvf+qr2qh+a0BsTPMhG9
X-Google-Smtp-Source: APXvYqzrZcZv/uBLDCnzK1mb8WysBrid+mu2DZg0NHvomgTVH/3JEExyQEv0dgXEAdl4B9MpIcObjbCZeKDKFmg1LLQ=
X-Received: by 2002:a2e:9712:: with SMTP id r18mr11291603lji.12.1573590837984;
 Tue, 12 Nov 2019 12:33:57 -0800 (PST)
MIME-Version: 1.0
References: <a0a64a18-5805-de3b-c4f7-537de8fa0508@softplc.com>
In-Reply-To: <a0a64a18-5805-de3b-c4f7-537de8fa0508@softplc.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 12 Nov 2019 15:33:46 -0500
Message-ID: <CAD56B7cgt704nWrowch8KrcT7e6ASr5Hi9FQ8-xmgztYcdceyA@mail.gmail.com>
Subject: Re: Need help building for aarch64 kernel 5.2
To:     Dick Hollenbeck <dick@softplc.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Nov 12, 2019 at 2:27 PM Dick Hollenbeck <dick@softplc.com> wrote:
>
> Hi Experts,
>
> I really need some help please.
>
> Here is the result of my first build attempt on a tree made from pristine
> Linux 5.2.21
>
> and the corresponding RT patch, which applied cleanly:
>
>
>
> $ /i/runtime/arm64/kernel/build-arm64-rt.sh
> make[1]: Entering directory '/ssd/build/linux-5.2.y'
>   GEN     Makefile
> scripts/kconfig/conf  --syncconfig Kconfig
>   GEN     Makefile
>   Using /ssd/linux-5.2.y as source for kernel
>   CALL    /ssd/linux-5.2.y/scripts/atomic/check-atomics.sh
>   CALL    /ssd/linux-5.2.y/scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   GZIP    kernel/config_data.gz
>   CC      kernel/configs.o
>   AR      kernel/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   MODINFO modules.builtin.modinfo
> kernel/sched/core.o: In function `migrate_enable':
> core.c:(.text+0x3750): undefined reference to `takedown_cpu_task'
> core.c:(.text+0x3750): relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against
> undefined symbol `takedown_cpu_task'
> core.c:(.text+0x3754): undefined reference to `takedown_cpu_task'
> /ssd/linux-5.2.y/Makefile:1054: recipe for target 'vmlinux' failed
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory '/ssd/build/linux-5.2.y'
> Makefile:179: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
>
>
> Am I right to think that this pointer, takedown_cpu_task, is more that some maximum
> distance away from object file "core.o" in the link image for the build setup?
>
>
> How are other globals avoiding this same problem, what't the best fix?


Hi Dick,

I've been building for arm64 for some time without issue. I generally
use git, but using the patch is fine too. Here are the general steps.

1. Download the base version. It's not on the kernel.org home page but
you can find it here (https://cdn.kernel.org/pub/linux/kernel/v5.x/)
 wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.2.21.tar.xz

2. Extract the kernel
 tar -xf linux-5.2.21.tar.xz

3. Change into the directory
 cd linux-5.2.21

4. Pull the patch. The main git devel page is a nice reference:
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
If you look for the Commit messages with an [ANNOUNCE] prefix and
click on that such as "[ANNOUNCE] v5.2.21-rt13" then this brings up a
nice write-up Sebastian does with the URL of the RT patch. So in this
case the following command works:
wget https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.21-rt13.patch.xz

5. Extract the patch
 unxz patch-5.2.21-rt13.patch.xz

6. Apply the patch
 patch -p1 < patch-5.2.21-rt13.patch

7. Make the default config. This is where you customize the config to
turn on things like CONFIG_PREEMPT_RT_FULL. This is done with 'make
ARCH=arm64 menuconfig' or 'make ARCH=arm64 xconfig'
 make ARCH=arm64 defconfig

8. Check that you have a proper arm64 cross compiler in your PATH, the
exact prefix of your compiler may be different, but this is a good
test to see that we have the prefix correct for the next command.
 aarch64-linux-gnu-gcc --version

9. Build the Image (actual u-boot binary for arm64 kernels). The Image
file is located in arch/arm64/boot/
  make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image

I hope this helps. Good luck!

-Paul
