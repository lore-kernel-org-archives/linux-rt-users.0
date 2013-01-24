From: Libo Chen <chenlibo.3@gmail.com>
Subject: Re: [PATCH] drivers: tty:  Make RT aware
Date: Thu, 24 Jan 2013 15:44:36 +0800
Message-ID: <5100E664.8030504@gmail.com>
References: <5100B393.1020004@gmail.com> <E7D257C8-F848-43D3-A172-8BED9BB400A9@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, lizefan@huawei.com,
	jovi.zhangwei@huawei.com, libo.chen@huawei.com
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57060 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab3AXHoq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2013 02:44:46 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so5335858pad.40
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Jan 2013 23:44:45 -0800 (PST)
In-Reply-To: <E7D257C8-F848-43D3-A172-8BED9BB400A9@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2013-1-24 13:30, Sven-Thorsten Dietrich wrote:
> On Jan 23, 2013, at 8:07 PM, Libo Chen <chenlibo.3@gmail.com> wrote:
>
>> From: Libo Chen <libo.chen@huawei.com>
>>
>> On RT  spinlocks are converted to "sleeping" locks and
>> therefor the local_irq_save/restore must be converted to
>> local_irq_save/restore_nort
>>
>> Signed-off-by: Libo Chen <libo.chen@huawei.com>
>>
>> ---
>> arch/alpha/kernel/srmcons.c       |    4 ++--
>> drivers/tty/serial/amba-pl011.c   |    4 ++--
>> drivers/tty/serial/ar933x_uart.c  |    4 ++--
>> drivers/tty/serial/bcm63xx_uart.c |    4 ++--
>> drivers/tty/serial/mfd.c          |    4 ++--
>> drivers/tty/serial/sunhv.c        |    8 ++++----
>> drivers/tty/serial/sunsab.c       |    4 ++--
>> drivers/tty/serial/sunzilog.c     |    4 ++--
>> 8 files changed, 18 insertions(+), 18 deletions(-)
>>
> Has any of this code been tested on actual hardware running RT Kernel?
>
> Thanks
>
> Sven
>
>

Thank you for your attention.  
I don`t have these hardwares, and just review the RT code.  As we know interrupt 
was threaded and spinlock can sleep on RT, so local_irq_save is unnecessary here.

