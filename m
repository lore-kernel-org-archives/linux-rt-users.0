From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: -rt kernel just can show 8 perf events?
Date: Fri, 11 Dec 2015 09:57:06 -0800
Message-ID: <566B0E72.50608@linaro.org>
References: <565E04D5.4000202@linaro.org>
 <20151211173616.GL6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35808 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbLKR5J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 12:57:09 -0500
Received: by padhk6 with SMTP id hk6so28659303pad.2
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Dec 2015 09:57:08 -0800 (PST)
In-Reply-To: <20151211173616.GL6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/11/2015 9:36 AM, Sebastian Andrzej Siewior wrote:
> * Shi, Yang | 2015-12-01 12:36:37 [-0800]:
>
>> Hi folks,
>>
>> I'm running some perf program on my x86-64 machine with 4.1.12-rt13
>> kernel, but I found just 8 perf events can be showed up with "perf
>> stat -e" on -rt kernel, but mainline kernel is fine.
>
> And 4.1.12 (without -rt13) is not having this kind of problem?

No. mainline 4.1.12 works well.

Yang

>
>> Regards,
>> Yang
>
> Sebastian
>

