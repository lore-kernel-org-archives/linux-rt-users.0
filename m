From: Daniel Walker <dwalker@mvista.com>
Subject: Re: 2.6.22  - Mission Impossible :-) -
Date: Tue, 29 May 2007 16:37:14 -0700
Message-ID: <1180481835.32594.89.camel@imap.mvista.com>
References: <1170.213.45.135.240.1180481698.squirrel@www.xcon.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:59077 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXE2Xjz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 May 2007 19:39:55 -0400
In-Reply-To: <1170.213.45.135.240.1180481698.squirrel@www.xcon.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Why do you need to do this?

On Wed, 2007-05-30 at 01:34 +0200, Alessio Igor Bogani wrote:
> Hi,
> 
> I continue with my effort to port last realtime-preempt patch available to
> 2.6.22.
> 
> If i compile without ACPI/hrtimers i don't have any problem (performance
> and stability not tested yet).
> 
> If i compile with these i have a big problem:
> 
> ---[ Cutted form kernel/timer.c ]---
> 
> void msleep(unsigned int msecs)
> {
> 	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
> 	while (timeout)
> 		timeout = schedule_timeout_uninterruptible(timeout);
> }
> 
> ------------------------------------
> 
> The while construct never return!
> 
> I think that Hrtimer subsystem isn't initialized when msleep called from
> do_probe() (ide subsystem).
> 
> Someone have suggestions?
> 
> Thanks in advance!
> 
> Ciao,
> Alessio
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
