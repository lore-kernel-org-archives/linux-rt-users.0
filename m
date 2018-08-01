From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] sched: drop is_special_task_state() check from
 __set_current_state_no_track()
Date: Wed, 1 Aug 2018 17:53:08 +0200
Message-ID: <20180801155308.wcw6mo6mrhlsgpg3@linutronix.de>
References: <20180801090524.7hmzfdx7r4bivekq@linutronix.de>
 <20180801091942.46292953@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180801091942.46292953@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-08-01 09:19:42 [-0400], Steven Rostedt wrote:
> I don't think we need to keep the do { } while with a single line. It
> is now equivalent to the non-debug version of __set_current_state()
> which is defined as:
> 
> #define __set_current_state(state_value)				\
> 	current->state = (state_value)

okay.

> -- Steve

Sebastian
