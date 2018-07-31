Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.thorsis.com ([92.198.35.195]:57847 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeGaJ3L (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Jul 2018 05:29:11 -0400
From: Alexander Dahl <ada@thorsis.com>
Subject: Re: How to apply RT patches to a kernel not listed in http://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/
Date: Tue, 31 Jul 2018 09:42:03 +0200
Message-ID: <4333850.dc08gExWjP@ada>
In-Reply-To: <CAF_dkJAHfM6QO7UUeyf8YqVmniDLrhBJoVkVJvGwfPC8rED42Q@mail.gmail.com>
References: <CAF_dkJC2UqpDVGzF4K575_hZYii_-OL6H1h=nNO8mTQm4QK2SQ@mail.gmail.com> <20180730205931.GL29574@jcartwri.amer.corp.natinst.com> <CAF_dkJAHfM6QO7UUeyf8YqVmniDLrhBJoVkVJvGwfPC8rED42Q@mail.gmail.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Patrick Doyle <wpdster@gmail.com>

Hei hei,

Am Montag, 30. Juli 2018, 17:26:15 CEST schrieb Patrick Doyle:
> It turns out that there is a v4.9.87-rt65 in the linux-rt tree, but it
> doesn't apply to the linux-at91 tree because they have a customized
> variant of kernel/softirq.c.  (They had to revert an earlier commit on
> mainline).  Since I am likely to want a newer kernel in the future
> anyway, I figured I would try the rebase effort first, and have the
> create-a-patch-to-revert-the-revert approach as a plan B.

Is there any particular reason to use that tree instead of running vanilla 
which has good at91 support, also in v4.9?

(I am using PREEMPT_RT on top of vanilla v4.9.x with an at91sam9g20.)

Greets
Alex

