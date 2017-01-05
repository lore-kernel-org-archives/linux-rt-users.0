From: Federico Reghenzani <federico.reghenzani@polimi.it>
Subject: NO_HZ and ktimersoftd
Date: Thu, 5 Jan 2017 10:29:57 +0100
Message-ID: <CACKey4zmx_=k6r8BY3B7K9ZuR6x5=11U25-st4oK8WAgo1WgQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve1eur01on0081.outbound.protection.outlook.com ([104.47.1.81]:23212
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755593AbdAEJa1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Jan 2017 04:30:27 -0500
Received: by mail-oi0-f47.google.com with SMTP id 3so390734878oih.1
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Jan 2017 01:30:21 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'm trying to setup a RT Linux system (currently on 4.8.2 PREEMPT_RT
patched), and I enabled he NO_HZ_FULL flag in order to reduce the
scheduling interrupts jitter. Trying to isolate one core, I also moved
all interrupts and threads to other CPUs.

This works fine, however when I run my RT application, the thread
kimersoftd is always in "running" state, thus the scheduling interrupt
triggers (because there exists more than 1 task available to run).
Consequently, the advantages of NO_HZ_FULL are vanished.

With kernel trace I found these events on the isolated CPU:

       user_loop-772   [003] d..h...   419.818172: softirq_raise:
vec=1 [action=TIMER]
       user_loop-772   [003] d...2..   419.818174: sched_switch:
prev_comm=user_loop prev_pid=772 prev_prio=120 prev_state=R ==>
next_comm=ktimersoftd/3 next_pid=41 next_prio=98
   ktimersoftd/3-41    [003] .....11   419.818175: softirq_entry:
vec=1 [action=TIMER]
   ktimersoftd/3-41    [003] .....11   419.818176: softirq_exit: vec=1
[action=TIMER]
   ktimersoftd/3-41    [003] d...2..   419.818177: sched_switch:
prev_comm=ktimersoftd/3 prev_pid=41 prev_prio=98 prev_state=S ==>
next_comm=user_loop next_pid=772 next_prio=120

I don't know why ktimersoftd is running at every tick.


Thank you in advance for any hint,
Federico
