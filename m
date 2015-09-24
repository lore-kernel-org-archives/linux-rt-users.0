From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 6/7] gpio: omap: move pm runtime in irq_chip.irq_bus_lock/sync_unlock
Date: Thu, 24 Sep 2015 15:28:41 -0700
Message-ID: <CACRpkdbJW6_-yR8CHnK79oEm2c3exUYU-dbKm3YRYe=VVsCMog@mail.gmail.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
	<1439896258-26449-7-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexandre Courbot <gnurou@gmail.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Tony Lindgren <tony@atomide.com>,
	Javier Martinez Canillas <javier@dowhile0.org>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35547 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbbIXW2m (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Sep 2015 18:28:42 -0400
Received: by obbzf10 with SMTP id zf10so69436792obb.2
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2015 15:28:42 -0700 (PDT)
In-Reply-To: <1439896258-26449-7-git-send-email-grygorii.strashko@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Aug 18, 2015 at 4:10 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> The PM runtime API can't be used in atomic contex on -RT even if
> it's configured as irqsafe. As result, below error report can
> be seen when PM runtime API called from IRQ chip's callbacks
> irq_startup/irq_shutdown/irq_set_type, because they are
> protected by RAW spinlock:

Grygorri I have a massive backlog of mail but if patch 6&7 are
still applicable, can you rebase and send me these for the v4.3-rc2+
tree?

Yours,
Linus Walleij
