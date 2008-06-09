From: ciaby <ciaby@autistici.org>
Subject: Re: [PATCH] 2.6.25.4-rt6: missing =?UTF-8?Q?global=5Frt=5Fruntime=28=29?=
 =?UTF-8?Q?=20in=20sched=2Ec?=
Date: Mon, 09 Jun 2008 10:08:23 +0000
Message-ID: <d7bf0be20a03f63c7e0f91164b4e1adb@localhost>
References: <7688fdc041a8f848b0627dccccddcf12@localhost> <a3d4028e0806090255x7301df1kd2c0fbc9d1e678c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vilipendio.investici.org ([216.17.130.5]:32726 "EHLO
	vilipendio.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758512AbYFIKIY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jun 2008 06:08:24 -0400
In-Reply-To: <a3d4028e0806090255x7301df1kd2c0fbc9d1e678c1@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Probably because you don't use Group Scheduling:



--

#ifdef CONFIG_RT_GROUP_SCHED

                init_task_group.rt_runtime = global_rt_runtime();

                INIT_LIST_HEAD(&rq->leaf_rt_rq_list);

                init_tg_rt_entry(rq, &init_task_group,

                                &per_cpu(init_rt_rq, i),

                                &per_cpu(init_sched_rt_entity, i), i, 1);

#endif

--



If you enable it, it tries to initialize the init_task_group.rt_runtime,

but the global_rt_runtime() function has been lost somewhere between -rt3

and -rt4. I sent the patch again, i hope is gonna be in the next -rt

release.

Cheers



Giovanni "ciaby" Civardi





On Mon, 9 Jun 2008 11:55:49 +0200, "Javier Sanz" <jsanza@gmail.com> wrote:

> Umm,

> 

>  I think that  -rt6 compile ok without you patch, for me, at least  ...

> 

> Regards

> 

> J

> 

> 

> 2008/6/9 ciaby <ciaby@autistici.org>:

> 

>>

>> I already sent this patch, but seems that nobody cared... the last 2

>>

>> revisions of the -rt kernel don't compile properly.

>>

>> Second patch to fix this.

>>

>> Regards

>>

>>

>>

>> Giovanni "ciaby" Civardi

>>

>>

>>

>> diff -uNr linux-2.6.25.4-rt6.orig/kernel/sched.c

>>

>> linux-2.6.25.4-rt6/kernel/sched.c

>>

>> --- linux-2.6.25.4-rt6.orig/kernel/sched.c      2008-06-09

>>

>> 11:35:57.000000000 +0200

>>

>> +++ linux-2.6.25.4-rt6/kernel/sched.c   2008-06-09 11:40:45.000000000

> +0200

>>

>> @@ -672,6 +672,13 @@

>>

>>  */

>>

>>  #define RUNTIME_INF    ((u64)~0ULL)

>>

>>

>>

>> +static u64 global_rt_runtime(void)

>>

>> +{

>>

>> +       if (sysctl_sched_rt_period < 0)

>>

>> +               return RUNTIME_INF;

>>

>> +       return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;

>>

>> +}

>>

>> +

>>

>>  /*

>>

>>  * We really dont want to do anything complex within switch_to()

>>

>>  * on PREEMPT_RT - this check enforces this.

>>

>>

>>

>> --

>> To unsubscribe from this list: send the line "unsubscribe

> linux-rt-users"

>> in

>> the body of a message to majordomo@vger.kernel.org

>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

>>

