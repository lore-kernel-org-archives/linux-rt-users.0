Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7F4C7113C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Aug 2023 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358440AbjHRIIm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 04:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358438AbjHRIIl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2023 04:08:41 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFDC2D64;
        Fri, 18 Aug 2023 01:08:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1284BE1A0D;
        Fri, 18 Aug 2023 10:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1692346115; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=2bTXu2dnYG/9hXRr/7a0gHBrqRpY1XtHqtNSiPKkScU=;
        b=Zx29xKVeqRFGKv0ZgroaSNcFOEWvBrrYjYxY/QqViklS+pn3697SXD0prKq3WnXDceX9P/
        tUIwTR/8un7TpNROELeDVDALymnn9MyTDKKINlyHgaRTO7xyJl0kcqU4jEjY8D7gnbIiTB
        hthviP/cmbsCH4s7p65b2ykmfZYKdXwv+L6TccJMsXAko4qGjIY0ClJLwqzZ+H0VgyBx8U
        kTpRC2aoF+7i4wBCrwsauBgr8MLty90DSl1yEv+Os4yxG9NxMnAZXPtEr5Ia+zyDkl3jGN
        NK0+gf9LLECBPUg6E4Eif/VWX7BfCnb8GkH0w9toTT3i57jL4f5c8epDhQVruA==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.292-rt128-rc1
Date:   Fri, 18 Aug 2023 10:08:32 +0200
Message-ID: <20230818080833.31189-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.292-rt128-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2023-08-25.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.291-rt127:


Daniel Wagner (1):
  Linux 4.19.292-rt128

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0

