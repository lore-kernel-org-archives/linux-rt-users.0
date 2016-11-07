From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 15:16:17 -0500
Message-ID: <20161107151617.486b1b42@gandalf.local.home>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
        <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
        <20161107133207.4282de69@gandalf.local.home>
        <alpine.DEB.2.20.1611071328470.19249@east.gentwo.org>
        <20161107144738.4811a5dd@gandalf.local.home>
        <alpine.DEB.2.20.1611071353440.19543@east.gentwo.org>
        <20161107150003.66777b43@gandalf.local.home>
        <1e79f711-95f1-da2f-f572-1ac4329c8be7@bristot.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <daniel@bristot.me>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1e79f711-95f1-da2f-f572-1ac4329c8be7@bristot.me>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 7 Nov 2016 21:06:50 +0100
Daniel Bristot de Oliveira <daniel@bristot.me> wrote:

> The throttling allowed the kworker to run, but once the kworker went to
> sleep, the RT tasks started to work again. In the previous behavior,
> the system would either go idle, or the kworker would starve because 
> the runtime become infinity for RR tasks.

I'm confused? Are you saying that RR tasks don't get throttled in the
current code? That sounds like a bug to me.

-- Steve
