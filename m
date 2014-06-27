From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Fri, 27 Jun 2014 05:22:49 +0200
Message-ID: <1403839369.20458.12.camel@marge.simpson.net>
References: <CANGgnMbHckBQdKGN_N5Q6qEKc9n1CenxvMpeXog1NbSdL8UrTw@mail.gmail.com>
	 <CANGgnMYDXerOUDOO9-RHMJKadKACA2KBGskZwoP-1ZwAhDEfVA@mail.gmail.com>
	 <CAFLxGvxfBt7OvW=a2Kz08GLHSEiiOZsN-vB19CXnQiwqFxqMsA@mail.gmail.com>
	 <CANGgnMYVoP-Z0Bv-VDEkJnvfa7Fi4-zY2F4A0PhMewGvwo3VVw@mail.gmail.com>
	 <alpine.DEB.2.10.1406270027300.5170@nanos>
	 <CANGgnMa+qtgJ3wwg_h5Rynw5vEvZpQZ6PvaUfXNQ8+Y3Yu5U0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Austin Schuh <austin@peloton-tech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANGgnMa+qtgJ3wwg_h5Rynw5vEvZpQZ6PvaUfXNQ8+Y3Yu5U0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2014-06-26 at 17:07 -0700, Austin Schuh wrote:

> If I'm reading the rt patch correctly, wq_worker_sleeping was moved
> out of __schedule to sched_submit_work.  It looks like that changes
> the conditions under which wq_worker_sleeping is called.  It used to
> be called whenever a task was going to sleep (I think).  It looks like
> it is called now if the task is going to sleep, and if the task isn't
> blocked on a PI mutex (I think).

Re-entanglement does turn your killer into a happy camper, but that
patch is too lovely to just surrender without a squabble.

-Mike
