From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] cpu hotplug: Document why PREEMPT_RT uses a spinlock
Date: Fri, 24 Jan 2014 13:41:32 +0100
Message-ID: <20140124124132.GA10264@linutronix.de>
References: <20131205091652.0523f2c3@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131205091652.0523f2c3@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2013-12-05 09:16:52 [-0500]:

>Document the rational for using a spinlock on PREEMPT_RT in the hotplug
>lock code.
applied.

>Reported-by: Nicholas Mc Guire <der.herr@hofr.at>
>Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>

Sebastian
