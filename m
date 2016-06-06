From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] mm/memcontrol.c::mem_cgroup_migrate() - replace another
 local_irq_disable() w. local_lock_irq()
Date: Mon, 6 Jun 2016 10:52:07 +0200
Message-ID: <60e058cb-db66-3303-f5c3-d6e872ef3d30@linutronix.de>
References: <20160603104424.GA18975@linutronix.de>
 <1465107073.4263.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465107073.4263.3.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 06/05/2016 08:11 AM, Mike Galbraith wrote:
> v4.6 grew a local_irq_disable() in mm/memcontrol.c::mem_cgroup_migrate().
> Convert it to use the existing local lock (event_lock) like the others.
> 
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

Applied.

Sebastian
