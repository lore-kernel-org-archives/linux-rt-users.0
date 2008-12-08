From: Tim Blechmann <tim@klingt.org>
Subject: BUG: using smp_processor_id() in preemptible
Date: Mon, 8 Dec 2008 12:13:31 +0000 (UTC)
Message-ID: <ghj31b$bmr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60282 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbYLHMNt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Dec 2008 07:13:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L9ezf-0005HC-RR
	for linux-rt-users@vger.kernel.org; Mon, 08 Dec 2008 12:13:44 +0000
Received: from 85-127-249-120.dynamic.xdsl-line.inode.at ([85.127.249.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Dec 2008 12:13:43 +0000
Received: from tim by 85-127-249-120.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Dec 2008 12:13:43 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi all,

using the 2.6.26.6-rt11 patchset on a 2.6.26.8 kernel, i get the 
following stack traces:

[ 4262.931832] BUG: using smp_processor_id() in preemptible [00000000] code: bash/361
[ 4262.931846] caller is mem_cgroup_charge_statistics+0x6d/0xa0
[ 4262.931852] Pid: 361, comm: bash Not tainted 2.6.26.8-rt11 #3
[ 4262.931855] 
[ 4262.931856] Call Trace:
[ 4262.931886]  [<ffffffff80396e8c>] debug_smp_processor_id+0xcc/0xd0
[ 4262.931895]  [<ffffffff802daead>] mem_cgroup_charge_statistics+0x6d/0xa0
[ 4262.931905]  [<ffffffff802daf19>] __mem_cgroup_add_list+0x39/0x60
[ 4262.931911]  [<ffffffff802db744>] mem_cgroup_charge_common+0x314/0x330
[ 4262.931925]  [<ffffffff802db78e>] mem_cgroup_charge+0xe/0x10
[ 4262.931933]  [<ffffffff802b8773>] do_wp_page+0x133/0x5a0
[ 4262.931944]  [<ffffffff804d7461>] ? __rt_spin_lock+0x81/0x90
[ 4262.931956]  [<ffffffff802ba805>] handle_mm_fault+0x605/0x900
[ 4262.931975]  [<ffffffff804dacfc>] do_page_fault+0x45c/0xd50
[ 4262.931998]  [<ffffffff8021d6ee>] ? native_smp_send_reschedule+0x2e/0x50
[ 4262.932006]  [<ffffffff8023a041>] ? __resched_task+0x91/0x120
[ 4262.932015]  [<ffffffff8023b5f4>] ? task_new_fair+0xb4/0x100
[ 4262.932027]  [<ffffffff8023e09b>] ? wake_up_new_task+0xdb/0x190
[ 4262.932038]  [<ffffffff80241190>] ? do_fork+0xf0/0x330
[ 4262.932048]  [<ffffffff804d748e>] ? rt_spin_lock+0x1e/0x50
[ 4262.932056]  [<ffffffff802dbad2>] ? fd_install+0x52/0x60
[ 4262.932072]  [<ffffffff804d81c9>] error_exit+0x0/0x60

hth, tim

-- 
tim@klingt.org
http://tim.klingt.org

There's no such entity as "most people". These are generalities. All
generalities are meaningless. You've got to pin it down to a specific
person doing a specific thing at a specific time and space.
  William S. Burroughs

