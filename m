From: Henri Roosen <henri.roosen@ginzinger.com>
Subject: Re: INFO: rcu_preempt detected stalls on CPUs/tasks
Date: Wed, 19 Oct 2016 17:17:53 +0200
Message-ID: <d4fe0634-99eb-deaa-ff74-337a00cfae13@ginzinger.com>
References: <FC629F1A536C6F42B960B5E32E20BD358C2466E3@exc2.buero.ginzinger.com>
 <20160714152703.GA12152@linutronix.de>
 <150d1d1f-b427-50be-524d-dbe80dd5523e@ginzinger.com>
 <20160729164658.GH21715@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:23355 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944274AbcJSPSB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Oct 2016 11:18:01 -0400
In-Reply-To: <20160729164658.GH21715@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/29/2016 06:46 PM, Sebastian Andrzej Siewior wrote:
> * Henri Roosen | 2016-07-15 12:54:25 [+0200]:
>
>> The problem is easily triggered, but only after starting a flood-ping to
>> the PREEMPT_RT-system under test. This also results in huge latency,
>> much bigger than on a 'normal' PREEMPT-system, which seems to be
>> resistant against the flood-ping.
>>
>> Any suggestions how to best trace this down?
>
> Hmm. 4.1.27-rt30 has
>  softirq: split timer softirqs out of ksoftirqd
>  net: provide a way to delegate processing a softirq to ksoftirqd
>
> I would suggest using those two but you should have them.

Yes, both commits are in.

> Your ksoftirqd runs as SCHED_OTHER, right? And you do have
> CONFIG_RCU_BOOST enabled? Your do_hell script which starts hackbench
> does not run with higher priority?

Yes, ksoftirqd is SCHED_OTHER and RCU_BOOST is enabled with prio 60.
Also do_hell, hackbench and all other "load-tools" run SCHED_OTHER
priority, but the kernel INFO can even be reproduced without the do_hell
and without cyclictest; a floodping to this target is enough.

> From the backtrace it is hackbench "doing things" and this one should be
> preempted by RCU and ethernet networking napi code should be preempted /
> moved to ksoftirqd during the flood-ping. Can you check this happens?

Ethernet networking napi code is never moved to ksoftirqd; during
floodping only the ethernet irq-thread is running. All the following
calls are in the context of the irq/223-ethernet thread:

fec_enet_interrupt() calls __napi_schedule() -> raises the NET_RX
softirq -> softirq runs (still on irq/223-ethernet thread) -> napi_poll
is called with budget 64 -> fec_enet_rx_napi calls fec_enet_rx() which
returns always < 64 pkts -> napi_complete() is called. During the
softirq there is a new interrupt from the ethernet, so the
irq/223-ethernet thread keeps running.

Seems the ethernet doesn't meet the budget to offload interrupts to the
ksoftirqd.. or is there something wrong with the usage of NAPI in the
FEC driver?

Anyway, this triggers a new problem: the "RT-throttling" to kicking-in,
which triggers a latency spike on the cyclictest (or any
rt-application). Actually I would like to switch off RT-throttling for
critical rt-application, preventing some other (lower priority) rt
workloads to trigger this "priority inversion" of the critical
rt-application. The only option I know is disabling RT-throttling
globally (echo -1 > /proc/sys/kernel/sched_rt_runtime_us), and as
CONFIG_RT_GROUP_SCHED is not available for PREEMPT_RT_FULL, I see no
option to throttle the lower priority FIFO tasks (like the ethernet
irq). How should that be done?

I've found out the "INFO: rcu_preempt detected stalls.." warning is
related to the priority of the "ktimersoftd" task. If it is lower or
equal to the priority of the (runaway) ethernet-irq-thread, the message
is triggered. I'd have to do some digging why that is the case, but
maybe you can shed a light on that?

Thanks!
Henri

>
>> Thanks,
>> Henri
>
> Sebastian
>

________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089


________________________________

Kommende Events:

08.-11. November 2016: Besuchen Sie uns auf der electronica in München -> Halle B1 Stand 538
16. November 2016: Nachmittagsseminar mit unserem Partner Irlbacher zum Thema „Glas als innovatives Material für moderne HMI’s“
17. November 2016: Juristisches Seminar in Linz: Einsatz von Open Source-Software in der Industrie
06. Dezember 2016: Nachmittagsseminar mit unserem Partner sequality software engineering zum Thema Usability

>> Weitere Informationen zu diesen Veranstaltungen und Neuigkeiten aus der Elektronikbranche finden Sie auf www.ginzinger.com/techtalk

