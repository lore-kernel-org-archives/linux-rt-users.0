From: Raz <raziebe@gmail.com>
Subject: hpet0 versus hpet2
Date: Sun, 29 Jun 2014 15:49:31 +0300
Message-ID: <CAPB=Z-q3HyP7W3Env8m=VELPMfBhRhAQwmfPyT3G9_9PQhFW2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:49084 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbaF2Mtw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Jun 2014 08:49:52 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so7574983obc.37
        for <linux-rt-users@vger.kernel.org>; Sun, 29 Jun 2014 05:49:51 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Rt folks

I performed a benchmark that compares the jitter of hpet2 to hpet0.
hpet0 is reserved to the kernel use ( hpet_reserve_timer(&hd, 0).
and hd.hd_irq[0] = HPET_LEGACY_8254; in arch/x86/kernel/hpet.c).
I removed these two lines.
The bellow is a histogram compares the default hpet2 to hpet0 in atom D525.
The test performed is a simple udp sender, it sends a single udp
packet each 1ms interval.
Time stamping were made by Beckhoff ET2000 ,so that the timestamps
taken by a reliable and accurate tool.
Question is whether it is possible to push a new kernel boot command
line option that gives
the user hpet0 ?

hpet0
-50    0
-40    0
-20    2
-10    14
-5    143
-1    3992
1    95217
5    544
10    74
20    14
30    0
40    0
50    0
More    0


hpet2

Bin    Frequency
-50    1
-40    0
-20    0
-10    0
-5    0
-1    1
1    18
5    71
10    854
20    93098
30    237
40    1069
50    0
More    0
