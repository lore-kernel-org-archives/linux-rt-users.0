From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFD 5/5] tracing: Add trace_irqsoff tracepoints
Date: Fri, 01 May 2015 09:23:48 +0000
Message-ID: <55434624.6060109@monom.org>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>	<1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>	<1430446492.17922.32.camel@picadillo> <20150430225411.37cbb7cc@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Ingo Molnar <mingo@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35998 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbbEAJXy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 May 2015 05:23:54 -0400
Received: by wgen6 with SMTP id n6so86283480wge.3
        for <linux-rt-users@vger.kernel.org>; Fri, 01 May 2015 02:23:53 -0700 (PDT)
In-Reply-To: <20150430225411.37cbb7cc@grimm.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/01/2015 02:54 AM, Steven Rostedt wrote:
> On Thu, 30 Apr 2015 21:14:52 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
>
>
>>> 'hist:key=latency.bucket:val=hitcount:sort=latency if cpu==0'
>>>
>>> but I haven't got this working. I didn't spend much time figuring out
>>> why this doesn't work. Even if the above is working you still
>>
>> I think it doesn't work because the tracepoint doesn't actually have a
>> 'cpu' field to use in the filter...
>
> Perhaps we should add special fields that don't use the tracepoint
> field, but can use generically know fields that are always known when
> the tracepoint is triggered. COMM could be one, as well as CPU.

I'll give it a try if no one objects next week (public holiday today :))

cheers,
daniel

