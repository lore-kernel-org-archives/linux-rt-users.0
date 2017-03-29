From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Wed, 29 Mar 2017 15:04:49 +0200
Message-ID: <20170329130447.GB8306@lerouge>
References: <20170323165512.60945ac6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: riel@redhat.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Wanpeng Li <kernellwp@gmail.com>
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33884 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756020AbdC2NEx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Mar 2017 09:04:53 -0400
Content-Disposition: inline
In-Reply-To: <20170323165512.60945ac6@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Mar 23, 2017 at 04:55:12PM -0400, Luiz Capitulino wrote:
> 
> When there are two or more tasks executing in user-space and
> taking 100% of a nohz_full CPU, top reports 70% system time
> and 30% user time utilization. Sometimes I'm even able to get
> 100% system time and 0% user time.
> 
> This was reproduced with latest Linus tree (093b995), but I
> don't believe it's a regression (at least not a recent one)
> as I can reproduce it with older kernels. Also, I have
> CONFIG_IRQ_TIME_ACCOUNTING=y and haven't tried to reproduce
> without it yet.
> 
> Below you'll find the steps to reproduce and some initial
> analysis.
> 
> Steps to reproduce
> ------------------
> 
> 1. Set up a CPU for nohz_full with isolcpus= nohz_full=
> 
> 2. Pin two tasks that hog the CPU 100% of the time to that CPU

I failed to reproduce with your config. I'm still getting 99% userspace
cputime. So I'm wondering if the hogging style plays a role.

I run pure user loops:

    int main(int argc, char **argv)
    {
        for (;;);
        return 0
    }

Does your user program perform syscalls or IOs of some sort?
