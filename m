From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 3/5] allow preemption in check_task_state
Date: Fri, 14 Feb 2014 14:22:40 +0100
Message-ID: <20140214132240.GH28438@linutronix.de>
References: <20140210162816.GA24267@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140210162816.GA24267@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Nicholas Mc Guire | 2014-02-10 17:28:16 [+0100]:

>A lockfree approach to check_task_state

I ignore this due to was has been written in the thread "allow
preemption in check_task_state" for now.

Also I just want to state that this function is hardly used on regular
basis except for ptrace attach case which ends up beeing a power user in
the test case mentioned.

Sebastian
