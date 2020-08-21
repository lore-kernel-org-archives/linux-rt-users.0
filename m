Return-Path: <SRS0=gFqs=B7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AABAC433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C9C20791
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598039232;
	bh=xfxCYHtN0RaWBl/IDfF8sZMluajDPRGUu0bXN51kmok=;
	h=From:To:Subject:Date:List-ID:From;
	b=kaNwQM5AG+S7Mr+OwUhhlLAp4qa2Jm+nLBUamX04gxEwEJgRHwQZoh6ebNVa7tIyp
	 uPbSH2cLn+5Fe4oH7PwLYU31R6TYzI7m9GFCUV8c6yMQOkGSGrjphLyw2mEWzZBDTh
	 +OaI2pLURHeDcXLK+yG3nac5vomguvIUZm9660PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHUTrK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgHUTrI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Aug 2020 15:47:08 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AFA620738;
        Fri, 21 Aug 2020 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598039226;
        bh=xfxCYHtN0RaWBl/IDfF8sZMluajDPRGUu0bXN51kmok=;
        h=From:To:Subject:Date:From;
        b=Pn2Pi4K6KzYbbkJQ1T0SinM6dZR1yg7qUaWuyoT1OorzoQ1rC+Z9mFLfF0H+fXg0q
         707nJ/bVCb0pPDhK5BNQN6Ye/C2gyzOCZEgNAQULGHWKXeiggbmhiVt5j8/C+kFvwP
         WxcC/sWxBhKLVuUwcchMzd0ee0TBuwaOcZ1BjSc4=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/5] Linux v4.19.135-rt61-rc1
Date:   Fri, 21 Aug 2020 14:46:59 -0500
Message-Id: <cover.1598039186.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.135-rt61-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-08-28.

To build 4.19.135-rt61-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.135.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.135-rt61-rc1.patch.xz

You can also build from 4.19.135-rt60 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.135-rt60-rt61-rc1.patch.xz


Enjoy,

-- Tom


Ahmed S. Darwish (1):
  net: phy: fixed_phy: Remove unused seqcount

Davidlohr Bueso (1):
  net: xfrm: fix compress vs decompress serialization

Matt Fleming (1):
  signal: Prevent double-free of user struct

Sebastian Andrzej Siewior (1):
  Bluetooth: Acquire sk_lock.slock without disabling interrupts

Tom Zanussi (1):
  Linux 4.19.135-rt61-rc1

 drivers/net/phy/fixed_phy.c | 25 +++++++++----------------
 kernel/signal.c             |  4 ++--
 localversion-rt             |  2 +-
 net/bluetooth/rfcomm/sock.c |  7 ++-----
 net/xfrm/xfrm_ipcomp.c      | 21 +++++++++++++++------
 5 files changed, 29 insertions(+), 30 deletions(-)

-- 
2.17.1

