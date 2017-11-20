From: bhargavb <bhargavaramudu@gmail.com>
Subject: Real time application programming - sched_setattr() fails if I set
 CPU affinity using sched_setaffinity().
Date: Mon, 20 Nov 2017 10:09:01 +0530
Message-ID: <CA+bpL9+PrYxrBVX_CQxxqqXv07QGULJfdbCx1zoSu=Bir7hy3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46466 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdKTEjD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 19 Nov 2017 23:39:03 -0500
Received: by mail-lf0-f68.google.com with SMTP id g35so8530392lfi.13
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Nov 2017 20:39:03 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Working on a real time application, Getting runtime error at
sched_setattr as "Operation Not permitted".Running on Ubuntu 16.04 LTS
(4.4.0-97-generic kernel, x86_64 platform)
C program code excerpt as below:

unsigned int flags = 0;
sched_getattr(0, &attr, sizeof (struct sched_attr), 0);
if (ret != 0)
perror("getattr failed:");
attr.sched_policy = SCHED_DEADLINE;
attr.sched_runtime = 5 * 100 * 1000;
attr.sched_deadline = 8 * 100 * 1000;
attr.sched_period = 10 * 100 * 1000;
attr.size = sizeof (attr);
attr.sched_flags = 0;
attr.sched_nice = 0;
attr.sched_priority = 0;

if(sched_setaffinity(0,sizeof(set), &set) < 0)
{
perror("sched_setaffinity :");
return 0;
}
ret = sched_setattr(0, &attr, flags);
if(ret!=0)
{
perror("sched_setattr failed: ");
}

But, If I comment the sched_setaffinity() call, it runs without error.
Also, using SCHED_FIFO by calling sched_setscheduler() doesn't give me
any error after setting CPU affinity. Only the combination of
sched_setaffinity with sched_setattr() generates error. I am running
in sudo mode.

Thanks in advance,
Bhargav
