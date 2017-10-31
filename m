From: "Jingar, Rajvi" <rajvi.jingar@intel.com>
Subject: RE: [PATCH v4 37/37] selftests: ftrace: Add inter-event hist
 triggers testcases
Date: Tue, 31 Oct 2017 20:40:43 +0000
Message-ID: <73C85D50C97D6C48A6E9F3EFFE85B49B2C6FF7FE@ORSMSX108.amr.corp.intel.com>
References: <cover.1509395595.git.tom.zanussi@linux.intel.com>
        <25a4c52df50f4af199d1c63acc5fe3675715148f.1509395596.git.tom.zanussi@linux.intel.com>
 <20171031232904.0e1bfede7c685d40fd83c36f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "Patel, Vedang" <vedang.patel@intel.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "joel.opensrc@gmail.com" <joel.opensrc@gmail.com>,
        "joelaf@google.com" <joelaf@google.com>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "Liu, Baohong" <baohong.liu@intel.com>,
        "julia@ni.com" <julia@ni.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57739 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932570AbdJaUkp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Oct 2017 16:40:45 -0400
In-Reply-To: <20171031232904.0e1bfede7c685d40fd83c36f@kernel.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Masami,

> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] On Behalf Of Masami Hiramatsu
> Sent: Tuesday, October 31, 2017 7:29 AM
> To: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: rostedt@goodmis.org; tglx@linutronix.de; mhiramat@kernel.org;
> namhyung@kernel.org; Patel, Vedang <vedang.patel@intel.com>;
> bigeasy@linutronix.de; joel.opensrc@gmail.com; joelaf@google.com;
> mathieu.desnoyers@efficios.com; Liu, Baohong <baohong.liu@intel.com>;
> Jingar, Rajvi <rajvi.jingar@intel.com>; julia@ni.com; linux-
> kernel@vger.kernel.org; linux-rt-users@vger.kernel.org
> Subject: Re: [PATCH v4 37/37] selftests: ftrace: Add inter-event hist triggers
> testcases
> 
> On Mon, 30 Oct 2017 15:52:19 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > From: Rajvi Jingar <rajvi.jingar@intel.com>
> >
> > This adds inter-event hist triggers testcases which covers following:
> >  - create/remove synthetic event
> >  - disable histogram for synthetic event
> >  - extended error support
> >  - field variable support
> >  - histogram variables
> >  - histogram trigger onmatch action
> >  - histogram trigger onmax action
> >  - histogram trigger onmatch-onmax action
> >  - simple expression support
> >  - combined histogram
> 
> Thank you for adding testcases :)
> That helps me to understand how to use it.
> I have some comments, see below;
> 
> 
> [..]
> > diff --git
> > a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-ex
> > tended-error-support.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-ex
> > tended-error-support.tc
> > new file mode 100644
> > index 0000000..41dbf4c
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigge
> > +++ r-extended-error-support.tc
> > @@ -0,0 +1,39 @@
> > +#!/bin/sh
> > +# description: event trigger - test extended error support
> > +
> > +
> > +do_reset() {
> > +    reset_trigger
> > +    echo > set_event
> > +    clear_trace
> > +}
> > +
> > +fail() { #msg
> > +    do_reset
> > +    echo $1
> > +    exit $FAIL
> > +}
> > +
> > +if [ ! -f set_event ]; then
> > +    echo "event tracing is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +if [ ! -f synthetic_events ]; then
> > +    echo "synthetic event is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +reset_tracer
> > +do_reset
> > +
> > +echo "Test extended error support"
> > +echo 'hist:keys=pid:ts0=$common_timestamp.usecs if comm=="ping"' >>
> > +events/sched/sched_wakeup/trigger echo
> > +'hist:keys=pid:ts0=$common_timestamp.usecs if comm=="ping"' >>
> > +events/sched/sched_wakeup/trigger &&
> 
> What is the last "&&"? Would you expect that the second echo is fail?
> 

Yes, The the second echo is expected to fail on trying to add same trigger(mainly same variable name). 
I'll change last "&&" to redirect error/output to /dev/null instead.

> > +if ! grep "ERROR:" events/sched/sched_wakeup/hist; then
> 
> Would you like to show the grep result? or you can use -q option for grep
> command.
> 

No, I don't need to show grep results. Will add -q option and will do so for all the places with similar case.

> [...]
> > diff --git
> > a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-sy
> > nthetic-event-createremove.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-sy
> > nthetic-event-createremove.tc
> > new file mode 100644
> > index 0000000..c73e491
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigge
> > +++ r-synthetic-event-createremove.tc
> > @@ -0,0 +1,46 @@
> > +#!/bin/sh
> > +# description: event trigger - test synthetic event create remove
> > +do_reset() {
> > +    reset_trigger
> > +    echo > set_event
> > +    clear_trace
> > +}
> > +
> > +fail() { #msg
> > +    do_reset
> > +    echo $1
> > +    exit $FAIL
> > +}
> > +
> > +if [ ! -f set_event ]; then
> > +    echo "event tracing is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +if [ ! -f synthetic_events ]; then
> > +    echo "synthetic event is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +clear_synthetic_events
> > +reset_tracer
> > +do_reset
> > +
> > +echo "Test create synthetic event"
> > +
> > +echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' >
> > +synthetic_events if [ ! -d events/synthetic/wakeup_latency ]; then
> > +    fail "Failed to create wakeup_latency synthetic event"
> > +fi
> > +
> > +reset_trigger
> > +
> > +echo "Test remove synthetic event"
> > +echo '!wakeup_latency  u64 lat; pid_t pid; char[16] comm' >
> > +synthetic_events
> 
> both char[16] and char comm[16] are acceptable?
> But I would like to see same style in creating and removing.
> 

Will change to same style in creating and removing.

> > +if [ -d events/synthetic/wakeup_latency ]; then
> > +    fail "Failed to delete wakeup_latency synthetic event"
> > +fi
> 
> There seems no expected failure test cases. Could you add such test?
> like as echoing events with invalid format etc.
>

Sure, will add a case trying to add an event with wrong format.
 
> 
> <off topic>
> BTW, $FAIL is not for expressing failure, it is a value for $SIG_RESULT. But it
> seems many test cases use it for return code.
> 
> Note that any failure in this script treated as error and exit soon.
> Which means caller can get any return code from this script, because the return
> code depends on executed command. So, any NON-ZERO code can be treated as
> FAILURE code.
> 
> "exit $FAIL" is OK, but just making myself review easier, I'll introduce
> exit_pass()/exit_fail().
> <off topic>
> 
> Thank you,
> 
> --
> Masami Hiramatsu <mhiramat@kernel.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
