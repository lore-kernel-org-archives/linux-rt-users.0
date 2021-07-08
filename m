Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3015C07E96
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 09:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29B7619B5
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 09:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhGHJpD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhGHJpC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 05:45:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F8C061574;
        Thu,  8 Jul 2021 02:42:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625737337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+WpxD020vhxG1Ruy5DEHbRbzkkwanr+3vJpv6GgaeAE=;
        b=X4D5XIZ1g5AxCcwAGm1mAASbRG9B3iqNj8/jwMM15iil07K1m2Xa9ubcwLS74GZK+1hpgF
        VcoZdZLOq1sGt7CchHEths8tSk21Vf414PgzIY+hhGDr5rUgPEoQUNxT629TEXBmGgy1dc
        l6QomVYiZRsJBKBpSfh6RpEuBKcv3WtOQyPQcZ6ZjqESblZwZmp9EAbinVOHqDXCc8RKr2
        HDJIU4QOKkPdduGlMZE0ob8og6U7y8hFhBLJmEfmlAh5G4m1hl39WCFzlz8SPoPln/vCFI
        XDfcJl8n+wiCRjdd11dBffvb+C2uOXRYf2c5bq5IvV2Je3CPPS2dT5CNL6uHqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625737337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+WpxD020vhxG1Ruy5DEHbRbzkkwanr+3vJpv6GgaeAE=;
        b=tUKChDjXJqeGo0rTl4cX/2vbewPWhVFATodqkcq5WngZbSLyPLR1rRhHrqlpJAFBlDkfDd
        q1A/nti3Rewd0RAQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v5.13-rt1
Date:   Thu, 08 Jul 2021 11:42:17 +0200
Message-ID: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.13-rt1 patch set.

Changes since v5.12-rc3-rt3:

  - Fast forward to v5.13

  - Rework of the locking core bits

  - Rework of large parts of the mm bits. Thanks to Mel Gorman and
    Vlastimil Babka for picking this up and polishing it with -mm
    wizardry.

  - The latest respin of the printk overhaul from John Ogness

  - Patch queue reordered

Known issues
  - config dependent build fails on ARM (also in plain v5.13)
  - netconsole triggers WARN.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.13-rt1

The RT patch against v5.13 can be found here:

  https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.13/patch-5.13-rt1.patch.xz

The split quilt queue is available at:

  https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.13/patches-5.13-rt1.tar.xz

Thanks,

        tglx
