From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] drivers: i2c: exynos5: irq spinlock rt-safe
Date: Tue, 25 Aug 2015 23:51:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508252349070.15006@nanos>
References: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: kgene@kernel.org, k.kozlowski@samsung.com, wsa@the-dreams.de,
	ch.naveen@samsung.com, linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	khilman@linaro.org, linux-rt-users@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 25 Aug 2015, Anders Roxell wrote:

> The exynos5_i2c_message_start enables interrupts while holding the i2c
> lock which is sought by the irq handler. If an IRQ is received before
> this lock is released then a deadlock occurs.

That's crap. The interrupt handler runs in an irq thread as RT forces
all normal interrupts to that.

Thanks,

	tglx

 
