From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH V4 3/4] block: queue work on unbound wq
Date: Tue, 9 Apr 2013 15:28:29 +0530
Message-ID: <CAP245DWzD7BqB6ZzQJp8iUTpucRUeFbq=xEh+5fr2TqXVuwgAw@mail.gmail.com>
References: <cover.1364740180.git.viresh.kumar@linaro.org>
	<91239cde99aaba2715f63db1f88241d9f4a36e13.1364740180.git.viresh.kumar@linaro.org>
	<20130331181931.GA7533@htj.dyndns.org>
	<CAKohpomGSkz6_YqDzaTYEsJfVmcg2=TvdgquWqTvd-nmtOmoaQ@mail.gmail.com>
	<CAP245DUWtryaxn=u=VWiSp7b9RZYjsEozX9WEHCvzMWJR6B7TQ@mail.gmail.com>
	<CAKohpomtRYfGcEq9b1NmZwha4XA2=HaKsOiyShWScJi0+szfiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Randhawa <robin.randhawa@arm.com>,
	linux-rt-users@vger.kernel.org,
	Patch Tracking <patches@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
	Steve Bannister <Steve.Bannister@arm.com>, airlied@redhat.com,
	Arvind Chauhan <arvind.chauhan@arm.com>, mingo@redhat.com,
	davem@davemloft.net,
	Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:58036 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935359Ab3DIJ6a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Apr 2013 05:58:30 -0400
Received: by mail-vc0-f172.google.com with SMTP id gd11so2601212vcb.3
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Apr 2013 02:58:29 -0700 (PDT)
In-Reply-To: <CAKohpomtRYfGcEq9b1NmZwha4XA2=HaKsOiyShWScJi0+szfiw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 9, 2013 at 3:25 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 9 April 2013 15:23, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> On Tue, Apr 9, 2013 at 1:00 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> Later one (Power oriented WQ) can be achieved if the workqueue is allocated with
>>
>> Rephrase as "Power-efficient workqueues can be achieved..."
>
> Ok.
>
>>> WQ_UNBOUND flag. To make this compile time configurable with boot time override
>>> this patch adds in another flag WQ_POWER_EFFICIENT. This will be converted to
>>> WQ_UNBOUND (on wq allocation) if CONFIG_WQ_POWER_EFFICIENT is enabled and
>>> bootargs contain workqueue.power_efficient=1. It is unused otherwise and normal
>>> behavior of WQ without this flag is expected.
>>
>> Addition of a new flag seems a bit excessive IMHO. Why can't we just
>> set the UNBOUND flag when the wq_power_efficient module param is set?
>>
>> It would make the patch a lot simpler too.
>
> But how will we know if the user of wq wants to save power or not? He must
> give some flag which is only used when power saving is enabled. We can't
> set WQ_UNBOUND for all wqs.

You have the Kconfig option + the module param for that. You don't need a flag.
