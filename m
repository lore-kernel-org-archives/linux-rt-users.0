From: Andy Ritger <aritger@nvidia.com>
Subject: Re: [PATCH RT] Align rt_mutex inlining with upstream behavior
Date: Mon, 30 Jan 2017 09:35:34 -0800
Message-ID: <20170130173534.GA24966@prokofiev.nvidia.com>
References: <1485312350-1265-1-git-send-email-agoins@nvidia.com>
 <20170126170109.6zhoohgodtvxot54@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Alex Goins <agoins@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11251 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750698AbdA3Rhg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Jan 2017 12:37:36 -0500
Content-Disposition: inline
In-Reply-To: <20170126170109.6zhoohgodtvxot54@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 26, 2017 at 06:01:09PM +0100, Sebastian Andrzej Siewior wrote:
> On 2017-01-24 18:45:50 [-0800], Alex Goins wrote:
> > mutex_destroy is no-op inline when DEBUG_MUTEX is not enabled. The RT Linux
> > patches replace mutex_destroy() with rt_mutex_destroy(). This patch aligns
> > rt_mutex_destroy() with mutex_destroy() by using the same no-op inline
> > technique.
> > 
> > Signed-off-by: Alex Goins <agoins@nvidia.com>
> > Reviewed-by: Andy Ritger <aritger@nvidia.com>
> 
> So what is the problem? Why are we doing this? There is still a check to
> see if the lock is in use which is also done for the case where
> DEBUG_MUTEX is disabled.

The problem is that various static inline functions such as
reservation_object_fini() indirectly call mutex_destroy.  On DEBUG_MUTEX
kernels, mutex_destroy is EXPORT_SYMBOL_GPL.

In upstream, non-DEBUG_MUTEX kernels define mutex_destroy to a noop.
This gives users the option of disabling DEBUG_MUTEX if they want to
use non-GPL, reservation_object_fini()-using, kernel modules.

In PREEMPTRT, non-DEBUG_MUTEX kernels export rt_mutex_destroy as
EXPORT_SYMBOL_GPL, so users no longer have the work around of using
DEBUG_MUTEX.

This patch gives PREEMPTRT users the option of disabling DEBUG_MUTEX if
they want to use such kernel modules, matching upstream behavior.

