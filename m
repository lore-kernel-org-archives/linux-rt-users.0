From: Chris Friesen <chris.friesen@windriver.com>
Subject: question about rcuc/X tasks
Date: Mon, 12 Dec 2016 16:42:00 -0600
Message-ID: <584F27B8.2090406@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:37326 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbcLLWmE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Dec 2016 17:42:04 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id uBCMg3qS029835
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Dec 2016 14:42:03 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm testing the CentOS 7.3 RT kernel, 3.10.0-514.rt56.420

(I realize this is a heavily-patched kernel, but I'm hoping general information 
will still apply.)

My kernel is booted with "isolcpus=1-15 rcu_nocbs=1-15" as kernel parameters, 
and /dev/cpu_dma_latency is set to 3.  The relevent config options are set as 
follows:

CONFIG_PREEMPT=y
CONFIG_PREEMPT_RT_BASE=y
CONFIG_HAVE_PREEMPT_LAZY=y
CONFIG_PREEMPT_LAZY=y
CONFIG_PREEMPT_RT_FULL=y
CONFIG_RCU_BOOST=y
CONFIG_RCU_KTHREAD_PRIO=2
CONFIG_RCU_BOOST_DELAY=500
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_NONE=y

The issue I'm seeing is that when I run cyclictest, ftrace shows rcuc/<cpu> 
running for 5-6 usec quite a few times per second.

Based on the fact that Documentation/kernel-per-CPU-kthreads.txt describes 
CONFIG_RCU_NOCB_CPU_ALL=y as a solution by preventing the rcuc/%u kthreads from 
having any work to do, I had expected that the "rcu_nocbs=1-15" kernel parameter 
would have a similar effect.

Does anyone have any idea what's going on here, and how I can prevent the 
rcuc/<cpu> tasks from waking up?

Thanks,
Chris
