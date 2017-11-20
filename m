From: bhargavb <bhargavaramudu@gmail.com>
Subject: sched_deadline behaviour when a real time process is throttled, with
 setting of /proc/sys/kernel/sched_rt_runtime_us is 950000
Date: Mon, 20 Nov 2017 22:41:17 +0530
Message-ID: <CA+bpL9KJXCD3G790pmKhTsHZMjOM3WOxAOX-BDZ6Jzm95XjcJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34704 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbdKTRLU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Nov 2017 12:11:20 -0500
Received: by mail-lf0-f46.google.com with SMTP id i14so10955318lfc.1
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Nov 2017 09:11:19 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Kindly help in understanding below things related to deadline
scheduler of linux.(HRT enabled,sched_rt_runtime_us = 950000, only 1
process with deadline scheduler policy, linux kernel 4.4, x86_64)

1)Uniprocessor case: When a real time process(deadline scheduled) is
throttled, ie exceeds its deadline say exceeded 900000 nanosec, it
will be throttled assuming no other real time process is running and
would be left to run till more 50000 nanoseconds but how does
scheduler behave beyond the sched_rt_runtime_us? Will the process
continue to run or the remaining 50000 ns allocated for non real time
processes?

2) Does it become any complex if it is a multiprocessor (SMP)? Does
the scheduler try to move this real time process to another processor
if feasible?

Hope, my question is clear enough basically.

Thanks in advance,
Bhargav
