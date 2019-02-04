Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfBDHNx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Feb 2019 02:13:53 -0500
Date: Mon, 4 Feb 2019 12:42:24 +0530
From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/6] Raspberry Pi DMA fixes + cleanups
Message-ID: <20190204071223.GI4296@vkoul-mobl>
References: <cover.1548230893.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548230893.git.lukas@wunner.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Frank Pavlic <f.pavlic@kunbus.de>, Martin Sperl <kernel@martin.sperl.org>, Florian Meier <florian.meier@koalo.de>, Clive Messer <clive.m.messer@gmail.com>, Matthias Reichl <hias@horus.com>, dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Tiejun Chen <tiejun.china@gmail.com>, linux-rt-users@vger.kernel.org

On 23-01-19, 09:26, Lukas Wunner wrote:
> Two fixes and four cleanups for the Raspberry Pi DMA driver, v2.

Applied all, thanks

> 
> Changes since v1:
> 
> * Patch [1/6]: Rework the patch to fix a race condition which could
>   still occur with v1, and no longer check for idleness of a channel
>   using the ACTIVE flag in the CS register (which is unreliable),
>   but check for a zero control block address instead.
> 
> * Patch [2/6]: If outstanding writes fail to complete on abort of a
>   transaction, print an error message and document a possible cause
>   in a code comment. (Stefan Wahren)
> 
> * Patch [5/6] and [6/6]: Split patch to remove dead code in two and
>   rephrase commit subject to be less generic. (Stefan Wahren, Vinod Koul)
> 
> Thanks,
> 
> Lukas
> 
> 
> Lukas Wunner (6):
>   dmaengine: bcm2835: Fix interrupt race on RT
>   dmaengine: bcm2835: Fix abort of transactions
>   dmaengine: bcm2835: Return void from abort of transactions
>   dmaengine: bcm2835: Enforce control block alignment
>   dmaengine: bcm2835: Drop gratuitous list deletion
>   dmaengine: bcm2835: Drop outdated comment on supported transactions
> 
>  drivers/dma/bcm2835-dma.c | 92 +++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 61 deletions(-)
> 
> -- 
> 2.20.1

-- 
~Vinod
