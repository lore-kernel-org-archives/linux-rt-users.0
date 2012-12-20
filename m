From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [PATCH] sched/rt: Move cpu rq properties from "struct rt_rq" to "struct rq"
Date: Fri, 21 Dec 2012 02:16:58 +0400
Message-ID: <401821356041818@web4f.yandex.ru>
References: <4807701355857948@web19f.yandex.ru> <alpine.LFD.2.02.1212201852060.3148@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward15.mail.yandex.net ([95.108.130.119]:46699 "EHLO
	forward15.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2LTWRE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 17:17:04 -0500
In-Reply-To: <alpine.LFD.2.02.1212201852060.3148@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

20.12.2012, 21:53, "Thomas Gleixner" <tglx@linutronix.de>:
> On Tue, 18 Dec 2012, Kirill Tkhai wrote:
>
>> =9AThe members rt_nr_total, rt_nr_migratory, overloaded and pushable=
_tasks are
>> =9Aproperties of cpu runqueue, not group rt_rq.
>
> Why?

Because, they depend on number and properties of all processes of rq, n=
ot of nested rt_rq.

>
> Thanks,
>
> =9A=9A=9A=9A=9A=9A=9A=9Atglx
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
