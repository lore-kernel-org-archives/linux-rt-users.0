Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08537C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 11:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E0061008
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 11:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhG3LIC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbhG3LIC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 07:08:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F0C061765;
        Fri, 30 Jul 2021 04:07:57 -0700 (PDT)
Date:   Fri, 30 Jul 2021 13:07:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627643274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3rr+XWIGGvICBe2zIcjimmihheZc+8rGEZluQXSIVJg=;
        b=TZFQGwVEnVuOpwl8XyMcJE48QWUQfUkfKSX7x/bGyx1r2e5KXoTxN1Yqes1lzsa9CocZZ6
        4pj5k2lHkZ2rDZyokagu+c42icJ+I5Z69VKSD+/IVXVmi8Hzwv5mQzoTuWagJVvbrIW241
        hozLTXshBB09n26KilNcpdLCUhwavdgnIBo1rzEQObFLozYvBzn6Mdg65RnandtfNGsEbh
        r4CODer6KBrPsS8hQ3i9DfQ0daWfytLDD0G5a6xzHYWi2TQAyOPEJnMhwir0XDsOnAXT80
        FDnNUWmPyZsqlwrB2t4ymvaoPBPJetNuxlHM+YGE4YslFqcXP0GOmJfFRUbjBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627643274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3rr+XWIGGvICBe2zIcjimmihheZc+8rGEZluQXSIVJg=;
        b=4j1oUc5N9f5I9KhjzfuVkuE7iwt0vpOdcqo+NOo6Bux+FRk2+CjbFEkJ3rm0zDHB0wLit2
        iyN9V7KRPFht3uDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc3-rt1
Message-ID: <20210730110753.jvli6alm63h5lefy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc3-rt1 patch set. 

Changes since v5.13-rc3-rt1:

  - Update to v5.14-rc3

  - Update the locking bits.

  - Update the mm/slub bits from Vlastimil Babka. The SLUB_CPU_PARTIAL
    can now be enabled/ disabled. There is a significant hackbench
    related regression due to the rework compared to the old SLUB bits
    we had. However I haven't seen anything in real-world workload. If
    there is anything, please let me know.

  - The "Memory controller" (CONFIG_MEMCG) has been disabled due to
    optimisations which it received as it made it incompatible with
    PREEMPT_RT.

  - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
    still not clear if the RCU related change is correct.

  - A fix for a ARM64 regression which popped up in the v5.13 released
    that led to a freeze while starting the init process.

Known issues
     - netconsole triggers WARN.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc3-rt1

The RT patch against v5.14-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc3-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc3-rt1.tar.xz

Sebastian
