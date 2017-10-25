From: "Chris Caudle" <chris@chriscaudle.org>
Subject: Re: replacement of tasklet_hrtimer_init in RT
Date: Wed, 25 Oct 2017 14:40:22 -0500
Message-ID: <5fb5c8a43fe5197c55df75db6a7bc3c1.squirrel@email.powweb.com>
References: <69d8d76f1173a449bce4a3bc3a9e1a06.squirrel@email.powweb.com>
    <20171025053441.GA2280@sisyphus.home.austad.us>
    <6a64e3bcea28466d2be864ee2ec69f1e.squirrel@email.powweb.com>
Reply-To: chris@chriscaudle.org
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: "Henrik Austad" <henrik@austad.us>, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail18.yourhostingaccount.com ([65.254.254.75]:33427 "EHLO
        walmailout08.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932219AbdJYTk2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Oct 2017 15:40:28 -0400
Received: from mailscan04.yourhostingaccount.com ([10.1.15.4] helo=walmailscan04.yourhostingaccount.com)
        by walmailout08.yourhostingaccount.com with esmtp (Exim)
        id 1e7RXP-0002U7-FG
        for linux-rt-users@vger.kernel.org; Wed, 25 Oct 2017 15:40:27 -0400
Received: from [10.114.3.32] (helo=walimpout12)
        by walmailscan04.yourhostingaccount.com with esmtp (Exim)
        id 1e7RXP-0003o5-43
        for linux-rt-users@vger.kernel.org; Wed, 25 Oct 2017 15:40:27 -0400
In-Reply-To: <6a64e3bcea28466d2be864ee2ec69f1e.squirrel@email.powweb.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, October 25, 2017 11:50 am, Chris Caudle wrote:
> I downloaded the patches file for 4.11.12-rt14 and searching for
> tasklet_hrtimer_init() I find this reference:
>
> 0022-softirq-Remove-tasklet_hrtimer.patch:-tasklet_hrtimer_init(struct
> tasklet_hrtimer *ttimer,
>
> The very top lines of that 0022 patch file are these:
>
> ---------
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 31 Aug 2017 11:03:11 +0000
> Subject: [PATCH 22/25] softirq: Remove tasklet_hrtimer
>
> There are no more tasklet_hrtimer users of this interface.
> Remove it.

Does anyone on this list know whether the tasklet_hrtimer interface will
be deprecated for mainline kernel as well?

Can anyone suggest a document that describes (hopefully simply enough for
a kernel beginner to understand) how to convert an existing implementation
from tasklet_hrtimer to an alternative?

thank you,
Chris Caudle


