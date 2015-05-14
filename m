From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 RT 3.18] irq_work: Provide a soft-irq based queue
Date: Thu, 14 May 2015 21:58:11 +0200
Message-ID: <20150514195811.GJ13442@linutronix.de>
References: <5538A0DF.50401@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5538A0DF.50401@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Jan Kiszka | 2015-04-23 09:35:59 [+0200]:

>Instead of turning all irq_work requests into lazy ones on -rt, just
>move their execution from hard into soft-irq context.
>
>This resolves deadlocks of ftrace which will queue work from arbitrary
>contexts, including those that have locks held that are needed for
>raising a soft-irq.
>
>Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Applied

Sebastian
