From: Andy Ritger <aritger@nvidia.com>
Subject: Re: [PATCH RT] Align rt_mutex inlining with upstream behavior
Date: Fri, 3 Feb 2017 08:49:24 -0800
Message-ID: <20170203164924.GB19814@prokofiev.nvidia.com>
References: <1485312350-1265-1-git-send-email-agoins@nvidia.com>
 <20170126170109.6zhoohgodtvxot54@linutronix.de>
 <20170130173534.GA24966@prokofiev.nvidia.com>
 <20170203155434.utptndmoskcyimn7@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Andy Ritger <aritger@nvidia.com>, Alex Goins <agoins@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170203155434.utptndmoskcyimn7@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Feb 03, 2017 at 04:54:34PM +0100, Sebastian Andrzej Siewior wrote:
> On 2017-01-30 09:35:34 [-0800], Andy Ritger wrote:
> > The problem is that various static inline functions such as
> > reservation_object_fini() indirectly call mutex_destroy.  On DEBUG_MUTEX
> > kernels, mutex_destroy is EXPORT_SYMBOL_GPL.
> 
> So your problem is simply that your non-GPL module can't link anymore
> with -RT.  Would it help you if I simply replace the export for
> mutex_destroy with EXPORT_SYMBOL and leave it the function as is?

Yes, definitely.

Thanks,
- Andy
