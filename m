From: Andy Ng <andreas2025@gmail.com>
Subject: Re: Tracing within functions.
Date: Thu, 2 Apr 2015 18:52:57 +0100
Message-ID: <CAAVaN8zXt86tnW6rkFb9Eo7MPROBPbD8QDGKtvdKcAre7rNj5w@mail.gmail.com>
References: <CAAVaN8yOYUf_+5Pxh4qOWxb5rqMu__LcqSxr0YMVA114A41YWA@mail.gmail.com>
	<CAA8Xd+-oD2woif3+s9PSR1yyJE6fJzuf02RYnBpoRbO8agMxWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34452 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbDBRw6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Apr 2015 13:52:58 -0400
Received: by iedfl3 with SMTP id fl3so84037961ied.1
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Apr 2015 10:52:57 -0700 (PDT)
In-Reply-To: <CAA8Xd+-oD2woif3+s9PSR1yyJE6fJzuf02RYnBpoRbO8agMxWw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you very much for your reply. You pointed to me to  the right direction.

Andy

On Mon, Mar 30, 2015 at 2:49 PM, Gustavo Bittencourt <gbitten@gmail.com> wrote:
> I think you can use FTRACE (http://lwn.net/Articles/365835/) and set
> function_graph as the tracer. To filter the output, you must enable
> CONFIG_DYNAMIC_FTRACE and set which function should be traced.
>
> On Sun, Mar 29, 2015 at 5:16 PM, Andy Ng <andreas2025@gmail.com> wrote:
>> Hello,
>>
>> I am using an RT kernel and in my  driver there is  an atomic code
>> path that just makes some critical I/O operations. I would like to
>> trigger a system function trace when kernel enters into a specific
>> function in my driver and stop the system trace at the end of the
>> function. I would like to identify time execution latencies for a
>> specific code path. I am using Cortex A9 and I have perf and PMU up
>> and running, but still it is not clear to me how to retrieve the
>> traces with those latencies in my code path.
>>
>> Any ideas how to trace/measure that  will be very much appreciated.
>>
>> Best regards,
>> Andy
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
