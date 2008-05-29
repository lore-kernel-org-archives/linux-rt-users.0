From: "Javier Sanz" <jsanza@gmail.com>
Subject: problem compiling 2.6.25.4-rt4 x86
Date: Thu, 29 May 2008 20:44:52 +0200
Message-ID: <a3d4028e0805291144y2331bdbbtab783ba785800b27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:42809 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbYE2Soz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 May 2008 14:44:55 -0400
Received: by py-out-1112.google.com with SMTP id p76so2821450pyb.10
        for <linux-rt-users@vger.kernel.org>; Thu, 29 May 2008 11:44:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I got the following problem trying to compile 2.6.25.4-rt4:

darkstar linux-2.6.25.4-rt4]# make
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      kernel/sched.o
kernel/sched.c: In function 'add_preempt_count':
kernel/sched.c:3950: warning: unused variable 'parent_eip'
kernel/sched.c:3949: warning: unused variable 'eip'
kernel/sched.c: In function 'sched_init':
kernel/sched.c:7677: error: implicit declaration of function 'global_rt_runtime'
make[1]: *** [kernel/sched.o] Error 1
make: *** [kernel] Error 2
[root@darkstar linux-2.6.25.4-rt4]#


am i doing something wrong?

thank you

Linux darkstar 2.6.25.3-18.fc9.i686 #1 SMP Tue May 13 05:38:53 EDT
2008 i686 athlon i386 GNU/Linux
