From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat1
Date: Thu, 25 Apr 2013 14:32:55 +0200
Message-ID: <51792277.8000205@linutronix.de>
References: <1366760662.9609.176.camel@gandalf.local.home> <2156546.QlsX0XyPQz@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2156546.QlsX0XyPQz@dabox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/25/2013 01:14 PM, Tim Sander wrote:
> Hi 
> 
> I just wanted to test this release but it fails to compile with the the 
> following error:
> 
> kernel/hrtimer.c: In function '__hrtimer_start_range_ns':
> kernel/hrtimer.c:1045:7: error: implicit declaration of function 
> 'hrtimer_rt_defer'
> kernel/hrtimer.c: At top level:
> kernel/hrtimer.c:1416:12: error: static declaration of 'hrtimer_rt_defer' 
> follows non-static declaration
> kernel/hrtimer.c:1045:10: note: previous implicit declaration of 
> 'hrtimer_rt_defer' was here
> 
> The kernelconfig is attached.

You do not have CONFIG_HIGH_RES_TIMERS defined. Is this on purpose?

> Best regards
> Tim

Sebastian
