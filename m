From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: task switch from net-rx to idle when there is napi processing to
 be done
Date: Tue, 24 Jan 2012 18:39:34 -0800
Message-ID: <4F1F6B66.5010005@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18832 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab2AYCjg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jan 2012 21:39:36 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In the process of debugging a napi ethernet driver performance issue, 
what I am noticing is

1. While the driver is in the middle of a napi packet processing loop, 
there is a task switch from
sirq-net-rx to idle even though there is pending napi processing to be done.

2. This task switch seems to happen every second
venkat@vs-lnx:~/nfss/trace$ grep "sched_switch: task sirq-net-rx" trace 
| grep swapper
    sirq-net-rx/0-7     [000]  3800.664615: sched_switch: task 
sirq-net-rx/0:7 [50] (R) ==> swapper:0 [120]
    sirq-net-rx/0-7     [000]  3801.663616: sched_switch: task 
sirq-net-rx/0:7 [50] (R) ==> swapper:0 [120]
    sirq-net-rx/0-7     [000]  3802.664615: sched_switch: task 
sirq-net-rx/0:7 [50] (R) ==> swapper:0 [120]
    sirq-net-rx/0-7     [000]  3803.664615: sched_switch: task 
sirq-net-rx/0:7 [50] (R) ==> swapper:0 [120]
    sirq-net-rx/0-7     [000]  3804.664614: sched_switch: task 
sirq-net-rx/0:7 [50] (R) ==> swapper:0 [120]
    sirq-net-rx/0-7     [000]  3805.664619: sched_switch: task 
sirq-net-rx/0:7 [50] (R) ==> swapper:0 [120]

3. A log of one of the task switch is as
    sirq-net-rx/0-7     [000]  3800.664567: cvm_oct_napi_poll_38: 
napi_poll_cnt=2480984 backlog=2 rx_count=18 drop_cnt=0
    sirq-net-rx/0-7     [000]  3800.664569: cvm_oct_napi_poll_38 
<-net_rx_action
    sirq-net-rx/0-7     [000]  3800.664608: preempt_schedule_irq 
<-need_resched
    sirq-net-rx/0-7     [000]  3800.664610: __schedule 
<-preempt_schedule_irq
    sirq-net-rx/0-7     [000]  3800.664615: sched_switch: task 
sirq-net-rx/0:7 [50] (R) ==> swapper:0 [120]
<idle>-0     [000]  3800.714604: __schedule <-cpu_idle
<idle>-0     [000]  3800.714608: sched_switch: task swapper:0 [120] (R) 
==> sirq-net-rx/0:7 [50]
    sirq-net-rx/0-7     [000]  3800.714611: __schedule 
<-preempt_schedule_irq
    sirq-net-rx/0-7     [000]  3800.714691: cvm_oct_napi_poll_38: 
napi_poll_cnt=2480985 backlog=1 rx_count=32 drop_cnt=0


4. The logs in 3 tell show that the driver was in the napi polling 
thread method cvm_oct_napi_poll_38 when the scheduler was invoked.
Looks like this was probably due to a hard irq happening. The main 
problem I see  is the scheduler switching the tasks from
sirq-net-rx to idle even though there is napi processing to be done. 
Appreciate any hints to debug this further.

Notes
------
* This is with PREEMPT_RT turned on and 2.6.32 version of the kernel 
which has a backport of 2.6.33.9-rt31 patch.

Thanks a lot for reading this far and any thoughts you may have!
-Venkat


