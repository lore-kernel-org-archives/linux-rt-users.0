From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT] acpi/rt: Convert acpi lock back to a
 raw_spinlock_t
Date: Wed, 13 Feb 2013 17:42:34 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302131741220.11905@ionos>
References: <1360765565.23152.5.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@gmail.com>,
	Clark Williams <clark@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360765565.23152.5.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 13 Feb 2013, Steven Rostedt wrote:
> The lock was converted from a raw to a sleeping lock due to some
> previous issues, and tests that showed it didn't seem to matter.
> Unfortunately, it did matter for one of our boxes.

Yep. The other issues are functions like kfree() called under that
lock. I'm auditing all callsites to see what needs to be done.

Thanks,

	tglx
