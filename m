From: "Chris Caudle" <chris@chriscaudle.org>
Subject: Re: replacement of tasklet_hrtimer_init in RT
Date: Wed, 25 Oct 2017 11:50:01 -0500
Message-ID: <6a64e3bcea28466d2be864ee2ec69f1e.squirrel@email.powweb.com>
References: <69d8d76f1173a449bce4a3bc3a9e1a06.squirrel@email.powweb.com>
    <20171025053441.GA2280@sisyphus.home.austad.us>
Reply-To: chris@chriscaudle.org
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: "Henrik Austad" <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail18.yourhostingaccount.com ([65.254.254.75]:46163 "EHLO
        walmailout08.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751950AbdJYRXp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Oct 2017 13:23:45 -0400
Received: from mailscan13.yourhostingaccount.com ([10.1.15.13] helo=walmailscan13.yourhostingaccount.com)
        by walmailout08.yourhostingaccount.com with esmtp (Exim)
        id 1e7OsY-0007UL-1j
        for linux-rt-users@vger.kernel.org; Wed, 25 Oct 2017 12:50:06 -0400
Received: from [10.114.3.32] (helo=walimpout12)
        by walmailscan13.yourhostingaccount.com with esmtp (Exim)
        id 1e7OsX-0004RJ-Kb
        for linux-rt-users@vger.kernel.org; Wed, 25 Oct 2017 12:50:05 -0400
In-Reply-To: <20171025053441.GA2280@sisyphus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, October 25, 2017 12:34 am, Henrik Austad wrote:
> /me eyes include/linux/interupt.h and kernel/softirq.c and finds
> tasklet_hrtimer_init().

Are you sure?  I previously sent a copy of my interrupt.h to the list, may
have been rejected because I attached the file rather than copied inline.

I downloaded the patches file for 4.11.12-rt14 and searching for
tasklet_hrtimer_init() I find this reference:

0022-softirq-Remove-tasklet_hrtimer.patch:-tasklet_hrtimer_init(struct
tasklet_hrtimer *ttimer,

The very top lines of that 0022 patch file are these:

---------
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 31 Aug 2017 11:03:11 +0000
Subject: [PATCH 22/25] softirq: Remove tasklet_hrtimer

There are no more tasklet_hrtimer users of this interface.
Remove it.
---------

It looks to me like the tasklet_hrtimer interface is being intentionally
removed.

-- 
Chris Caudle


