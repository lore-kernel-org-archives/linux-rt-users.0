Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2EAC433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1479E619F2
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 10:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYKEp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 06:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYKE1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Mar 2021 06:04:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34F1C06174A
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 03:04:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bx7so1686665edb.12
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madeinspaceeurope-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=WdDBcNO8xGobA3wFEn/5I/fQ3oDMeWc3Munm72gpXcA=;
        b=X1wU3fVQR1wkbYH9PvX2JO5uBudkAZJEA/b8QpHbr3Ab0OkxW52LRXrHLfbCkNfade
         rNYVy3QAijNIgtcjK1vOgFXE65ac1NHiHvbO7HvKo/7wa/VF6YaKP3qq0L88Xa99jgS9
         dcNUDSyYGTe+oc/4vDQNZRTrdjFeCJPKwC9RMPKuXgJHXapS7e42P8Whz75U5VIJ5AbT
         0IGeyqX+AgDmcJQGpXwBkkCCJOI5jpZ47wCWaX963VMl5pQhkKN/wVX28JO76A+r1amz
         ox+TnJNwnh8tRXwN8mzSXML6njLC7qWHdy3YPn2raBvipOj4kwplLv5p+mWtQKv2XH8C
         MO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=WdDBcNO8xGobA3wFEn/5I/fQ3oDMeWc3Munm72gpXcA=;
        b=q+hQ+Y+yk8Y+rRBRlciUu32E1j66B3jHTuMqcMHAEreJcuZl2dOayOteXgMe+MFm61
         Hg5uiXC9paLfEGO3ly/hWzOtaCZ0V5R9+jFMHZRz9WJKEzG7gjJ7nz7AlmD55AruyF8J
         SxDU0AlDMLIaDaz91PLgbPVv1MrMYoBMSdvYN88TDJZ5Ps7QQ7GUgd2RkH93MZ3Cp8VT
         9+P/HzGTPLwXjDc8yBqjbUHphESS+QCmHLVJxZs/V7+bSSEPXvyAStdJt8bGEDO7jhER
         je3nPr40Cz+/AIu9mvtbs7XZHkz2DS6heBzuAK9je8FAJrkyciXxqcUnoz7B1v2RAg5S
         U21w==
X-Gm-Message-State: AOAM531KsWWA3FCDieel1Z7IAhHPMEJAF2YVF/a4reHQx+R9PwH4puRb
        BKe1l+jTmG/Ue94V20wb/2mX32qbvnmqglJ6mSA=
X-Google-Smtp-Source: ABdhPJxmZVozsxOVc6t0Q4VZqjYJ57m/No1ZvmxgBhQvfx0CdIg3soYqR8oypsh65QtsdMQUwcpWEw==
X-Received: by 2002:aa7:df14:: with SMTP id c20mr8080104edy.197.1616666665570;
        Thu, 25 Mar 2021 03:04:25 -0700 (PDT)
Received: from canary (185.173.181.110.mixvoip.solutions. [185.173.181.110])
        by smtp.gmail.com with ESMTPSA id la15sm2194006ejb.46.2021.03.25.03.04.24
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:04:25 -0700 (PDT)
Message-ID: <dd27ce028fb9b2423ec99985c290b19b30083b34.camel@madeinspaceeurope.com>
Subject: Application of standard kernel patch and then RT patch with
 Petalinux
From:   jack@madeinspaceeurope.com
To:     linux-rt-users@vger.kernel.org
Date:   Thu, 25 Mar 2021 11:04:23 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I am having problems applying kernel patches in the context of a Xilinx
Petalinux project (Yocto-based).

Xilinx provides a 5.4.0 kernel, according to make kernelconfig, though
how this corresponds to the upstream 5.4.0 kernel, I'm not sure.

My understanding is that, in order to apply the latest 5.4 rt patch
(106-rt54), I have to apply the upstream 106 patch first. Is this
correct?

When applying the patches using petalinux-config -c kernel, the
upstream patch appears to be accepted, but the rt patch is not. I get
the sequence of errors below, picked out in red.

I am not familiar enough with the kernel, or the Petalinux tools, to
get a handle on the problem. The log file mentioned at the bottom does
not exist following the completion of the command.

Is anyone able to help with this?

Many thanks,

Jack White

