From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] sysctl-include-fix.patch
Date: Mon, 21 Nov 2011 11:06:22 -0500
Message-ID: <1321891582.20742.9.camel@frodo>
References: <1321707028-12487-1-git-send-email-jkacur@redhat.com>
	 <1321707028-12487-3-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:43095 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab1KUQGZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Nov 2011 11:06:25 -0500
In-Reply-To: <1321707028-12487-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-11-19 at 13:50 +0100, John Kacur wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cherry-picked for v3.0-rt and fixed minor merge conflict
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  include/linux/sysctl.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Why is this needed? Did something break without it?

And if so, what?

-- Steve

> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 11684d9..92b99dd 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -931,6 +931,7 @@ enum
>  #ifdef __KERNEL__
>  #include <linux/list.h>
>  #include <linux/rcupdate.h>
> +#include <linux/atomic.h>
>  
>  /* For the /proc/sys support */
>  struct ctl_table;


