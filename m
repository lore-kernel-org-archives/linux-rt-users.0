Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52628C77B7C
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 May 2023 15:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbjEKPy4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 May 2023 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbjEKPyt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 May 2023 11:54:49 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD716A7C;
        Thu, 11 May 2023 08:54:46 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9E9D34218A;
        Thu, 11 May 2023 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683820483;
        bh=9131OsjK4tvQX0ZOTvzsxE7ndhiybcAOfx0nYg/wlz0=;
        h=From:Subject:Date:Message-ID:To;
        b=NMJUnKvMlQa2o0gbL06CNq/mNbNlR7C1DRHbJea3J0MN33pZk8gcg3eMkGKykb1bv
         BPMjEAXQJZGnWjGH2McIpfjrhRMHCcNeTR/Rz8co4wPbqGaZJhkNLw8gNKcmU+jHkd
         pec3eWbL0y6twBCsFuAR2NyCJEBsNkd3QFkW9vvJD0ILS+pQXs/dqtVi0V9CqQLEaC
         Yn8Iu0w5EVqAgefYkdEx9uObhvyKesgXcXneVfzcviEVmkoZ7YVzxx5K73UmgodTXe
         kCF6DdqcvmYD2sIowE6XRyy7qrfBqkRS/zW3qs9kJJlGjTNR4V9M3YChCnHHPTdTZc
         +CW2DmATDMZoA==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.111-rt63
Date:   Thu, 11 May 2023 15:49:30 -0000
Message-ID: <168382017084.235454.8413979899849286593@jupiter.home.arpa>
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

I'm pleased to announce the 5.15.111-rt63 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 03aa894822a741d7a3c9659b7878f431f495514a

Or to build 5.15.111-rt63 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.111.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.111-rt63.patch.xz


Enjoy!
Joseph Salisbury
