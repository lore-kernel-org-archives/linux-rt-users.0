From: Alexander Dahl <ada@thorsis.com>
Subject: Re: Building the Raspberry Pi kernel with RT PREEMPT
Date: Wed, 07 Feb 2018 08:55:17 +0100
Message-ID: <5367606.tDxCejrBfR@ada>
References: <e5469b0b-fc0e-95b1-0a80-69a6afab3f12@gmx.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: "t-v.k@gmx.net" <t-v.k@gmx.net>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.thorsis.com ([213.211.200.15]:58691 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbeBGIEn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Feb 2018 03:04:43 -0500
In-Reply-To: <e5469b0b-fc0e-95b1-0a80-69a6afab3f12@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Am Mittwoch, 7. Februar 2018, 00:02:52 CET schrieb t-v.k@gmx.net:
> this is my first time on a mailing list. I'm not sure how this works.

You write to the list address, everyone also subscribed gets your mail, 
including you. Some people will set you in Cc additionally.

> I'm currently trying to automate the build of a Linux kernel with the RT
> PREEMPT patch. The kernel that I'm trying to build is in this git
> repository: https://github.com/raspberrypi/linux (branch rpi-4.14.y)
> 
> It's the official kernel for the Raspberry Pi.

Yes, and it has some patches on top of the upstream vanilla kernel, IIRC 
around 200 the last time a looked at it.

> But at the moment I am stuck. There are two problems. When I apply the
> patch "patch-4.14.15-rt13.patch.gz", I get errors like:
> 
> Hunk #9 FAILED at 795.
> ...
> 1 out of 20 hunks FAILED -- saving rejects to file kernel/softirq.c.rej
> ...
> 
> and as a result of this it exits with code 1.
> 
> Here is the full build process output:
> https://gitlab.com/T-vK/rpi-rt-kernel/-/jobs/51343435
> 
> When I just ignore it and continue I get to the point where I can run
> "make zImage", which then fails with this:

This makes no sense, the patch must apply. You don't want to build anything 
with a half applied patch.

> Can anyone help me with these issues?

If you're on v4.14 anyway, I would recommend to run a vanilla kernel and put 
the RT patch(es) on top. At least for a system without graphics, this should 
work. (I had a RPi 1B running with vanilla v4.12 built with ptxdist and the 
DistroKit BSP some time ago, v4.14 and v4.15 also run fine headless. Should 
also work for RPi 2.)

HTH & Greets
Alex

