From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Date: Mon, 26 Mar 2018 11:59:04 -0400
Message-ID: <20180326115904.492a3bad@gandalf.local.home>
References: <20180323150959.GA16131@zipoli.concurrent-rt.com>
        <20180323165921.GG10942@jcartwri.amer.corp.natinst.com>
        <20180323172131.GA2670@zipoli.concurrent-rt.com>
        <20180326113515.720e7fb3@gandalf.local.home>
        <20180326155451.GA16545@zipoli.concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Julia Cartwright <julia@ni.com>, <bigeasy@linutronix.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: joe.korty@concurrent-rt.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180326155451.GA16545@zipoli.concurrent-rt.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 26 Mar 2018 11:54:51 -0400
joe.korty@concurrent-rt.com wrote:

> Oh well.  Makes me wonder why might_sleep is testing for
> !TASK_RUNNABLE though.

Because might_sleep() is used when the function might call schedule()
directly. And schedule() *will* change the task state to TASK_RUNNING.
might_sleep() has nothing to do with preemption.

-- Steve
