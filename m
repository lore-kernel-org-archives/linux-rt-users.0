From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT PATCH] sched: rt: fix two possible deadlocks in
 push_irq_work_func
Date: Wed, 18 Nov 2015 16:56:41 +0100
Message-ID: <20151118155641.GB3652@linutronix.de>
References: <1447469598-31876-1-git-send-email-yanjiang.jin@windriver.com>
 <20151113232512.53df431f@gandalf.local.home>
 <5646BB4A.50307@windriver.com>
 <alpine.DEB.2.11.1511150914240.3761@nanos>
 <alpine.DEB.2.11.1511150925040.3761@nanos>
 <alpine.DEB.2.11.1511151204050.3761@nanos>
 <56496912.4090001@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	jinyanjiang@gmail.com, stable-rt@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Yang Shi <yang.shi@windriver.com>
To: yjin <yanjiang.jin@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56496912.4090001@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* yjin | 2015-11-16 13:26:42 [+0800]:

>Could you tell me when will you send your formal patch? And please CC
>me when you send your patch.
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git/plain/patches/irqwork-Move-irq-safe-work-to-irq-context.patch?h=linux-4.1.y-rt-patches

Sebastian
