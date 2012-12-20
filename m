From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/rt: Move cpu rq properties from "struct rt_rq" to
 "struct rq"
Date: Thu, 20 Dec 2012 18:53:43 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212201852060.3148@ionos>
References: <4807701355857948@web19f.yandex.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50069 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab2LTRxt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 12:53:49 -0500
In-Reply-To: <4807701355857948@web19f.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 18 Dec 2012, Kirill Tkhai wrote:

> The members rt_nr_total, rt_nr_migratory, overloaded and pushable_tasks are
> properties of cpu runqueue, not group rt_rq.

Why?

Thanks,

	tglx

