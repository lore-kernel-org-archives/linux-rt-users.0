From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 2.6.33.1-rt11 BUG: sleeping function called from invalid context
 at kernel/rtmutex.c:684
Date: Sun, 04 Apr 2010 11:14:39 +0200
Message-ID: <4BB8587F.40307@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pindarots.xs4all.nl ([80.101.128.228]:39190 "EHLO
	pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0DDJYV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Apr 2010 05:24:21 -0400
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
	by pindarots.xs4all.nl (8.14.3/8.14.3) with ESMTP id o349EdNd003347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Sun, 4 Apr 2010 11:14:39 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I see a load of these after booting into 2.6.33.1-rt11:

BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 0, pid: 1507, name: md1_raid5
Pid: 1507, comm: md1_raid5 Not tainted 2.6.33.1-rt11 #1
Call Trace:
 [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
 [<ffffffff812becc4>] ? __raid_run_ops+0x304/0xc60
 [<ffffffff812c0ccd>] ? handle_stripe+0x6bd/0x1a70
 [<ffffffff8104b460>] ? mod_timer+0x150/0x200
 [<ffffffff812c23f6>] ? raid5d+0x376/0x4f0
 [<ffffffff8138e5bd>] ? schedule_timeout+0x22d/0x2b0
 [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
 [<ffffffff812cd0f3>] ? md_thread+0x53/0x120
 [<ffffffff810573a0>] ? autoremove_wake_function+0x0/0x30
 [<ffffffff812cd0a0>] ? md_thread+0x0/0x120
 [<ffffffff81057016>] ? kthread+0x96/0xa0
 [<ffffffff81037908>] ? finish_task_switch+0x58/0xd0
 [<ffffffff810032d4>] ? kernel_thread_helper+0x4/0x10
 [<ffffffff81056f80>] ? kthread+0x0/0xa0
 [<ffffffff810032d0>] ? kernel_thread_helper+0x0/0x10

As these appear to be touching my raid array I am quite eager to learn
how I can fix the BUGs.

Please have a look and explain.

Kind regards,
Udo
