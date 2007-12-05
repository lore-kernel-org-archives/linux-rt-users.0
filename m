From: "Phil K." <binutz@gmail.com>
Subject: Problems with cyclictest and ps
Date: Wed, 05 Dec 2007 21:34:24 +0100
Message-ID: <47570B50.9060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:27684 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXLEUgv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 15:36:51 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1222053mue
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Dec 2007 12:36:45 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I tried cyclictest under Debian Lenny with Kernel-2.6.23.8-hrt3 and
Kernel-2.6.22 as user root. As decribed on the cyclictest-wikipage all
cyclictest-tasks run with the scheduler class SCHED_FIFO. I controlled
the scheduler class with "ps -ce" and ps showed me SCHED_OTHER for the
cyclictest-task.

#> ./cyclictest -t 1 -p 80 -n -i 10000

#> ps -ce | grep cyclic
   PID CLS PRI TTY          TIME CMD
  9693 TS   19 pts/5    00:00:00 cyclictest

I am wondering why cyclictest runs as SCHED_OTHER I expected SCHED_FIFO
instead. Any explanations of this behavior are welcome.

Regards,

Phil
