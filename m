Return-Path: <SRS0=LbvN=6S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593B2C3A5A9
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 09:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5B2206D9
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 09:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSrroLjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgEDJkV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 May 2020 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727781AbgEDJkU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 May 2020 05:40:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB32C061A0E;
        Mon,  4 May 2020 02:40:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e26so7687956wmk.5;
        Mon, 04 May 2020 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Kbu0VxZ/QYO7Ixdkf6q7mL9ZGCB1E3Ur2BdwdumwcAY=;
        b=MSrroLjXrwKV//z1QXkp3jabJmvZ7Ou9I0LEguKAQLP5LGx8jSFBWz9Htt5WZ98Op6
         ma5/QOLItFhArQs2Ws/Cvh46OEt2h86fMMY76Ng4QJlBqCgXgGApjBzBB+KSQ8J9OHxO
         zIS+hfafx9uCBkSpPCT9KL9Hd4OXhZyuxcZ8DkpEJgC+E74cGoiQ4ybgHGALzX+jfDW8
         9hsMEycBXHTr3NlvKkZWJfFDdw+DZPdIIk+ufM0Mcoc+oKAXd3V7BPUGrgFW8sr1zj66
         4WJk+eAU1l/5hm2he+PNaqGgSqM/eJ0fxFWaswFc5+715Jf1pDeXoHajNTVgZyZpW0FZ
         Vq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Kbu0VxZ/QYO7Ixdkf6q7mL9ZGCB1E3Ur2BdwdumwcAY=;
        b=cvietZanXUZtUFExeVCCZN6oFXDuWuIwoWM/lfg3tVfzVhQaJoY44C6SE83U9SR2Si
         JNJ9U1WFMIf6R0oMi3i1Wm1Z4vkGeBscs3piUejUS9wtrct+aYIQ18YiV/aF6XLJIlim
         FMN55pk6MWM8Lx/6CcdRbHo6vTo20IJVcyrC3KLd5qg6FqAn/DvDDo37Yw85v7NnOJU2
         VHm1kEGawCcV5WWO/TYWRbEG2fyj9qd8lgkXo4UqsQmRu+aWjkd1ptTYCnjvdvBEBlSR
         p90mR0cSrb6Ty3o8yAn78e6ekyhathdIQRWu7h2vGe7Sjvmh2OmGeZBahx2QIjtAUGtj
         7wqw==
X-Gm-Message-State: AGi0PuZ1atB1CawqC6CZi4hz7PClfuxyvGblyd8PcHZhg3uBmq4TibOu
        Yv1s6aJLdgDggwSAh/n3KF4MWii5nQgODXGRHsbe2XpzXKk=
X-Google-Smtp-Source: APiQypKxSk1onspTP4rFzkKSW76+hglmGDtVGqlc/jgvgWuURsiU1S/h0ui8OKEF/R4p533RUSCxxC5Nau70aiuu6gI=
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr14668145wmh.59.1588585218952;
 Mon, 04 May 2020 02:40:18 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Marshall <markmarshall14@gmail.com>
Date:   Mon, 4 May 2020 11:40:08 +0200
Message-ID: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
Subject: Kernel crash due to memory corruption with v5.4.26-rt17 and PowerPC e500
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Mark Marshall <mark.marshall@omicronenergy.com>,
        thomas.graziadei@omicronenergy.com,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi RT experts,

We are using the RT kernel with the PowerPC e500.  Until recently we
were on the 4.19 kernel series, and are in the process of upgrading.
When we switched to the v5.4 version, we get a reproducible kernel
crash.  The crashes all contain the "BUG: Bad rss-counter state" line,
and then after that it appears that a structure of type mm_struct or
vm_area_struct is corrupted.

The easiest way we have found to reproduce the crash is to repeatedly
insert and then remove a module.  The crash then appears to be related
to either paging in the module or in exiting the mdev process.  (The
crash does also happen at other times, but it is hard to reproduce
reliably then).  This simple script will almost always crash:

   for i in $(seq 1000) ; do echo $i ; modprobe crc7 ; rmmod crc7 ; done

(The crc7 module is chosen as it is small and simple.  Any module will
work / crash).

We have tried kernels v5.0, v5.2 and v5.6.  The v5.0 and v5.2 kernels
do not show the problem.  The v5.6 kernel does show the problem.
Switching of RT fixes the problem.

I have reduced the functionality in the kernel to a bare minimum
(removing networking, USB and PCI, as we have some out-of-tree patches
in those areas) and we still get the crash.

Here are a couple of example stack traces:

000: NIP [c003f8e0] __mmdrop+0x2c8/0x3dc
000: LR [c003f8e0] __mmdrop+0x2c8/0x3dc
000: Call Trace:
000: [e953fd48] [c003f8e0] __mmdrop+0x2c8/0x3dc
000:  (unreliable)
000: [e953fd88] [c00c6d28] rcu_core+0x324/0x78c
000: [e953fe58] [c00c79e0] rcu_cpu_kthread+0x1f4/0x42c
000: [e953fe98] [c00838fc] smpboot_thread_fn+0x2e8/0x488
000: [e953fef8] [c007d514] kthread+0x1b0/0x1b8
000: [e953ff38] [c001a26c] ret_from_kernel_thread+0x14/0x1c


000: NIP [c010cdd4] acct_collect+0x3a8/0x3e0
000: LR [c010cdd4] acct_collect+0x3a8/0x3e0
000: Call Trace:
000: [c6f2bbe0] [c010cdd4] acct_collect+0x3a8/0x3e0
000:  (unreliable)
000: [c6f2bc10] [c0049354] do_exit+0x294/0xf9c
000: [c6f2bcf0] [c0013030] die+0x220/0x2c4
000: [c6f2bd30] [c00132cc] exception_common+0x1f8/0x238
000: [c6f2bd30] [c00132cc] exception_common+0x1f8/0x238
000: [c6f2bd70] [c0013404] _exception+0x34/0x80
000: [c6f2bd90] [c001a4a8] ret_from_except_full+0x0/0x4


I have added some debugging code where the mm_struct and
vma_area_struct have "poision" values at the start and the end, and
this seems to show that the vma_area_struct is getting corrupted, but
I'm not able to see where.

We have switched on all of the debugging that we can, including
KASAN, and this shows nothing.


Can anyone help us?  What can we try next?  Is anyone using the e500
with the RT kernel?  Does anyone have any idea how to debug problems
related to the error message "Bad rss-counter state"?

Any help or advice would be most gratefully received.

Many thanks,
Mark Marshall and Thomas Graziadei

PS.  Thomas Grazidei (my colleague) did find a bug in the start_32.S
file for the e500, and we have the fix for that included.  We have
also tried removing the LAZY_PREEMPTION patch completely, and this
doesn't help.
