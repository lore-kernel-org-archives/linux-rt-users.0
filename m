From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: Tracing within functions.
Date: Mon, 30 Mar 2015 10:49:22 -0300
Message-ID: <CAA8Xd+-oD2woif3+s9PSR1yyJE6fJzuf02RYnBpoRbO8agMxWw@mail.gmail.com>
References: <CAAVaN8yOYUf_+5Pxh4qOWxb5rqMu__LcqSxr0YMVA114A41YWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Andy Ng <andreas2025@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34186 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbbC3NtX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Mar 2015 09:49:23 -0400
Received: by oigz129 with SMTP id z129so84188911oig.1
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2015 06:49:22 -0700 (PDT)
In-Reply-To: <CAAVaN8yOYUf_+5Pxh4qOWxb5rqMu__LcqSxr0YMVA114A41YWA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I think you can use FTRACE (http://lwn.net/Articles/365835/) and set
function_graph as the tracer. To filter the output, you must enable
CONFIG_DYNAMIC_FTRACE and set which function should be traced.

On Sun, Mar 29, 2015 at 5:16 PM, Andy Ng <andreas2025@gmail.com> wrote:
> Hello,
>
> I am using an RT kernel and in my  driver there is  an atomic code
> path that just makes some critical I/O operations. I would like to
> trigger a system function trace when kernel enters into a specific
> function in my driver and stop the system trace at the end of the
> function. I would like to identify time execution latencies for a
> specific code path. I am using Cortex A9 and I have perf and PMU up
> and running, but still it is not clear to me how to retrieve the
> traces with those latencies in my code path.
>
> Any ideas how to trace/measure that  will be very much appreciated.
>
> Best regards,
> Andy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
