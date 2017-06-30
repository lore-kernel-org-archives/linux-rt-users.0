From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH V2 2/2] rt: Increase/decrease the nr of migratory tasks
 when enabling/disabling migration
Date: Fri, 30 Jun 2017 10:51:49 +0200
Message-ID: <2ca2100a-334b-05af-8328-025ea9cb182f@redhat.com>
References: <cover.1498482127.git.bristot@redhat.com>
 <e981d271cbeca975bca710e2fbcc6078c09741b0.1498482127.git.bristot@redhat.com>
 <20170630073055.yp7x55zavoxlaxfl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35423 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdF3Ivz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2017 04:51:55 -0400
Received: by mail-qk0-f172.google.com with SMTP id 16so95857724qkg.2
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2017 01:51:55 -0700 (PDT)
In-Reply-To: <20170630073055.yp7x55zavoxlaxfl@gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 06/30/2017 09:30 AM, Ingo Molnar wrote:
> 
> * Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> There is a problem in the migrate_disable()/enable() implementation
>> regarding the number of migratory tasks in the rt/dl RQs. The problem
>> is the following:
>>
>> When a task is attached to the rt runqueue, it is checked if it either
>> can run in more than one CPU, or if it is with migration disable. If
>> either check is true, the rt_rq->rt_nr_migratory counter is not
>> increased. The counter increases otherwise.
>>
>> When the task is detached, the same check is done. If either check is
>> true, the rt_rq->rt_nr_migratory counter is not decreased. The counter
>> decreases otherwise. The same check is done in the dl scheduler.
>>
>> One important thing is that, migrate disable/enable does not touch this
>> counter for tasks attached to the rt rq. So suppose the following chain
>> of events.
>>
>> Assumptions:
>> Task A is the only runnable task in A      Task B runs on the CPU B
>> Task A runs on CFS (non-rt)                Task B has RT priority
>> Thus, rt_nr_migratory is 0                 B is running
>> Task A can run on all CPUS.
>>
>> Timeline:
>>         CPU A/TASK A                        CPU B/TASK B
>> A takes the rt mutex X                           .
>> A disables migration                             .
>>            .                          B tries to take the rt mutex X
>>            .                          As it is held by A {
>>            .                            A inherits the rt priority of B
>>            .                            A is dequeued from CFS RQ of CPU A
>>            .                            A is enqueued in the RT RQ of CPU A
>>            .                            As migration is disabled
>>            .                              rt_nr_migratory in A is not increased
>>            .
>> A enables migration
>> A releases the rt mutex X {
>>   A returns to its original priority
>>   A ask to be dequeued from RT RQ {
>>     As migration is now enabled and it can run on all CPUS {
>>        rt_nr_migratory should be decreased
>>        As rt_nr_migratory is 0, rt_nr_migratory under flows
>>     }
>> }
>>
>> This variable is important because it notifies if there are more than one
>> runnable & migratory task in the runqueue. If there are more than one
>> tasks, the rt_rq is set as overloaded, and then tries to migrate some
>> tasks. This rule is important to keep the scheduler working conserving,
>> that is, in a system with M CPUs, the M highest priority tasks should be
>> running.
>>
>> As rt_nr_migratory is unsigned, it will become > 0, notifying that the
>> RQ is overloaded, activating pushing mechanism without need.
>>
>> This patch fixes this problem by decreasing/increasing the
>> rt/dl_nr_migratory in the migrate disable/enable operations.
>>
>> Reported-by: Pei Zhang <pezhang@redhat.com>
>> Reported-by: Luiz Capitulino <lcapitulino@redhat.com>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
>> Cc: Clark Williams <williams@redhat.com>
>> Cc: Luiz Capitulino <lcapitulino@redhat.com>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: LKML <linux-kernel@vger.kernel.org>
>> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
>> ---
>>  kernel/sched/core.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> This second patch does not apply to the latest scheduler tree (tip:master) cleanly 
> - which tree is it against?

Hi Ingo,

migrate_disable/enable() are PREEMPT_RT specific, so the patch 2/2 is
addressed only to the PREEMPT_RT patch set.

I was working in the 4.11-rt tree.

The first one is not -rt specific, though.

Sorry for a possible miss communication...

-- Daniel


> Thanks,
> 
> 	Ingo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
