From: Dragan Noveski <perodog@gmx.net>
Subject: 2.6.22.1-rt7 does not build here
Date: Wed, 25 Jul 2007 17:52:05 +0200
Message-ID: <46A771A5.4000008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:33681 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751403AbXGYNwU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 09:52:20 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi list, i am trying to compile the 2.6.22.1-rt7 here and i get this 
error while running 'make && make modules':

  LD [M]  arch/i386/crypto/aes-i586.o
  CC      kernel/sched.o
kernel/sched.c:1159: error: redefinition of '__set_task_cpu'
include/linux/sched.h:2053: error: previous definition of 
'__set_task_cpu' was here
make[1]: *** [kernel/sched.o] Fehler 1
make: *** [kernel] Fehler 2
nowhiskey@murija2:/usr/src/linux-2.6.22.1$

the rt6 builds here fine with the same config file.

cheers,
doc
