Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-it1-f193.google.com ([209.85.166.193]:35746 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOUjc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Nov 2018 15:39:32 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so28536579itj.0
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2018 02:32:17 -0800 (PST)
MIME-Version: 1.0
From: Mohsen Alizadeh Noghani <m.alizad3h@gmail.com>
Date: Thu, 15 Nov 2018 14:02:07 +0330
Message-ID: <CADCeSy93=w7=h_fdRbkWu5FS9COrt5UYzE5X5vVh+Zkh-FhChg@mail.gmail.com>
Subject: Can't disable local timer interrupts on the isolated core
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hello everyone.
I'm using 4.4.162-rt175 and a core i3-4170 processor. I would like my
only real-time process (1 thread) to run on an isolated core, without
interruptions by the local timer.
* Support for fully tickless opration is enabled in the kernel configuration
CONFIG_NO_HZ_FULL=y
* Kernel boot parameters for isolating CPU 1,
isolcpus=1 nohz=on nohz_full=1 rcu_nocbs=1
However, even when I haven't assigned any process to CPU 1, it's being
interrupted by the timer tick at a rate of 1 KHz (HZ_1000=y), as seen
in the output of
cat /proc/interrupts
1- Is there something I'm missing in the configuration or boot parameters?
2- If tickless operation is not possible, what is the second-best
combination of timer tick handling and timer frequency configurations?
Is "Periodic timer ticks" preferable to "Idle dynticks system"? Is a
lower timer frequency better as the only process on the isolated CPU
gets interrupted less?
Best,
Mohsen
