From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Wed, 13 Jan 2016 20:36:56 +0200
Message-ID: <56969948.2060009@ti.com>
References: <20151223225755.GA21121@linutronix.de>
 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
 <1451632781.9800.22.camel@gmail.com> <20160113175845.GK29964@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	<paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160113175845.GK29964@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/13/2016 07:58 PM, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2016-01-01 08:19:41 [+0100]:
>
>>>    PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
>>>      3 root      -2   0       0      0      0 S  37.3  0.0 307:52.44 ksoftirqd/0
>>>     32 root      -2   0       0      0      0 S  37.3  0.0 308:08.72 ksoftirqd/2
>>>     42 root      -2   0       0      0      0 R  37.3  0.0 308:32.84 ksoftirqd/3
>>>     22 root      -2   0       0      0      0 S  26.9  0.0 222:29.82 ksoftirqd/1
>>>      1 root      20   0   46628   6980   4976 S   1.3  0.2   0:13.98 systemd
>>> 22358 williams  20   0  159980   4552   3780 R   1.0  0.1   0:00.39 top
>>
>> Heh, I didn't notice immediately because I throttle nohz, am seeing
>> only tiny utilization (but nohz idle isn't working).  With throttle
>> patch removed, box is screaming, expires=4294990471 pokes eyeball.
>
> This is due to NO_HZ as far as I can tell. My AMD A10 in idle mode has
> 0.7% utilisation of ksoftirqd/ with CONFIG_HZ_PERIODIC and with
> CONFIG_NO_HZ_FULL it shows about 25% on all CPU threads.
>

I might be wrong completely, but could below two patches affect on
CPU utilization of ksoftirqd?

6047967 ksoftirqd: Use new cond_resched_rcu_qs() function
28423ad ksoftirqd: Enable IRQs and call cond_resched() before poking RCU

above two patches are not applied on -RT part of softirqs processing.

static void run_ksoftirqd(unsigned int cpu)
{
	local_irq_disable();
	current->softirq_nestcnt++;

	do_current_softirqs();
	current->softirq_nestcnt--;
	rcu_note_context_switch();

^^^ IRQs disabled
	local_irq_enable();
}

-- 
regards,
-grygorii
