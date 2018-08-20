Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-oi0-f50.google.com ([209.85.218.50]:46222 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeHTMuy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Aug 2018 08:50:54 -0400
Received: by mail-oi0-f50.google.com with SMTP id y207-v6so24640508oie.13
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Aug 2018 02:36:01 -0700 (PDT)
MIME-Version: 1.0
From: Vignesh Raman <vignesh.raman.in@gmail.com>
Date: Mon, 20 Aug 2018 15:05:49 +0530
Message-ID: <CAH3OF51v8_KK_XF_sttVzSddmWoLUvVOjbUvKr2OuiJTLntTQQ@mail.gmail.com>
Subject: kernel freeze when running docker
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hi,

I'm seeing a kernel freeze (and systemd reboots after few seconds)
when docker running kubernetes with debian 4.9 RT kernel
(4.9.0-6-rt-amd64).
This was tested with 4.14 -rt kernel and the issue was still seen.
kdump is not capturing the coredump in this case so I'm unable to
check the crash logs.
The system crash logs are not available in /sys/fs/pstore.

When manual crash is triggered with sysrq the kdump captures the crash
logs. But this does not work always.
Sometimes the system does not reboot when manual crash (sysrq) is
triggered and a freeze happens.
Maybe the capture kernel itself hangs while taking coredump.

When manual crash is triggered with sysrq the crash logs are available
in /sys/fs/pstore.

I'm able to reproduce a similar freeze/reset issue with the steps
mentioned here https://github.com/moby/moby/issues/19758.
Run "for f in $(seq 1 1000);do docker run -it --rm ubuntu echo $f;
done" concurrently in 3 terminals.
But I'm unable to confirm if both these issues are related due to
unavailability of crash logs.

Enabled CPUAccounting/MemoryAccounting in docker.service but the
system freeze was still seen.,
sudo systemctl set-property docker.service MemoryAccounting=yes
sudo systemctl set-property docker.service CPUAccounting=yes

I was thinking to enable CONFIG_RT_GROUP_SCHED (allocate real CPU
bandwidth to task groups). But this is disabled if PREEMPT_RT_FULL is
enabled.

I'm unable to root cause the reason for freeze/crash because crash
logs are not available.
Is there any other way to capture the crashdump? Any pointers will be
helpful. Thanks.

Regards,
Vignesh
