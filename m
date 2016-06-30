From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Thu, 30 Jun 2016 09:49:19 -0500
Message-ID: <5775316F.2020102@acm.org>
References: <1467293089-27656-1-git-send-email-minyard@acm.org>
 <20160630094301.22d32ec1@gandalf.local.home>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35616 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbcF3Ot1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 10:49:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id d132so7819349oig.2
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 07:49:22 -0700 (PDT)
In-Reply-To: <20160630094301.22d32ec1@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/30/2016 08:43 AM, Steven Rostedt wrote:
> On Thu, 30 Jun 2016 08:24:49 -0500
> minyard@acm.org wrote:
>
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> On some x86 systems an MCE interrupt would come in before the kernel
>> was ready for it.  Looking at the latest RT code, it has similar
>> (but not quite the same) code, except it adds a bool that tells if
>> MCE handling is initialized.  Add the same bool for older versions.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   arch/x86/kernel/cpu/mcheck/mce.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> We noticed this issue on a new Broadwell system when we booted RT
>> on it.  This patch is for 3.10, I'm not sure if it applies to
>> other kernel versions.
> Do you mean other 'older' versions? and that this works with the
> versions after 3.10 without this patch?

I haven't look at supported kernel versions besides 3.10 and 4.4.
The fix was from the 4.4 version of this code.  This patch fixes
v3.10-rt; I can look at finding which other versions need this.  I
was planning to do this, but I wanted to get the patch out for
comments first.

-corey

> -- Steve
>
>> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
>> index aaf4b9b..7125584 100644
>> --- a/arch/x86/kernel/cpu/mcheck/mce.c
>> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
>> @@ -1365,6 +1365,7 @@ static void __mce_notify_work(void)
>>   }
>>   
>>   #ifdef CONFIG_PREEMPT_RT_FULL
>> +static bool notify_work_ready __read_mostly;
>>   struct task_struct *mce_notify_helper;
>>   
>>   static int mce_notify_helper_thread(void *unused)
>> @@ -1386,12 +1387,14 @@ static int mce_notify_work_init(void)
>>   	if (!mce_notify_helper)
>>   		return -ENOMEM;
>>   
>> +	notify_work_ready = true;
>>   	return 0;
>>   }
>>   
>>   static void mce_notify_work(void)
>>   {
>> -	wake_up_process(mce_notify_helper);
>> +	if (notify_work_ready)
>> +		wake_up_process(mce_notify_helper);
>>   }
>>   #else
>>   static void mce_notify_work(void)