----------------------------------------------------------------------
ERROR: Could not apply patches for zynqmp-generic.
ERROR: Patch failures can be resolved in the linux source directory
/home/jack/ws_zcu102/petalinux/2021_03_25_Ubuntu_Petalinux/build/tmp/wo
rk/zynqmp_generic-xilinx-linux/linux-xlnx/5.4+gitAUTOINC+62ea514294-
r0/devtooltmp-rh17ls9u/workdir/source)
ERROR: Execution of
'/home/jack/ws_zcu102/petalinux/2021_03_25_Ubuntu_Petalinux/build/tmp/w
ork/zynqmp_generic-xilinx-linux/linux-xlnx/5.4+gitAUTOINC+62ea514294-
r0/devtooltmp-rh17ls9u/temp/run.do_patch.1045876' failed with exit code
1:
(1/1) patch-5.4.106-rt54.patch
[INFO]: check of .kernel-meta//patches//./patch-5.4.106-rt54.patch with
"git am" did not pass, trying reduced context.
[INFO]: Context reduced git-am of .kernel-meta//patches//./patch-
5.4.106-rt54.patch with "git am" did not work, trying "apply".
error: patch failed: arch/arm/kernel/smp.c:682
error: arch/arm/kernel/smp.c: patch does not apply
error: patch failed: arch/powerpc/Kconfig:222
error: arch/powerpc/Kconfig: patch does not apply
error: patch failed: arch/powerpc/kernel/traps.c:261
error: arch/powerpc/kernel/traps.c: patch does not apply
error: patch failed: arch/powerpc/platforms/pseries/iommu.c:209
error: arch/powerpc/platforms/pseries/iommu.c: patch does not apply
Context reduced to (1/1) to apply fragment at 25
Context reduced to (1/1) to apply fragment at 1727
error: patch failed: drivers/char/tpm/tpm_tis.c:50
error: drivers/char/tpm/tpm_tis.c: patch does not apply
error: patch failed: drivers/pci/switch/switchtec.c:175
error: drivers/pci/switch/switchtec.c: patch does not apply
Context reduced to (2/2) to apply fragment at 1975
Context reduced to (2/2) to apply fragment at 2082
error: patch failed: fs/jbd2/transaction.c:2331
error: fs/jbd2/transaction.c: patch does not apply
error: patch failed: fs/nfs/nfs4proc.c:2969
error: fs/nfs/nfs4proc.c: patch does not apply
error: patch failed: include/linux/genhd.h:755
error: include/linux/genhd.h: patch does not apply
error: patch failed: include/linux/printk.h:202
error: include/linux/printk.h: patch does not apply
error: patch failed: include/linux/sched/mm.h:49
error: include/linux/sched/mm.h: patch does not apply
error: patch failed: kernel/bpf/stackmap.c:290
error: kernel/bpf/stackmap.c: patch does not apply
error: patch failed: kernel/futex.c:1639
error: kernel/futex.c: patch does not apply
error: patch failed: kernel/locking/rtmutex_common.h:130
error: kernel/locking/rtmutex_common.h: patch does not apply
error: patch failed: kernel/printk/internal.h:1
error: kernel/printk/internal.h: patch does not apply
error: patch failed: kernel/printk/printk.c:452
error: kernel/printk/printk.c: patch does not apply
error: patch failed: kernel/printk/printk_safe.c:1
error: kernel/printk/printk_safe.c: patch does not apply
Context reduced to (2/2) to apply fragment at 767
Context reduced to (2/2) to apply fragment at 405
error: patch failed: kernel/signal.c:432
error: kernel/signal.c: patch does not apply
error: patch failed: kernel/trace/trace.c:3592
error: kernel/trace/trace.c: patch does not apply
error: patch failed: kernel/workqueue.c:2533
error: kernel/workqueue.c: patch does not apply
Context reduced to (1/1) to apply fragment at 1268
Context reduced to (2/2) to apply fragment at 1382
[ERROR]: Application of .kernel-meta//patches//./patch-5.4.106-
rt54.patch failed.
         Patch needs to be refreshed. Sample resolution script:
             .git/rebase-apply/resolve_rejects
WARNING:
/home/jack/ws_zcu102/petalinux/2021_03_25_Ubuntu_Petalinux/build/tmp/wo
rk/zynqmp_generic-xilinx-linux/linux-xlnx/5.4+gitAUTOINC+62ea514294-
r0/devtooltmp-rh17ls9u/temp/run.do_patch.1045876:1 exit 1 from 'exit 1'

ERROR: Logfile of failure stored in:
/home/jack/ws_zcu102/petalinux/2021_03_25_Ubuntu_Petalinux/build/tmp/wo
rk/zynqmp_generic-xilinx-linux/linux-xlnx/5.4+gitAUTOINC+62ea514294-
r0/devtooltmp-rh17ls9u/temp/log.do_patch.1045876
----------------------------------------------------------------------

