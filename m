From: Gaye Abdoulaye Walsimou <walsimou@walsimou.com>
Subject: compile error for mips with 2.6.29.2-rt10
Date: Fri, 01 May 2009 18:40:57 +0200
Message-ID: <49FB2619.7070608@walsimou.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from walscop001.walsimou.com ([82.228.201.70]:52277 "EHLO
	bekkor.walsimou.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbZEAQqB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 May 2009 12:46:01 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello list,
I use 2.6.29.2-rt10 patch on linux-2.6.29.2 (from linux-mips.org and for
bcm47xx MCU) and I had following compilation error:

kernel/sched.c: In function 'finish_task_switch':
kernel/sched.c:2902: error: implicit declaration of function
'_finish_arch_switch'
make[1]: *** [kernel/sched.o] Error 1
make: *** [kernel] Error 2

When I change "_finish_arch_switch" to "finish_arch_switch" in
kernel/sched.c, no compilation error, but I didn't try resulting vmlinux.

Do I miss something?

Thanks
