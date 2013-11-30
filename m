From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: 3.10.20-rt17, BUG and Oops
Date: Sat, 30 Nov 2013 23:47:25 +0100
Message-ID: <529A6AFD.9020308@osadl.org>
References: <52999A44.7060103@localhost> <529A1511.5050801@osadl.org> <20131130203920.GB24080@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:37717 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab3K3WxS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Nov 2013 17:53:18 -0500
In-Reply-To: <20131130203920.GB24080@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian,

>> # addr2line -e vmlinux 0xffffffff81298301
>> /usr/src/kernels/linux-3.12.0-rt2/drivers/acpi/ec.c:186
>>
>>         if (t->wlen > t->wi) {
>>                 if ((status & ACPI_EC_FLAG_IBF) == 0)
>>                         acpi_ec_write_data(ec,
>> ---->                           t->wdata[t->wi++]);
>>                 else
>>                         goto err;
>
> based on the assembly, I *think* this is
>   t->wdata[x]
>
> wher X is outside of wdata's range. But then  the pointer is almost
> NULL.
Note the offensive addresses of the two crashes

2013-11-26-23.28
unable to handle kernel paging request at 000000000000809b

2013-11-12-08.15
unable to handle kernel NULL pointer dereference at 000000000000007a

it looks like the write data pointer t->wdata was overwritten - in the 
first case by 0x8000 and in the second case by 0.

> Is this any help?
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index a06d983..d3add07 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -175,16 +175,19 @@ static void start_transaction(struct acpi_ec *ec)
>   static void advance_transaction(struct acpi_ec *ec, u8 status)
>   {
>   	unsigned long flags;

> -	struct transaction *t = ec->curr;
> +	struct transaction *t;
>
>   	spin_lock_irqsave(&ec->lock, flags);
> +	t = ec->curr;
Looks like a race - did you find a place where ec->curr->wdata could be 
overwritten? The small size of the potential race window may explain why 
it took a couple of days to trigger it.

Will apply the fix and the warning - let's see.

Thanks.
	-Carsten.
