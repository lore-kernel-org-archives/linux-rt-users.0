From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.10.20-rt17, BUG and Oops
Date: Mon, 02 Dec 2013 09:27:41 +0100
Message-ID: <529C447D.6010306@linutronix.de>
References: <52999A44.7060103@localhost> <529A1511.5050801@osadl.org> <20131130203920.GB24080@linutronix.de> <529A6AFD.9020308@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40962 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab3LBI1t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Dec 2013 03:27:49 -0500
In-Reply-To: <529A6AFD.9020308@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/30/2013 11:47 PM, Carsten Emde wrote:
> Sebastian,

Hi Carsten,

>> index a06d983..d3add07 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -175,16 +175,19 @@ static void start_transaction(struct acpi_ec *ec)
>>   static void advance_transaction(struct acpi_ec *ec, u8 status)
>>   {
>>       unsigned long flags;
> 
>> -    struct transaction *t = ec->curr;
>> +    struct transaction *t;
>>
>>       spin_lock_irqsave(&ec->lock, flags);
>> +    t = ec->curr;
> Looks like a race - did you find a place where ec->curr->wdata could be
> overwritten? The small size of the potential race window may explain why
> it took a couple of days to trigger it.

The pointer is assigned under a lock but here it is dereferenced before
taking the lock. It looks racy this might be the bug.

> Will apply the fix and the warning - let's see.
> 
> Thanks.
>     -Carsten.

Sebastian
