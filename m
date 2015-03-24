From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.9-rt5
Date: Tue, 24 Mar 2015 09:42:05 +0100
Message-ID: <1427186525.3316.30.camel@gmail.com>
References: <20150316210146.GG28130@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150316210146.GG28130@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2015-03-16 at 22:01 +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!

> - lazy preempt on x86_64 is enabled again. It seems that it fixed
>   itself.

009f60e2 sched: stop the unbound recursion in preempt_schedule_context()
