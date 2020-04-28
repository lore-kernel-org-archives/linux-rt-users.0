Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C5C83000
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6865821707
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 19:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588103588;
	bh=IpBlN6HeObjTA1Yvcaj1sRW4yDq8TR4oZlFFeD5QcHs=;
	h=From:To:Subject:Date:List-ID:From;
	b=EiF7/Pz9aankI+UqUthH0BM4YKeTMXPyslf50euCIcY6FVa+nQ5b7IN2Va0zUbTEn
	 jJhnk+YlVNDZhw3O5cmPiAZGsQhPYnVhMcG7RePKXZHYSRBJDjO1eBOUhc7T2gTM8f
	 OsG8z0kKMfFZT+azaO7cyYbesCmlRXLRX2n98eQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgD1Tw7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgD1Tw6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 15:52:58 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC3220730;
        Tue, 28 Apr 2020 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588103578;
        bh=IpBlN6HeObjTA1Yvcaj1sRW4yDq8TR4oZlFFeD5QcHs=;
        h=From:To:Subject:Date:From;
        b=hFR+vSbRrWjoUOpDnqTbolnmEYxnQWk4d2o+j5YEOswNHPdPrUWLrFdYNctDZaIUq
         H45hAvhmcFxCzEyF7z/cakX9R9kGHyLSqIq/ExLgu7zB0TRSQ91sILEODhQss4a8N/
         mzmaanPfzc2aZEXGRhUHozT89qUNvT4Lq60L8DVM=
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
        Tom Zanussi <zanussi@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH RT 0/2] Linux v4.19.115-rt50-rc1
Date:   Tue, 28 Apr 2020 14:52:54 -0500
Message-Id: <cover.1588103561.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.115-rt50-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-05-01.

To build 4.19.115-rt50-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.115.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.115-rt50-rc1.patch.xz

You can also build from 4.19.115-rt49 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.115-rt49-rt50-rc1.patch.xz


Enjoy,

-- Tom


Rasmus Villemoes (1):
  hrtimer: fix logic for when grabbing softirq_expiry_lock can be elided

Tom Zanussi (1):
  Linux 4.19.115-rt50-rc1

 kernel/time/hrtimer.c | 2 +-
 localversion-rt       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

