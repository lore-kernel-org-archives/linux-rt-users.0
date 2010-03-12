From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] ide: Build break in ide-iops.c
Date: Fri, 12 Mar 2010 20:17:00 +0800
Message-ID: <1268396220.9130.4.camel@falcon>
References: <1268395850-23408-1-git-send-email-jkacur@redhat.com>
	 <1268395850-23408-2-git-send-email-jkacur@redhat.com>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42963 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab0CLMXj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Mar 2010 07:23:39 -0500
In-Reply-To: <1268395850-23408-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-03-12 at 13:10 +0100, John Kacur wrote:
> I get the following build break due to 876c52cc046e00eaa2ffc5124dc187106ef57594
> 
> drivers/ide/ide-iops.c:29:26: error: asm/bootinfo.h: No such file or directory
> 

I think we'd better revert that commit
876c52cc046e00eaa2ffc5124dc187106ef57594 for it has introduced some arch
specific parts into the common ide source code.

And that commit doesn't influence the preempt-rt support, so, Thomas,
could you please revert it directly, thanks!

Regards,
	Wu Zhangjin

> Protect the include by #ifdef CONFIG_MIPS
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  drivers/ide/ide-iops.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> index 9dba71e..8d32dda 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -26,7 +26,10 @@
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
> +
> +#ifdef CONFIG_MIPS
>  #include <asm/bootinfo.h>
> +#endif
>  
>  void SELECT_MASK(ide_drive_t *drive, int mask)
>  {


