From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] sched: fix ->nr_cpus_allowed = 1 transcription error
 during migrate_disable() cleanup
Date: Mon, 1 Feb 2016 13:45:54 +0100
Message-ID: <56AF5382.5070707@linutronix.de>
References: <20160122230859.GC3883@linutronix.de>
 <1453533113.3798.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453533113.3798.3.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/23/2016 08:11 AM, Mike Galbraith wrote:
> 
> Setting p->nr_cpus_allowed accidentally wandered into migrate_disable()
> during the cleanup - kill it. 

Thanks, applied.

Sebastian
