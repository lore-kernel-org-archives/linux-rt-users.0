From: Honghui Zhang <zhanghonghui@huawei.com>
Subject: Re: [PATCH] sched/rt: Decrease number of calls of push_rt_task()
 in push_rt_tasks()
Date: Tue, 5 Feb 2013 11:37:14 +0800
Message-ID: <51107E6A.3040006@huawei.com>
References: <2016751359330408@web20f.yandex.ru> <1359648490.17639.107.camel@gandalf.local.home> <313901359669474@web15h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="KOI8-R"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:52841 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab3BEDhg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 22:37:36 -0500
In-Reply-To: <313901359669474@web15h.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2013/2/1 5:57, Kirill Tkhai wrote:
> 
> 
> 31.01.2013, 20:08, "Steven Rostedt" <rostedt@goodmis.org>:
>> On Mon, 2013-01-28 at 03:46 +0400, Kirill Tkhai wrote:
>>
>>>  The patch aims to decrease the number of calls of push_rt_task()
>>>  in push_rt_tasks().
>>>
>>>  It's not necessary to push more than 'num_online_cpus() - 1' tasks.
>>>  If just pushed task doesn't leave its new CPU during our local call
>>>  of push_rt_tasks() than we won't push another task to the CPU.
>>>  If it leave or change priority than it will pull new task by itself.
>>
>> I'm curious. Have you hit situations where this was an issue? Or was
>> this just discovered by code review?
> 
> No, I did't hit this situation. It's impossible to hook every situation.
> 
> Thanks for your explanation.
> 
> Kirill
> 

Suppose we have a large number of cpus(say 4096), with the last one running
a low-priority task on it. Is it possible with this patch we will never reach
the last cpu in case that previous cpu has complete the pulled task?


