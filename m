From: Yong Zhang <yong.zhang0@gmail.com>
Subject: migrate_disable() race with cpu hotplug?
Date: Tue, 26 Jul 2011 16:59:48 +0800
Message-ID: <CAM2zO=AxRYEG=iJqrefOL34GW5ukoQKxYQdJ02mez=s5UZPoJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:65464 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1GZI7t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Jul 2011 04:59:49 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When reading the code, I'm afraid there is a race between migrate_disable()
and cpu hotplug. A scenario will like below:

	CPU0			CPU1
_cpu_down();
  cpu_unplug_begin();
    wait_for_completion()
  			sync_unplug_thread();
			  complete();
			race_window? /*
				      * migrate_disable() will
				      * not take effect since
				      * hotplug is in progress
				      */

  __stop_machine();

I think it could happen but maybe I'm missing something.

Thanks,
Yong


-- 
Only stand for myself
