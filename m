From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH] drivers: tty:  Make RT aware
Date: Wed, 23 Jan 2013 21:30:37 -0800
Message-ID: <E7D257C8-F848-43D3-A172-8BED9BB400A9@thebigcorporation.com>
References: <5100B393.1020004@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, lizefan@huawei.com,
	jovi.zhangwei@huawei.com
To: Libo Chen <chenlibo.3@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44821 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab3AXFak (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2013 00:30:40 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so3870942pab.19
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Jan 2013 21:30:40 -0800 (PST)
In-Reply-To: <5100B393.1020004@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Jan 23, 2013, at 8:07 PM, Libo Chen <chenlibo.3@gmail.com> wrote:

> From: Libo Chen <libo.chen@huawei.com>
> 
> On RT  spinlocks are converted to "sleeping" locks and
> therefor the local_irq_save/restore must be converted to
> local_irq_save/restore_nort
> 
> Signed-off-by: Libo Chen <libo.chen@huawei.com>
> 
> ---
> arch/alpha/kernel/srmcons.c       |    4 ++--
> drivers/tty/serial/amba-pl011.c   |    4 ++--
> drivers/tty/serial/ar933x_uart.c  |    4 ++--
> drivers/tty/serial/bcm63xx_uart.c |    4 ++--
> drivers/tty/serial/mfd.c          |    4 ++--
> drivers/tty/serial/sunhv.c        |    8 ++++----
> drivers/tty/serial/sunsab.c       |    4 ++--
> drivers/tty/serial/sunzilog.c     |    4 ++--
> 8 files changed, 18 insertions(+), 18 deletions(-)
> 

Has any of this code been tested on actual hardware running RT Kernel?

Thanks

Sven

