From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Mon, 14 Feb 2011 15:04:03 -0800
Message-ID: <1297724643.10271.16.camel@quadrophenia>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37578 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1BNXEK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Feb 2011 18:04:10 -0500
Received: by wwa36 with SMTP id 36so5475819wwa.1
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2011 15:04:09 -0800 (PST)
In-Reply-To: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-02-14 at 14:31 -0800, Peter LaDow wrote:
> How is the scheduling of the hrtimers softirq thread handled?
> 
> When querying the RT priority of the hrtimer softirq, I get a priority
> of 50.  But when running a priority 99 thread, we still seem to be
> getting interrupted.  Shouldn't the hrtimer softirq be put off until
> the CPU is idle or a lower priority task is running?

Does your prio 99 thread perhaps encounter a prio inversion dependency
on one of the softriq threads? 

> 
> Thanks,
> Pete
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


