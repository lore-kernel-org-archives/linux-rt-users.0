From: Jonah Petri <jpetri@izotope.com>
Subject: Re: diagnosing unexpected sched_stat_wait
Date: Wed, 9 Mar 2016 13:30:24 -0500
Message-ID: <CAJOrw7zv-2TfkOAHX+NfXDZ71898zSDKsN4As1dkq5F7+3yYDQ@mail.gmail.com>
References: <CAJOrw7was05Absp0UiCVO5mZEoZqXHD-ZNOoDwoG7t1S1DED_A@mail.gmail.com>
	<20160304220531.GB3604@kernel.org>
	<CAJOrw7wUwZmdkMNjB3gHptUR1AFDLXMqt9dAEOFsRcofrbtx6A@mail.gmail.com>
	<20160307142829.GC3604@kernel.org>
	<CAJOrw7waTrhPBAyfxL-8NiV4cBCr=9eqoLZnfYsjKyBeAqCDPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36794 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932950AbcCISaZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2016 13:30:25 -0500
Received: by mail-ob0-f179.google.com with SMTP id m7so55692749obh.3
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2016 10:30:25 -0800 (PST)
In-Reply-To: <CAJOrw7waTrhPBAyfxL-8NiV4cBCr=9eqoLZnfYsjKyBeAqCDPA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To close the loop on this, the support in the kernel for this is
missing for ARM in 3.14.52.  I backported the following into
arch/arm/include/asm/perf_event.h:

#define perf_arch_fetch_caller_regs(regs, __ip) { \
        register unsigned long sp asm ("sp"); \
        (regs)->ARM_pc = (__ip); \
        (regs)->ARM_fp = (unsigned long) __builtin_frame_address(0); \
        (regs)->ARM_sp = sp; \
        (regs)->ARM_cpsr = SVC_MODE; \
}

And now, I get stacks as expected!

Jonah

On Mon, Mar 7, 2016 at 9:53 AM, Jonah Petri <jpetri@izotope.com> wrote:
> On Mon, Mar 7, 2016 at 9:28 AM, Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>> I have gone down that route, but I don't get user stack traces at all.
>>>   I suspect this is because I'm on ARM 3.14.52, which does not support
>>> CONFIG_USER_STACKTRACE_SUPPORT.  Nor does it support
>>> CONFIG_ARCH_SUPPORTS_UPROBES.
>>> All that said, I DO get stack traces when using straight perf record
>>> with "--call-graph dwarf".  (Does that imply "-e cpu-clock"?).  So, I
>>
>> Ok, good data point, as what 'perf record --callgraph dwarf' does is to
>> take register and userland stack samples so that later it can use it
>> together with CFI information from the binaries involved to do the stack
>> unwinding.
>>
>
> Right, that's my understanding as well.  Given that I do get stack
> traces in some cases, this makes me wonder what the difference between
> the events which yield user stack traces (seemingly "Software event"
> in perf list) and events which do not yield user stack traces
> (seemingly "Tracepoint" in perf list).  My next steps are to work
> through these mechanisms and try to understand the difference.
>
>>> was hoping that whatever is enabling that event to get stack traces
>>> might be available to me.
>>
>> So what you are not managing to do is to collect userland stacktraces
>> from tracepoints, right?
>
> Correct.
>
>>
>> Any ARM person here to try to help diagnose why this does work on x86_64
>> but not on ARM?
>>
>
> Any pointers appreciated!  Thanks!
>
> Jonah
