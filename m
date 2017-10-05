From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt13
Date: Thu, 5 Oct 2017 17:54:41 +0200
Message-ID: <20171005155441.72mjaac5c42rjilf@linutronix.de>
References: <20170905145244.jro4jywfxugmn7eh@linutronix.de>
 <1507133279.6934.66.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507133279.6934.66.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-10-04 18:07:59 [+0200], Mike Galbraith wrote:
> Seems combo-patch induced some ltp posix conformance test grumbling.
> 
> +clock_settime_8_1 ... ... FAILED 
> +clock_settime_4_2 ... ... FAILED 
> +clock_settime_speculative_4_3 ... ... FAILED 
> +timer_settime_5_2 ... ... FAILED 
> +timer_settime_5_1 ... ... FAILED 
> +timer_settime_5_3 ... ... FAILED 
> 
> rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_8-1.run-test
> Ended too late.  1507131910 >> 1507131908
> Test FAILED
> rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_4-2.run-test
> timer should have expired _immediately_
> rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/speculative/clock_settime_speculative_4-3.run-test
> Overrun count =0, not # of repeating timer expirys
> FAIL:  Caught 0 signals, not 1
> Test FAILED
> rtbox:/root # /opt/ltp/conformance/interfaces/timer_settime/timer_settime_5-2.run-test
> signal was not sent

So the last triggers here, too and I have an idea.

Sebastian
