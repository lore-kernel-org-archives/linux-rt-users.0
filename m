From: Dmitry Lysenko <dvl36.ripe.nick@gmail.com>
Subject: Build failure. Typo in the 3.2.43-rt63 patch?
Date: Sat, 20 Apr 2013 12:09:39 +0300
Message-ID: <51725B53.2030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:64098 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab3DTJJo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Apr 2013 05:09:44 -0400
Received: by mail-wi0-f173.google.com with SMTP id c10so1927519wiw.0
        for <linux-rt-users@vger.kernel.org>; Sat, 20 Apr 2013 02:09:43 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

After applying rt63 patch to fresh 3.2.43 I got:
....
   CC      kernel/rcutiny.o
In file included from kernel/rcutiny.c:54:0:
kernel/rcutiny_plugin.h: In function 'invoke_rcu_callbacks':
kernel/rcutiny_plugin.h:886:2: error: implicit declaration of function 
'swake_up' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[2]: *** [kernel/rcutiny.o] Error 1
make[1]: *** [kernel] Error 2
make[1]: Leaving directory `/root/linux-3.2.43'
make: *** [debian/stamp/build/kernel] Error 2
--------

Then I tried this:

-------
root@debian:~/linux-3.2.43# grep -R swake_up
kernel/rcutiny_plugin.h:    swake_up(&rcu_kthread_wq);
patch-3.2.43-rt63.patch:+    swake_up(&rcu_kthread_wq);
root@debian:~/linux-3.2.43#
-------

Finally I manualy changed swake_up to swait_wake in rcutiny_plugin.h 
(line 886).
(don't know is it right), but kernel is builded now.

Dmitry.

P.S. Marvell Kirkwood  native build.
