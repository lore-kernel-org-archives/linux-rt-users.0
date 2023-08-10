Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE11C001B0
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Aug 2023 18:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjHJSP1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJSP0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Aug 2023 14:15:26 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E0BE4B;
        Thu, 10 Aug 2023 11:15:22 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E34AB414B0;
        Thu, 10 Aug 2023 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691691321;
        bh=7yNSBPeYEd+pgdHNWjHiWmlpoOyE8CdrcanWfecVl28=;
        h=From:Subject:Date:Message-ID:To;
        b=P9nqkYn1R/MJsSxt/OLm2PYHPxZC1TFvRN1dPaq0Pm4qeT6Eu3n9GnYKUYaJGl85b
         zakHeXG9eHFdFf30TcvPPWOawV6m/aueWdVX/3+D1TvZitt+wDKjCpsaOceu5pynXN
         mV3UA2EKOgyBznXbbENrWCqDgLFJoxm1cm+spluQPrEmDYvsdyaAb2FBTK6ttDUXqx
         FtW131N6/umfoVo8gytYVb7j2Sw9Hvwj8rph0t863LXZ61KM+dJBJldryYYEnRK7vI
         KYmmVAXGBTHE/2YBJ9hhIcUv4SGNXsb2eJB1iBD9aQ5gYgFbPa+4OB9fESo172LyJR
         mmv+CkV9dAVug==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.125-rt66
Date:   Thu, 10 Aug 2023 18:14:46 -0000
Message-ID: <169169128664.175210.8837853447375777137@jupiter.home.arpa>
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

I'm pleased to announce the 5.15.125-rt66 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: bc88aa9e27373b7821f71eb6348f70c2481dbc4e

Or to build 5.15.125-rt66 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.125.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.125-rt66.patch.xz


Enjoy!
Joseph Salisbury
