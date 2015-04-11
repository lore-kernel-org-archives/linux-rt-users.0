From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch v2] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Sat, 11 Apr 2015 16:22:30 +0200
Message-ID: <1428762150.3400.13.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>
	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>
	 <1426153093.4190.2.camel@gmail.com> <1426222405.17611.7.camel@gmail.com>
	 <20150410141552.GC3057@linutronix.de> <1428758159.10417.13.camel@gmail.com>
	 <1428759368.10417.25.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428759368.10417.25.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2015-04-11 at 15:36 +0200, Mike Galbraith wrote:
> 
> Well, not reverted, I actually queued and maybe poked softirq, but 
> didn't check whether anything was being queued or not

(the checking: !IRQ_WORK_HARD_IRQ happens, box remains alive)

           mount-827   [002] ....211     9.781994: irq_work_queue: queue work: ffff88041ec8d7d0
           mount-827   [002] .N..211     9.781997: irq_work_queue: poke ksoftirqd
    sirq-timer/2-49    [002] .....11     9.781999: irq_work_run_list: execute work: ffff88041ec8d7d0
          swapon-852   [003] ....211    10.224358: irq_work_queue: queue work: ffff88041eccd7d0
    sirq-timer/3-67    [003] .....11    10.224501: irq_work_run_list: execute work: ffff88041eccd7d0
       plymouthd-476   [000] ....2..    10.227930: irq_work_queue: queue work: ffff88041ec0d7d0
    sirq-timer/0-4     [000] .....11    10.228311: irq_work_run_list: execute work: ffff88041ec0d7d0
   systemd-udevd-694   [001] ....211    10.316067: irq_work_queue: queue work: ffff88041ec4d7d0
    sirq-timer/1-34    [001] .....11    10.316340: irq_work_run_list: execute work: ffff88041ec4d7d0
   systemd-udevd-694   [001] ....211    10.316871: irq_work_queue: queue work: ffff88041ec4d7d0
    sirq-timer/1-34    [001] .....11    10.317341: irq_work_run_list: execute work: ffff88041ec4d7d0
   systemd-udevd-741   [005] ....211    10.515752: irq_work_queue: queue work: ffff88041ed4d7d0
    sirq-timer/5-100   [005] .....11    10.516522: irq_work_run_list: execute work: ffff88041ed4d7d0
