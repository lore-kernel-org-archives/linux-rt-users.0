From: Jordi Pujol <jordipujolp@gmail.com>
Subject: various tests for 3.0 rt3
Date: Mon, 25 Jul 2011 17:38:50 +0200
Message-ID: <201107251738.51473.jordipujolp@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	"J. R. Okajima" <hooanon05@yahoo.co.jp>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42424 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab1GYPi4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jul 2011 11:38:56 -0400
Received: by wyg8 with SMTP id 8so2835768wyg.19
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jul 2011 08:38:54 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Testing 3.0 rt3 with overlayfs, aufs, tuxonice, nvidia drivers,

to compile the NVIDIA propietary driver, kernel has to export as non-GPL the 
following symbols,

__rt_mutex_init
migrate_enable
migrate_disable

tuxonice suspends and resumes to S1 successfully, (have not tested S3, by 
now),
but can not hibernate to disk, the system is locked just when suspend to disk 
begins to show the message "Doing atomic copy/restore."

aufs works without any modification

overlayfs works also

also, the rt3 patch has needed a bit of modification for a succesful 
application, there is a conflict with another patch:
candidate/0020-x86-mtrr-lock-stop-machine-during-MTRR-rendezvous-se.patch

***
@@ -151,6 +151,7 @@ void stop_one_cpu_nowait(unsigned int cp
 }

 DEFINE_MUTEX(stop_cpus_mutex);
+DEFINE_MUTEX(stopper_lock);
 /* static data for stop_cpus */
 static DEFINE_PER_CPU(struct cpu_stop_work, stop_cpus_work);

***

Thanks,

Jordi Pujol

Live never ending Tale
GNU/Linux Live forever!
http://livenet.selfip.com
