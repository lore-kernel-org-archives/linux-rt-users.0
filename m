From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] Align rt_mutex inlining with upstream behavior
Date: Fri, 3 Feb 2017 16:54:34 +0100
Message-ID: <20170203155434.utptndmoskcyimn7@linutronix.de>
References: <1485312350-1265-1-git-send-email-agoins@nvidia.com>
 <20170126170109.6zhoohgodtvxot54@linutronix.de>
 <20170130173534.GA24966@prokofiev.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Goins <agoins@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Andy Ritger <aritger@nvidia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdBCPyq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2017 10:54:46 -0500
Content-Disposition: inline
In-Reply-To: <20170130173534.GA24966@prokofiev.nvidia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-01-30 09:35:34 [-0800], Andy Ritger wrote:
> The problem is that various static inline functions such as
> reservation_object_fini() indirectly call mutex_destroy.  On DEBUG_MUTEX
> kernels, mutex_destroy is EXPORT_SYMBOL_GPL.

So your problem is simply that your non-GPL module can't link anymore
with -RT.  Would it help you if I simply replace the export for
mutex_destroy with EXPORT_SYMBOL and leave it the function as is?

Sebastian
