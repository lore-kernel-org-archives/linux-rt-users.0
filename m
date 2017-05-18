From: Federico Reghenzani <federico.reghenzani@polimi.it>
Subject: Userspace GPIO
Date: Thu, 18 May 2017 16:49:45 +0200
Message-ID: <CACKey4yRDFMF9XAANDi4QWc=ZAGdKJxjZMhgts2dRtF4mMyY5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0083.outbound.protection.outlook.com ([104.47.2.83]:29133
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932406AbdEROuK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 May 2017 10:50:10 -0400
Received: by mail-wr0-f174.google.com with SMTP id l9so36893658wre.1
        for <linux-rt-users@vger.kernel.org>; Thu, 18 May 2017 07:50:07 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

not sure if this is the correct kernel mailing list, but it's related
to real-time applications.

I'm performing some tests with GPIO in Linux (with PREEMPT_RT patch,
but it's not currently important) and I noticed that user-space GPIO
via sysfs is very slow compared to kernel-space and this is obviously
expected, due to system calls overhead.

Then, i tried to map with ioremap() in the kernel and mmap() in the
user space the address of the memory-mapped GPIO register and I
noticed that on my platform (ARM, freescale imx6q) the kernel square
wave max frequency is ~5MHz compared to ~1.6MHz of user-space. In
theory, since both write in a virtual address mapped to a physical
address it should be the same (I verified the assembly of the kernel
module and of the user-space application and they have the same
instructions in the tested loop).

I concluded that the mmap() - since MAP_SHARED is required - sets the
VM_SHARED flag and the MMU of the ARM processor performs cache
coherency protocols that impact on GPIO switching performance, due to
the sharing flag in the page table.

I'm not sure if my analysis is correct, but, in that case, do you have
any other possible solution? Or a special flag for the mmap could be
proposed? In real-time application the performance of GPIO is often
important, and a 4x degradation from kernel-space to user-space can be
significant.


Cheers,
Federico Reghenzani
