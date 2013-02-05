From: Honghui Zhang <zhanghonghui@huawei.com>
Subject: Re: [PATCH] sched/rt: Decrease number of calls of push_rt_task()
 in push_rt_tasks()
Date: Tue, 5 Feb 2013 16:25:11 +0800
Message-ID: <5110C1E7.9020106@huawei.com>
References: <500221360048944@web26g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	<linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Kirill Tkhai <tkhai@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:52959 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab3BEIZa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Feb 2013 03:25:30 -0500
In-Reply-To: <500221360048944@web26g.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2013/2/5 15:22, Kirill Tkhai wrote:
>>
>> Suppose we have a large number of cpus(say 4096), with the last one running
>> a low-priority task on it. Is it possible with this patch we will never reach
>> the last cpu in case that previous cpu has complete the pulled task?
> 
> Yes. But this patch is about several pushable tasks on the same cpu.
> 
> Kirill
> 

Maybe I haven't make myself understood, but in that case, there will be a higher-priority
task in the runqueue of the pushing cpu, and a lower-priority task running in the last cpu
which could not be preempt by push_rt_task(),  I don't think it's acceptable.

Hans


