Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D31AC76196
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Apr 2023 08:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjDKI3g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Apr 2023 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjDKI3a (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Apr 2023 04:29:30 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B9EFD;
        Tue, 11 Apr 2023 01:29:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B786BDB00F;
        Tue, 11 Apr 2023 10:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1681201765; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=gXdANlh8CBrIS+L/24LTQ378VJoiBpUt7boZN8dZsWk=;
        b=t40nP+zmcECApAMaEYYwWFOKiKUN8NjdtjoliNVh/RJTqf8apTBHF5jLj02gLs52kjtLnQ
        PN7cYoANQBDbCHwy3SsB0frSN26BveU3tha0SNOyzff+ZjW4hoDaaP1b8Bex/0NxIk4FrV
        LY6AvXD1MyllTzMFb9vm0VtEeN6giJ3kzAsDUW1nhLOlLbacd0sACZAWN/fGIu50S/mi/9
        SQC/OJAiPG/L4uMgCBhFWBBK7CYqVVsWlsMnXNvQ/W2KmYdA+m/1NMF3HsV5PO6eWBtH0f
        a+TNpfO6H0U1u6Q+CEbYMfolR9lHsgFNdwEraKCZ+IVp+YfIZ2EgBGuqgny0tg==
Date:   Tue, 11 Apr 2023 10:29:19 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.280-rt123-rc1
Message-ID: <168120163546.668.2469547387929089188@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.280-rt123-rc1 release candidate 1. This is just 
a stable update, no RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt-next
  Head SHA1: e007e3d148adaa62e248059623f8dba67ac11a7b

Enjoy!
Daniel


