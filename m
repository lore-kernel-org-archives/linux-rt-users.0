From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Move cpu rq properties from "struct rt_rq" to
 "struct rq"
Date: Fri, 21 Dec 2012 07:51:52 -0500
Message-ID: <1356094312.5896.97.camel@gandalf.local.home>
References: <4807701355857948@web19f.yandex.ru>
	 <alpine.LFD.2.02.1212201852060.3148@ionos>
	 <401821356041818@web4f.yandex.ru>
	 <1356044865.5896.78.camel@gandalf.local.home>
	 <545781356071709@web16g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9210 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab2LUMvy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2012 07:51:54 -0500
In-Reply-To: <545781356071709@web16g.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-12-21 at 10:35 +0400, Kirill Tkhai wrote:
> 
>                                    
>            entity_1->my_q_1
>            /                        
>           /                         
> rq->rt  -entity_2->my_q_2
>           \                          
>            \                           
>              entity_n->my_q_n
>                                         
> 
> I say about child rt_rqs (my_q_1....my_q_n). They don't have rt_nr_total, rt_nr_migratory, overloaded and pushable_tasks.
> The only use of overloaded, for example, is "rq->rt.overloaded". The same with other variables.

You're missing the point. rt_rq is not just for entities, it's the
encapsulation of the rt class.

Now if you want to encapsulate the rt sched group, then you could add a
new struct and put that into the rt_rq struct and use that for all the
group functions. But please don't just cludder the rq struct with rt
specific data. The rt_rq was created as a container for the rt class.

-- Steve


