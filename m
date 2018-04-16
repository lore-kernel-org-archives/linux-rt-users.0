From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.14.34-rt27
Date: Mon, 16 Apr 2018 09:26:00 +0200
Message-ID: <1523863560.8337.5.camel@gmx.de>
References: <20180413215240.scbnvz7egaauawyz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413215240.scbnvz7egaauawyz@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2018-04-13 at 23:52 +0200, Sebastian Andrzej Siewior wrote:
> 
>   - Inter-event (latency) fixes by Tom Zanussi.

  CC      kernel/trace/trace_events_hist.o
kernel/trace/trace_events_hist.c: In function ‘__update_field_vars’:
kernel/trace/trace_events_hist.c:3093:11: warning: ignoring return value of ‘strscpy’, declared with attribute warn_unused_result [-Wunused-result]
    strscpy(str, val_str, STR_VAR_LEN_MAX);
           ^
kernel/trace/trace_events_hist.c: In function ‘trace_event_raw_event_synth’:
kernel/trace/trace_events_hist.c:672:11: warning: ignoring return value of ‘strscpy’, declared with attribute warn_unused_result [-Wunused-result]
    strscpy(str_field, str_val, STR_VAR_LEN_MAX);

Maybe add include/linux/string.h __must_check removal?

(whacked upstream by 08a77676f9c5)

	-Mike
