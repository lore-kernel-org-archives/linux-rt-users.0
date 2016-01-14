From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Thu, 14 Jan 2016 15:59:29 +0100
Message-ID: <20160114145928.GD17776@linutronix.de>
References: <20151223225755.GA21121@linutronix.de>
 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
 <1451632781.9800.22.camel@gmail.com>
 <20160113175845.GK29964@linutronix.de>
 <56969948.2060009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	paulmck@linux.vnet.ibm.com, Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56969948.2060009@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Grygorii Strashko | 2016-01-13 20:36:56 [+0200]:

>I might be wrong completely, but could below two patches affect on
>CPU utilization of ksoftirqd?
>
>6047967 ksoftirqd: Use new cond_resched_rcu_qs() function
>28423ad ksoftirqd: Enable IRQs and call cond_resched() before poking RCU
>
>above two patches are not applied on -RT part of softirqs processing.

this has been overseen, thanks.

Sebastian
