From: Steven Rostedt <rostedt@goodmis.org>
Subject: Why the mce reverts in 4.16-rt?
Date: Tue, 10 Jul 2018 20:56:24 -0400
Message-ID: <20180710205624.19ff9ef0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,

I'm looking at backporting patches from 4.16-rt and noticed that you
have:

Revert "x86: Convert mce timer to hrtimer"
Revert "x86/mce: use swait queue for mce wakeups"

With no explanation to why they were reverted. When did things change?
Should this be 4.14-rt material?

Thanks,

-- Steve
