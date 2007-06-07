From: Oleg Kechin <okechin@gmail.com>
Subject: BUG: at kernel/sched.c:4031 __schedule()
Date: Thu, 07 Jun 2007 17:07:39 +0300
Message-ID: <4668112B.4090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:9513 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248AbXFGOGU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 10:06:20 -0400
Received: by ug-out-1314.google.com with SMTP id j3so694876ugf
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Jun 2007 07:06:19 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi
I run 2.6.20-rt8 kernel on board like innovator1510 (OMAP5910 cpu)
I notice in boot string:
BUG: at kernel/sched.c:4031 __schedule()
kernel complain interrupts are enabled after schedule.

digging in sched.c I figured out that interrupts are disabled when cpu 
enter __sched(),
but are enabled when it went out.
Playing with the code i can find out, that problem is in the next 
fragment: (line 4024)

   if (likely(prev != next)) {
       next->timestamp = now;
       rq->nr_switches++;
       rq->curr = next;
       ++*switch_count;

       prepare_task_switch(rq, next);
       prev = context_switch(rq, prev, next);
       barrier();
       trace_special_pid(prev->pid, PRIO(prev), PRIO(current));
       /*
        * this_rq must be evaluated again because prev may have moved
        * CPUs since it called schedule(), thus the 'rq' on its stack
        * frame will be invalid.
        */
       finish_task_switch(this_rq(), prev);
       __preempt_enable_no_resched();
   } else {

in prepare_task_switch(rq, next); interrupts are enabled,
but in finish_task_switch(this_rq(), prev); interrupts not disabled
(it look not symmetrical for me).

Can anybody tell - is this right behavior?
I think interrupts should be disabled somewhere in this fragment,
or may be, scheduler should not complain?

Oleg Kechin.
