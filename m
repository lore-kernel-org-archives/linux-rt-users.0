Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE9C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jun 2022 16:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbiFGQr4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345174AbiFGQrz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Jun 2022 12:47:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718671D0F8;
        Tue,  7 Jun 2022 09:47:54 -0700 (PDT)
Date:   Tue, 7 Jun 2022 18:47:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654620473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lSDsywJB6k683pdbQfJxNfS1KPID3mBqEa5Vp/AoDIo=;
        b=gWEdLbsAZVKjwpgZjroM0UejhNMN1fzFdMInH76EPGB31BBw8H88bkzk1NUqwGekEkrGcY
        dY4EKc0DWHVI8W+BBz/lDyyjKcqA6bo61ikjKPdpaaV9CETAv4MWUuoUGiV0wHUpjWOC2P
        ksQs6+CZApMQdGX5boy/psrG8ktcPjqe7jdjIWCLdXI/GvEnUnrs+aRhCWtcR08SeqW3xu
        bLN5DIGJPfHRwJyVYWzF6jYRrF6rpDQpFs59GaoGxJPhxszDdGjMJvMks3WScjlzp9qi+N
        TYF8byAqPqSLVWIhdHFC+ohY1sgV//EatJ3Rqxzn87tFgtMHt/s73n1+QAhv5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654620473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lSDsywJB6k683pdbQfJxNfS1KPID3mBqEa5Vp/AoDIo=;
        b=MAH7c61VNSM9hWtcREbn31d1jdc2hKL+ffeAazKqIS4C28xkvGOVkyBgDl5AT6wedS3inS
        oxOa7mIQ17lDriAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.19-rc1-rt1
Message-ID: <Yp+BNyvZjQPMBDXA@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.19-rc1-rt1 patch set. 

Changes since v5.18-rt11:
  - Rebase to v5.19-rc1.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.19-rc1-rt1

The RT patch against v5.19-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patch-5.19-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patches-5.19-rc1-rt1.tar.xz

Sebastian
