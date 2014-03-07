From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] cpu_chill: Add a UNINTERRUPTIBLE hrtimer_nanosleep
Date: Fri, 07 Mar 2014 10:49:42 +0100
Message-ID: <53199636.7010806@linutronix.de>
References: <20140304122832.0979c5dc@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, uobergfe@redhat.com
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140304122832.0979c5dc@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/04/2014 06:28 PM, Steven Rostedt wrote:
> We hit another bug that was caused by switching cpu_chill() from
> msleep() to hrtimer_nanosleep().

Applied with a stable tag.

Sebastian
