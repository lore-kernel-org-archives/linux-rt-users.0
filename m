From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] x86: Fix an RT MCE crash
Date: Mon, 11 Jul 2016 13:12:07 -0500
Message-ID: <5783E177.5090109@mvista.com>
References: <1467831301-17233-1-git-send-email-minyard@acm.org>
 <20160711133400.4ded6fc9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Borislav Petkov <bp@alien8.de>, Luck@minyard.net,
	Tony <tony.luck@intel.com>, linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, minyard@acm.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33572 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbcGKSMK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jul 2016 14:12:10 -0400
Received: by mail-oi0-f54.google.com with SMTP id u201so159290051oie.0
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Jul 2016 11:12:09 -0700 (PDT)
In-Reply-To: <20160711133400.4ded6fc9@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/11/2016 12:34 PM, Steven Rostedt wrote:
> On Wed,  6 Jul 2016 13:55:01 -0500
> minyard@acm.org wrote:
>
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> On some x86 systems an MCE interrupt would come in before the kernel
>> was ready for it.  Looking at the latest RT code, it has similar
>> (but not quite the same) code, except it adds a bool that tells if
>> MCE handling is initialized.  That was required because they had
>> switched to use swork instead of a kernel thread.  Here, just
>> checking to see if the thread is NULL is good enough to see if
>> MCE handling is initialized.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   arch/x86/kernel/cpu/mcheck/mce.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
>> index aaf4b9b..cc70d98 100644
>> --- a/arch/x86/kernel/cpu/mcheck/mce.c
>> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
>> @@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
>>   
>>   static void mce_notify_work(void)
>>   {
>> -	wake_up_process(mce_notify_helper);
>> +	if (mce_notify_helper)
>> +		wake_up_process(mce_notify_helper);
>>   }
>>   #else
>>   static void mce_notify_work(void)
>
> Wait, is this all that's needed?

Yes, that's it.

> Also, Boris should be credited here somewhere.

Indeed, he should.  I'll issue V3.

-corey

> -- Steve

