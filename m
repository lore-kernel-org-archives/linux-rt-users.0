From: Jacky Lam <lamshuyin@gmail.com>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Mon, 4 Feb 2013 15:27:55 +0800
Message-ID: <CAHX1yNQgJXM292q1DWXLdQiR_BK5jZ-d+QHVoEEgksQm04YU6g@mail.gmail.com>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com>
	<50FE68EF.8060909@meduna.org>
	<CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com>
	<510ACB87.3080007@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41205 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab3BDH16 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 02:27:58 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so5465379ieb.9
        for <linux-rt-users@vger.kernel.org>; Sun, 03 Feb 2013 23:27:57 -0800 (PST)
In-Reply-To: <510ACB87.3080007@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks.

I finally find that if I disable interrupt during ata_qc_issue() in
libata-scsi.c, my sata driver works without any problem.

But I find USB EHCI driver is more complicated. Kernel crashes every
where when RT is turned on. It seems whenever the stack  spin_lock
ehci->lock and interrupt comes at that moment, kernel will be crashes.
The reason is EHCI interrupt handler will also take the same lock. If
my point of view, USB stack seems no PREEMPT_RT safe. Is it correct?
Am I miss anything?


On Fri, Feb 1, 2013 at 3:52 AM, Frank Rowand <frank.rowand@am.sony.com> wrote:
> On 01/31/13 01:27, Jacky Lam wrote:
>> Thanks Stano,
>>
>> I am still debugging this driver. But I find very strange that
>> sometimes printk() in interrupt handler do not output anything. This
>> makes me very difficult to debug. Is it RT patch's expected behaviour?
>> Or I am doing something wrong??
>
> If CONFIG_PREEMPT_RT_FULL then printk() from irq context will be buffered
> but the console driver will not be called to flush the buffer.  The
> next printk() outside irq context will flush the buffer.
>
> -Frank


On Fri, Feb 1, 2013 at 3:52 AM, Frank Rowand <frank.rowand@am.sony.com> wrote:
> On 01/31/13 01:27, Jacky Lam wrote:
>> Thanks Stano,
>>
>> I am still debugging this driver. But I find very strange that
>> sometimes printk() in interrupt handler do not output anything. This
>> makes me very difficult to debug. Is it RT patch's expected behaviour?
>> Or I am doing something wrong??
>
> If CONFIG_PREEMPT_RT_FULL then printk() from irq context will be buffered
> but the console driver will not be called to flush the buffer.  The
> next printk() outside irq context will flush the buffer.
>
> -Frank
