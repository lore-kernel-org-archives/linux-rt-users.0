From: Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c: exynos5: irq spinlock rt-safe
Date: Mon, 31 Aug 2015 23:28:44 +0200
Message-ID: <20150831212844.GI13774@localhost.localdomain>
References: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org>
 <alpine.DEB.2.11.1508252349070.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org,
	ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1508252349070.15006@nanos>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 2015-08-25 23:51, Thomas Gleixner wrote:
> On Tue, 25 Aug 2015, Anders Roxell wrote:
> 
> > The exynos5_i2c_message_start enables interrupts while holding the i2c
> > lock which is sought by the irq handler. If an IRQ is received before
> > this lock is released then a deadlock occurs.
> 
> That's crap. The interrupt handler runs in an irq thread as RT forces
> all normal interrupts to that.

You are right, I will send a v2 with a better changelog.

Cheers,
Anders
