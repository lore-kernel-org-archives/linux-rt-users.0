From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [PATCH v2] rt: x86: enable preemption in IST exception for x86-32
Date: Tue, 22 Dec 2015 10:12:42 -0800
Message-ID: <5679929A.5030806@linaro.org>
References: <1450134404-16662-1-git-send-email-yang.shi@linaro.org>
 <20151222120628.GA27274@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34771 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbbLVSMr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 13:12:47 -0500
Received: by mail-pa0-f48.google.com with SMTP id uo6so15707436pac.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2015 10:12:47 -0800 (PST)
In-Reply-To: <20151222120628.GA27274@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/22/2015 4:06 AM, Sebastian Andrzej Siewior wrote:
> * Yang Shi | 2015-12-14 15:06:44 [-0800]:
>
>> Mainline kernel commit 959274753857efe9c5f1ba35fe727f51e9aa128d
>> ("x86, traps: Track entry into and exit from IST context"), introduced
>> ist_enter which disables preemption uncondiontionally for both x86-64 and
>> x86-32. However, x86-32 does not have an IST and the stack still belongs to
>> the current task and there is no problem in scheduling out the task.
>
> no no. So from a quick look I *assumed* you merged your v1 and revert of the
> Steven's patch into one piece. But now I see that you don't disable preemption
> 64bit which means you revert upstream change.

No, I neither merged my v1 patch nor reverted Steven's patch.

Directed by Thomas's suggestion in v1 patch review, I looked into the 
code further.

Currently, the code does:

ist_enter disables preemption unconditionally for both x86-64 and x86-32 
(by mainline commit). So, for the x86-64 part, it is fine since the 
preemption should be disabled because ist exception will use per CPU 
stack and signal delay send is necessary.

But, disabling preemption on x86-32 is unnecessary since it doesn't have 
ist stacks, so the v2 patch re-enables preemption for x86-32.

upstream commit 959274753857efe9c5f1ba35fe727f51e9aa128d ("x86, traps: 
Track entry into and exit from IST context") commit log has more details 
for the ist stacks.

So, #1) v1 patch is not needed anymore since x86-32 still doesn't need 
signal delay send in v2, #2) don't need revert Steven's patch, the logic 
is just changed slightly (#ifdef CONFIG_X86_64 --> #if 
!defined(CONFIG_X86_64)) and adopted the mainline APIs.

So, this is definitely a new approach for fixing the same problem and 
*not* an incremental patch.

>
> Here is what happens:
> - I drop your v2
> - I merge your v1 with updated patch description
> - I revert "x86: Do not disable preemption in int3 on 32bit". If someone
>    wants to skip the delayed signal on 32bit please address this upstream
>    first (that is skip the preempt_disable() on 32bit if it is not
>    required there).
> - Yang Shi, please send a changelong if you send incremental patches.

Sorry for any inconvenience. I should made the comment clearer at the 
first place even though it is not an incremental patch.

Thanks,
Yang

>
> Sebastian
>

