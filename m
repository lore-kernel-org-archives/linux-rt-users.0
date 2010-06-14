From: Maksym Parkachov <lazy.gopher@gmail.com>
Subject: beagleboard RT problem
Date: Mon, 14 Jun 2010 10:32:19 +0200
Message-ID: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33421 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab0FNIcV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jun 2010 04:32:21 -0400
Received: by bwz7 with SMTP id 7so1901666bwz.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jun 2010 01:32:19 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Everyone,

I'm trying to get PREEMPT RT kernel running on beagleboard (ARM).
After resolving many issues with the patch on the Angstrom stable distribution,
I've got the RT kernel running.

root@beagleboard:~/rt-tests# uname -a
Linux beagleboard 2.6.29.6-rt24-omap1 #1 PREEMPT RT Sun Jun 13
17:51:45 CEST 2010 armv7l unknown

So, it seems to be fine. But trying to run the Cyclictest tells me
that RT is not working.

0% - load
root@beagleboard:~/rt-tests# ./cyclictest -t1 -p 80 -n -i 10000 -l 10000 -q
T: 0 ( 2352) P:80 I:10000 C:  10000 Min:     15 Act:  203 Avg:  195 Max:     365

100% - load
root@beagleboard:~/rt-tests# ./cyclictest -t1 -p 80 -n -i 10000 -l 10000 -q
T: 0 ( 2348) P:80 I:10000 C:  10000 Min:     39 Act:48697 Avg: 1584 Max:   48727

I'm bit lost in how to debug the problem. I checked the /proc/config.gz

root@beagleboard:~/rt-tests# zcat /proc/config.gz | grep PREEMPT
CONFIG_PREEMPT_RCU=y
# CONFIG_PREEMPT_RCU_TRACE is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_DESKTOP is not set
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_DEBUG_PREEMPT=y
# CONFIG_PREEMPT_TRACER is not set

I would really appreciate some suggestions on how to identify the problem.

Regards,
Maksym Parkachov.
