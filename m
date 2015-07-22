From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Where IOSCHED ?
Date: Wed, 22 Jul 2015 23:05:24 +0300
Message-ID: <55AFF784.7040900@pavlinux.ru>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp01.mtu.ru ([62.5.255.10]:46601 "EHLO imp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbbGVUFc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2015 16:05:32 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

# dmesg | grep sched
[    0.387902] io scheduler noop registered
[    0.387989] io scheduler deadline registered
[    0.388079] io scheduler cfq registered (default)

# cat /boot/config-3.18.17-rt14 | grep IOSCHED
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_IOSCHED="cfq"

# cat /sys/block/sda/queue/scheduler
none

# uname -a
Linux localhost 3.18.17-rt14 #1 SMP PREEMPT RT Wed Jul 22 18:49:51 MSK 2015 
x86_64 GNU/Linux
-- 

                                                          Pavel.
