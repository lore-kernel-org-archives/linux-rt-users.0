Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2541C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Mar 2021 20:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980CC64F84
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Mar 2021 20:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhCLUP4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbhCLUPt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Mar 2021 15:15:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D249C061574;
        Fri, 12 Mar 2021 12:15:49 -0800 (PST)
Date:   Fri, 12 Mar 2021 21:15:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615580148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=26NUqTHOHh2gaO+/ehndv9FNFiMzz0v2PvCLPL3Z7ZY=;
        b=KcqBpn4ly6wSrrAee6PI7//GPoTZJLUINacKGO3RyfQzB3j/NhJ6g2sL9ZjWIO6KK5Ld0/
        UUkw5wFnHCsqa4FmreNVAfdA0WWxswxSA7Z0tqip10y94zucpI4Y6rzN/iwn9JACt95n8G
        ZWYjHyp6RuPXvuINahRf83r6rq2LinXR94US/nRhNbCdbK/zLTscu6WVpebFLrASeRA4gg
        mflEh3G4z7qxXKXHO9PZgf8S2HLjrPubIS7Kb/AdYgPbAOq0V/mhEFZ6kUlFsmqet/DGEf
        Pya6jNV5JJT7erT/wTeDreJcvG28sovZnHy07UxKMdB3jaaH5U712We7YUJbjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615580148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=26NUqTHOHh2gaO+/ehndv9FNFiMzz0v2PvCLPL3Z7ZY=;
        b=VDuawlXFWPVCfaY3Ge6thWVZD/QswA4nA/PXld7XFtnj+adYS0VRRR2pRMmZAHQvxjgDF6
        aJC/uiEvYkr3MfDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.12-rc2-rt1
Message-ID: <20210312201546.gskgnresmjnw3h3x@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.12-rc2-rt1 patch set. 

Changes since v5.11.4-rt11:

  - Update to v5.12-rc2.

Known issues
     - kdb/kgdb can easily deadlock.
     - netconsole triggers WARN.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.12-rc2-rt1

The RT patch against v5.12-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.12/older/patch-5.12-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.12/older/patches-5.12-rc2-rt1.tar.xz

Sebastian
