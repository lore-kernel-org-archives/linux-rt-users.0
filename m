From: Tim Blechmann <tim@klingt.org>
Subject: 2.6.25.4-rt1 problem
Date: Mon, 19 May 2008 09:43:29 +0000 (UTC)
Message-ID: <g0ri41$b23$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:33342 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbYESJnk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 05:43:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jy1u5-0004Pg-RQ
	for linux-rt-users@vger.kernel.org; Mon, 19 May 2008 09:43:37 +0000
Received: from 85-127-249-46.dynamic.xdsl-line.inode.at ([85.127.249.46])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 19 May 2008 09:43:37 +0000
Received: from tim by 85-127-249-46.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 19 May 2008 09:43:37 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi all,

the release of the realtime kernel for 2.6.25.4 does not boot for me.

i am getting the following kernel stack trace (i had to write it down, so 
i am not sure, if necessary information is missing):

__schedule
ktime_get
getnstimeofday
tick_program_event
task_blocks_on_rt_mutex
tick_broadcast_oneshot_control
schedule
rt_spin_lock_slowlock
pm_qos_requirement
menu_select
cpuidle_idle_call
default_idle
cpuidle_idle_call
cpuidle_idle_call
cpu_idle

thanks, tim

-- 
tim@klingt.org
http://tim.klingt.org

Every word is like an unnecessary stain on silence and nothingness
  Samuel Beckett

