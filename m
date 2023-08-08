Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED5DC04A94
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 18:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjHHSoN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjHHSns (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 14:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3207F35C4F
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VprCCjOnZ8U8uZDQtcIIs9UExc35M7QTx7DJAv+v/IQ=;
        b=JEBsFT49kES4XcSGoM3pynxLtacTw72ddo/Fjed96SuFYDuKeHykAac37EgNTXZ/PTRfPC
        k1OCUhrfR11QT40bOQi37pYYCk/ws48EWfMxk5S+gpZA6YG8HvEVP4ArytjNJHI+YrrJsQ
        zWVmDJv9WeoTlj7BEhwIB09qVipv/xA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-L8gy3KIpOdmRznagK_NPEw-1; Tue, 08 Aug 2023 12:35:22 -0400
X-MC-Unique: L8gy3KIpOdmRznagK_NPEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5290101A52E;
        Tue,  8 Aug 2023 16:35:21 +0000 (UTC)
Received: from localhost (unknown [10.22.32.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 585AD140E962;
        Tue,  8 Aug 2023 16:35:21 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/3] Linux v4.14.320-rt152-rc1
Date:   Tue,  8 Aug 2023 13:35:17 -0300
Message-ID: <20230808163520.305842-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.14.320-rt152-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2023-08-15.

To build 4.14.320-rt152-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.320.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.320-rt152-rc1.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v4.14.320-rt151:


Clark Williams (1):
  rt: PREEMPT_RT safety net for backported patches

Luis Claudio R. Goncalves (2):
  rt: timers: use CONFIG_PREEMPT_RT_FULL instead of CONFIG_PREEMPT_RT
  Linux 4.14.320-rt152-rc1

 kernel/Kconfig.preempt | 4 ++++
 kernel/time/timer.c    | 4 ++--
 localversion-rt        | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.41.0

