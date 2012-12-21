From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Move cpu rq properties from "struct rt_rq" to
 "struct rq"
Date: Fri, 21 Dec 2012 09:43:19 -0500
Message-ID: <1356100999.5896.98.camel@gandalf.local.home>
References: <4807701355857948@web19f.yandex.ru>
	 <alpine.LFD.2.02.1212201852060.3148@ionos>
	 <401821356041818@web4f.yandex.ru>
	 <1356044865.5896.78.camel@gandalf.local.home>
	 <545781356071709@web16g.yandex.ru>
	 <1356094312.5896.97.camel@gandalf.local.home>
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
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:23803 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab2LUOnV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2012 09:43:21 -0500
In-Reply-To: <1356094312.5896.97.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-12-21 at 07:51 -0500, Steven Rostedt wrote:

> Now if you want to encapsulate the rt sched group, then you could add a
> new struct and put that into the rt_rq struct and use that for all the
> group functions. But please don't just cludder the rq struct with rt

cludder? I must have a studder, as it is suppose to be clutter and
stutter!

;-)

-- Steve

> specific data. The rt_rq was created as a container for the rt class.
> 
> -- Steve
> 


