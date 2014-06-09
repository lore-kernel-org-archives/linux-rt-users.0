From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [RFC PATCH] rt/aio: fix rcu garbage collection might_sleep()
 splat
Date: Mon, 09 Jun 2014 05:17:02 +0200
Message-ID: <1402283822.5195.3.camel@marge.simpson.net>
References: <1402216538.31630.7.camel@marge.simpson.net>
	 <5395172E.4010007@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5395172E.4010007@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2014-06-09 at 10:08 +0800, Lai Jiangshan wrote: 
> Hi, rt-people
> 
> I don't think it is the correct direction.

Yup, it's a band-aid, ergo RFC.

-Mike
