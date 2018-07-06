Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx.beck-ipc.com ([195.243.140.130]:43397 "EHLO mx.beck-ipc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753224AbeGFI5y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Jul 2018 04:57:54 -0400
Received: from remote.beck-ipc.com (sde12.beckipc.net [172.30.2.12])
        by mx.beck-ipc.com (Postfix) with ESMTPS id CD54E11F7ED
        for <linux-rt-users@vger.kernel.org>; Fri,  6 Jul 2018 10:51:08 +0200 (CEST)
From: =?iso-8859-1?Q?Andr=E9_Pribil?= <a.pribil@beck-ipc.com>
Date: Fri, 6 Jul 2018 10:51:08 +0200
Subject: tty latency and RT
Message-ID: <681500CE65202E47A192754B01DAB4673BE3D87A37@SDE12.beckipc.net>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

Hello,

are there any plans to improve the latency with serial ttys and RT?

I'm seeing very high latencies (up to 100 ms) when a high priority 
RT thread accesses a serial tty port. I'm working with 4.14.52-rt34 
on a ARM system.

The reason for this issue seems to be that a kworker thread with a 
normal priority is involved here. When the high priority RT 
thread needs to wait for this kworker thread, it can easily be blocked 
by other lower priority RT threads running in the system.

I have seen that Steven Walter proposed some change in 2015, where
this kworker thread in replaced by a kthread with a RT priority if
the low_latency mode is selected.
See: https://www.spinics.net/lists/linux-serial/msg17782.html

The follow-up discussion in this thread also proposes a solution that
allows low_latency ports to directly execute the worker.
As interrupts are already threaded in PREEMPT_RT, wouldn't that be a 
solution?

Please excuse me if I got something wrong. 
Thanks in advance.

Andre
