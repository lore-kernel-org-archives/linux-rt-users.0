From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Null pointer 4.14.1-rt3
Date: Fri, 1 Dec 2017 17:38:34 +0100
Message-ID: <20171201163832.GO1612@linutronix.de>
References: <80ce7c3e-2d01-f082-9c21-fc1084a836c8@monom.org>
 <8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org>
 <20171130112232.4c0cb600@gandalf.local.home>
 <20171130162433.GG11362@linutronix.de>
 <20171130113533.4485d894@gandalf.local.home>
 <20171201122605.GD1612@linutronix.de>
 <20171201110315.48d5c984@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Daniel Wagner <wagi@monom.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201110315.48d5c984@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-12-01 11:03:15 [-0500], Steven Rostedt wrote:
> On Fri, 1 Dec 2017 13:26:05 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > - disable RT_PUSH_IPI if booted on UP. After all there is not much
> >   benefit here, is there?
> 
> This is what I would suggest. Maybe I'll look at adding a patch.

Please tag it stable because the patch made it into v4.14.3.

> -- Steve

Sebastian
