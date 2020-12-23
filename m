Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CFC433E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Dec 2020 09:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E244224B1
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Dec 2020 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgLWJYB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Dec 2020 04:24:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:59585 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgLWJYB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Dec 2020 04:24:01 -0500
IronPort-SDR: mDmE/vYJs4WbdJdTH8mEG/TcWvDGD/mk6SmIVeVDdpP42eru9kni1rvVegxQtmxlu7QEDGdm2o
 nxH+CnnfGisQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="175213839"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="175213839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 01:23:09 -0800
IronPort-SDR: UwqtR0eXFn6xgfZfTwQnR+HJDn6Q5zLEszCjEhS2CSoBsSKtpdpb3aKD/NVoJhaDzMtSJ+DeGf
 oxpTnSlPSPdg==
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="344978940"
Received: from rthomas-desk1.sc.intel.com ([10.3.52.142])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 01:23:09 -0800
From:   ramesh.thomas@intel.com
To:     linux-rt-users@vger.kernel.org
Cc:     Ramesh Thomas <ramesh.thomas@intel.com>, williams@redhat.com,
        frederic@kernel.org, bigeasy@linutronix.de
Subject: [PATCH 0/1] nohz_full state entry failure in preempt_rt and proposed fix
Date:   Wed, 23 Dec 2020 04:20:34 -0500
Message-Id: <20201223092034.528782-1-ramesh.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Ramesh Thomas <ramesh.thomas@intel.com>

Hello,

This addresses an issue we have been facing with preempt_rt kernels not
able to enter nohz_full state consistently. Following are my debug
findings and details of a tool I had devloped that can help reproduce
the issue. Following patch has a proposed fix or at least a pointer to
areas worth looking into. We need preempt_rt for determinism and being
able to use nohz_full along with it is very valuable.

Problem:
Sometimes nohz_full state is never entered even when all necessary
conditions are met. It is easier to reproduce the issue in preempt_rt
kernel, however it may not be limited to preempt_rt.

Debug findings and proposed fix:
Observed that in the failure condition, entry into nohz_full state is
repeatedly aborted due to the detection of a pending timer event in the
next period in tick_nohz_next_event(). The issue is not reproduceable if
tick stoppage is not bailed out here. The skipping of the bailing out
code is done only if CONFIG_NO_HZ_FULL is defined. Since in nohz_full
mode, idle state is not entered when ticks are being stopped, aborting
tick stoppage may not be necessary. It is simpler to let the common code
that handles reprogramming of the timer at tick_nohz_stop_tick() handle
the next tick. 

Environment to reproduce:
Used Intel NUCs with 4 cores (Apollo Lake and Tiger Lake). Easier to
reproduce in embedded platforms. 

Kernel version:5.10.1-rt19 (This is not a new issue and I have seen it
in rt kernel version 4.17)

Relevant kernel config flags:
- NO_HZ_FULL=y
- PREEMPT_RT=y
- CPU_ISOLATION=y
- RCU_NOCB_CPU=y

Relevant kernel boot parameters:
- isolcpus=nohz,domain,1,3 nohz_full=1,3 rcu_nocbs=1,3 irqaffinity=0
- cpufreq.off=1 idle=poll cpuidle.off=1

Steps to reproduce:
1. Disable rt throttling assigning 100% scheduler period to rt tasks
2. Set cpu affinity to one of the nohz_full cpus
3. Set scheduling policy to sched_fifo with max priority
4. Wait till "tick_stopped" gets set in /proc/timer_list
5. Return failure if tick is not stopped in 15 seconds
6. Run above steps in a loop to stress it. It may take a while to
reproduce.

The above can be done using a tool I had developed as part of a
framework to assist setting up CPU thread isolation and measuring
jitter. It can be found at https://github.com/intel/tif

Build the tif_test app and run as follows using the included script to
run it in a loop till the failure is reproduced. 

make test
./tif_stress.sh

e.g. output. 
"Test# 818
Successfully entered nohz state in 724us

Error entering nohz state after 15000102us
Reproduced NOHZ_FULL failure after 818 tries!!!
Test elapsed time: 835 seconds"

(PS: The framework has a workaround for the issue which is not used in
the test. The workaround that helped was, switching CPU affinity in and
out of the nohz_full CPU giving the scheduler a fresh start)


Ramesh Thomas (1):
  dynticks/preempt_rt: Fix a nohz_full entry failure in preempt_rt

 kernel/time/tick-sched.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.26.2

