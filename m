Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B8FC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Nov 2021 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0126138D
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Nov 2021 15:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhKRPhS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:37:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhKRPhR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Nov 2021 10:37:17 -0500
Date:   Thu, 18 Nov 2021 16:34:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637249656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+B6zZdctl0mI+ppSvAJVHL0dX+5Y9aL3WeWandag/dk=;
        b=sT7p3QkYcuvdbIKabBiMOGWNlErBEnezxKO5/6xhstA/Y4CphcLxnIl8QIHHdhxtWbIihS
        KcYab0LQPk26co7xIO3xxtsOe8j8JYfSGVRZeRZfRKfpCEFHZugeMg6Ugs4/16q79QJSrJ
        Jj0e3E0lKgtDqzUEVslSwX2PhC7RFvbYcqn6KxV5vmmwbhaJHmqJLp5PdedsfBt7NHUVs1
        ITG+52J3zqfJcpSdtXSnfFWlwd9nzAk+xx8ea9YE3194fFF9vCSzHoL/RqGNSjqjd3Pfcq
        zg/V/1oX1FG0PtIXVHXN5Id2iocV12B79mRsLL7IjFGUQVUZrrbt4jSNMKNBUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637249656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+B6zZdctl0mI+ppSvAJVHL0dX+5Y9aL3WeWandag/dk=;
        b=VM8Q3/fj9tRT2jtty2SNHL3b1eXFoxlxzD59kLdkz4pPLZ2EBWDwCPDI+uLt+O1ezoFim6
        7z8m+djwjO4M5mCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16-rc1-rt1
Message-ID: <20211118153415.ylg22cx35a25xtci@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16-rc1-rt1 patch set. 

Changes since v5.15.2-rt20:

  - Rebase to v5.16-rc1.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16-rc1-rt1

The RT patch against v5.16-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16-rc1-rt1.tar.xz

Sebastian
