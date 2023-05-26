Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24272C77B73
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 May 2023 16:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjEZQS5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 26 May 2023 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEZQS4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 May 2023 12:18:56 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C2A4;
        Fri, 26 May 2023 09:18:55 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D33FC3F26C;
        Fri, 26 May 2023 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685117930;
        bh=g9Hovuhx9kPE+UCnZ1N7tefI4DJS8ixf28LJsTdyAKI=;
        h=From:Subject:Date:Message-ID:To;
        b=igxNfjLY8SkWlYrB+zxq8U5SAYR2XQR2MqqHYO3t/fs0IQd46ANsQPIuplmFVvQjB
         zgUCn5yyaojK3ov8NSXHQLiQiQbsbi4tOElpL4AdqedjV++5ttXyK0nb2AK3uoktnE
         T583qea2Zv3GskUGd+E28rBYI7JsNkuce3PNTIFtyiIF7DaF1I2vNtdJ5bsjUmZLnc
         d2v53n0IgfrDlbQh0YQPnMN6sHKgCU3DF8B0W7l/NoQ/4TuNKtK+b2tuOWL1+xE0Oe
         37iU6xViUlRAITSRHjTgbakUaiv9Fh1uj4i8gL2sQfsIEh06XuwIxDf1jilC7p/a/T
         5UbGHJ0vrn7QA==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.113-rt64
Date:   Fri, 26 May 2023 16:11:29 -0000
Message-ID: <168511748992.700190.150767189449225263@jupiter.home.arpa>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.113-rt64 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 05e341da63646400e230c505fc07c6b1cd0194ec

Or to build 5.15.113-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.113.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.113-rt64.patch.xz


Enjoy!
Joseph Salisbury
