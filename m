Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mailout2.hostsharing.net ([83.223.90.233]:57319 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfAWIdC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Jan 2019 03:33:02 -0500
Message-Id: <cover.1548230893.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 23 Jan 2019 09:26:00 +0100
Subject: [PATCH v2 0/6] Raspberry Pi DMA fixes + cleanups
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Frank Pavlic <f.pavlic@kunbus.de>, Martin Sperl <kernel@martin.sperl.org>, Florian Meier <florian.meier@koalo.de>, Clive Messer <clive.m.messer@gmail.com>, Matthias Reichl <hias@horus.com>, dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Tiejun Chen <tiejun.china@gmail.com>, linux-rt-users@vger.kernel.org

Two fixes and four cleanups for the Raspberry Pi DMA driver, v2.

Changes since v1:

* Patch [1/6]: Rework the patch to fix a race condition which could
  still occur with v1, and no longer check for idleness of a channel
  using the ACTIVE flag in the CS register (which is unreliable),
  but check for a zero control block address instead.

* Patch [2/6]: If outstanding writes fail to complete on abort of a
  transaction, print an error message and document a possible cause
  in a code comment. (Stefan Wahren)

* Patch [5/6] and [6/6]: Split patch to remove dead code in two and
  rephrase commit subject to be less generic. (Stefan Wahren, Vinod Koul)

Thanks,

Lukas


Lukas Wunner (6):
  dmaengine: bcm2835: Fix interrupt race on RT
  dmaengine: bcm2835: Fix abort of transactions
  dmaengine: bcm2835: Return void from abort of transactions
  dmaengine: bcm2835: Enforce control block alignment
  dmaengine: bcm2835: Drop gratuitous list deletion
  dmaengine: bcm2835: Drop outdated comment on supported transactions

 drivers/dma/bcm2835-dma.c | 92 +++++++++++++--------------------------
 1 file changed, 31 insertions(+), 61 deletions(-)

-- 
2.20.1
