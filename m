From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] Align rt_mutex inlining with upstream behavior
Date: Thu, 26 Jan 2017 18:01:09 +0100
Message-ID: <20170126170109.6zhoohgodtvxot54@linutronix.de>
References: <1485312350-1265-1-git-send-email-agoins@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Alex Goins <agoins@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485312350-1265-1-git-send-email-agoins@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-01-24 18:45:50 [-0800], Alex Goins wrote:
> mutex_destroy is no-op inline when DEBUG_MUTEX is not enabled. The RT Linux
> patches replace mutex_destroy() with rt_mutex_destroy(). This patch aligns
> rt_mutex_destroy() with mutex_destroy() by using the same no-op inline
> technique.
> 
> Signed-off-by: Alex Goins <agoins@nvidia.com>
> Reviewed-by: Andy Ritger <aritger@nvidia.com>

So what is the problem? Why are we doing this? There is still a check to
see if the lock is in use which is also done for the case where
DEBUG_MUTEX is disabled.

Sebastian
