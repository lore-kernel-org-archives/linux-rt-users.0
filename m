From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.14.34-rt27
Date: Fri, 20 Apr 2018 19:38:48 +0200
Message-ID: <20180420173848.k75egzzljy3znocs@linutronix.de>
References: <20180413215240.scbnvz7egaauawyz@linutronix.de>
 <1523863560.8337.5.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523863560.8337.5.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-04-16 09:26:00 [+0200], Mike Galbraith wrote:
> On Fri, 2018-04-13 at 23:52 +0200, Sebastian Andrzej Siewior wrote:
> > 
> >   - Inter-event (latency) fixes by Tom Zanussi.
> 
>   CC      kernel/trace/trace_events_hist.o
> kernel/trace/trace_events_hist.c: In function ‘__update_field_vars’:
> kernel/trace/trace_events_hist.c:3093:11: warning: ignoring return value of ‘strscpy’, declared with attribute warn_unused_result [-Wunused-result]
>     strscpy(str, val_str, STR_VAR_LEN_MAX);
>            ^
> kernel/trace/trace_events_hist.c: In function ‘trace_event_raw_event_synth’:
> kernel/trace/trace_events_hist.c:672:11: warning: ignoring return value of ‘strscpy’, declared with attribute warn_unused_result [-Wunused-result]
>     strscpy(str_field, str_val, STR_VAR_LEN_MAX);
> 
> Maybe add include/linux/string.h __must_check removal?
> 
> (whacked upstream by 08a77676f9c5)

okay, let me cherry-pick that commit.

> 	-Mike

Sebastian
