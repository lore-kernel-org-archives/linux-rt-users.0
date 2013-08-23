From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.9-rt5
Date: Fri, 23 Aug 2013 09:06:08 +0200
Message-ID: <521709E0.3060505@linutronix.de>
References: <20130822182127.GA7606@linutronix.de> <20130822145314.32bdb0f9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130822145314.32bdb0f9@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/22/2013 08:53 PM, Steven Rostedt wrote:
>>       - bcache does not compile.
> 
> For now, it may be prudent to just make bcache depend on !PREEMPT_RT.
> 
> I can send a patch if you want.

I was tempted to take one of your two patches. Haven't deiced yet.

> -- Steve

Sebastian
