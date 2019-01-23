Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43943 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfAWQzV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Jan 2019 11:55:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so2335966oie.10
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Jan 2019 08:55:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548230893.git.lukas@wunner.de> <1187157494.710769.1548259821147@email.ionos.de>
In-Reply-To: <1187157494.710769.1548259821147@email.ionos.de>
From: Florian Kauer <florian.kauer@koalo.de>
Date: Wed, 23 Jan 2019 17:55:07 +0100
Message-ID: <CABDT8WywLpMgaD3pgMrY-4TmLeCEobT0neoopbqU=wN4WMasFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Raspberry Pi DMA fixes + cleanups
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Lukas Wunner <lukas@wunner.de>, Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>, Frank Pavlic <f.pavlic@kunbus.de>, Martin Sperl <kernel@martin.sperl.org>, Florian Meier <florian.meier@koalo.de>, Clive Messer <clive.m.messer@gmail.com>, Matthias Reichl <hias@horus.com>, dmaengine <dmaengine@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, Tiejun Chen <tiejun.china@gmail.com>, linux-rt-users@vger.kernel.org

Acked-by: Florian Kauer <florian.kauer@koalo.de>

Am Mi., 23. Jan. 2019 um 17:10 Uhr schrieb Stefan Wahren
<stefan.wahren@i2se.com>:
>
>
> > Lukas Wunner <lukas@wunner.de> hat am 23. Januar 2019 um 09:26 geschrieben:
> >
> >
> > Two fixes and four cleanups for the Raspberry Pi DMA driver, v2.
> >
> > Changes since v1:
> >
> > * Patch [1/6]: Rework the patch to fix a race condition which could
> >   still occur with v1, and no longer check for idleness of a channel
> >   using the ACTIVE flag in the CS register (which is unreliable),
> >   but check for a zero control block address instead.
> >
> > * Patch [2/6]: If outstanding writes fail to complete on abort of a
> >   transaction, print an error message and document a possible cause
> >   in a code comment. (Stefan Wahren)
> >
> > * Patch [5/6] and [6/6]: Split patch to remove dead code in two and
> >   rephrase commit subject to be less generic. (Stefan Wahren, Vinod Koul)
> >
> > Thanks,
> >
> > Lukas
> >
> >
> > Lukas Wunner (6):
> >   dmaengine: bcm2835: Fix interrupt race on RT
> >   dmaengine: bcm2835: Fix abort of transactions
> >   dmaengine: bcm2835: Return void from abort of transactions
> >   dmaengine: bcm2835: Enforce control block alignment
> >   dmaengine: bcm2835: Drop gratuitous list deletion
> >   dmaengine: bcm2835: Drop outdated comment on supported transactions
> >
>
> The whole series is:
>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> Thanks
