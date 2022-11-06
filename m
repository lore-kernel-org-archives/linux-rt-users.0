Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B5C433FE
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Nov 2022 19:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKFTRM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Nov 2022 14:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFTRK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Nov 2022 14:17:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9749DBC12
        for <linux-rt-users@vger.kernel.org>; Sun,  6 Nov 2022 11:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667762178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ct/53obgr+TolK8pf6KD3dr+n5Th9R5wBEHA2hn44tc=;
        b=VRfpCG/ZYW6g/U4QjrnGGmCKMUKJmMkZJO1l0gNHScSzGDKxdPKW2+ALC693qJlwiOPvuN
        6APdsUlz9sGxWvFKE1LMVmtIFd58EJ+Rj09w4pHE9c1PYOuC36h/OzSdBgZHZow9C5PxhB
        6KtN65TSg0KgNTr1pfyCmg22nAzAWSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145--Q7oqc2XPEuG6HKrgNL1hg-1; Sun, 06 Nov 2022 14:16:15 -0500
X-MC-Unique: -Q7oqc2XPEuG6HKrgNL1hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9A6E8039A2;
        Sun,  6 Nov 2022 19:16:14 +0000 (UTC)
Received: from localhost (unknown [10.22.32.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ECE740C2064;
        Sun,  6 Nov 2022 19:16:13 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/4] Linux v4.14.298-rt141-rc1
Date:   Sun,  6 Nov 2022 16:16:08 -0300
Message-Id: <20221106191612.21730-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.14.298-rt141-rc1.

This is the backport of the timers update proposed for v4.19-rt by
Sebastian Andrzej Siewior in this email thread:

    timers: backport timer bits
    https://lore.kernel.org/all/20221031155006.1651995-1-bigeasy@linutronix.de/

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2022-11-13.

To build 4.14.298-rt141-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.298.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.298-rt141-rc1.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v4.14.298-rt140:


Anna-Maria Gleixner (1):
  timers: Prepare support for PREEMPT_RT

Luis Claudio R. Goncalves (1):
  Linux 4.14.298-rt141-rc1

Sebastian Andrzej Siewior (1):
  timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers

Thomas Gleixner (1):
  timers: Move clearing of base::timer_running under base:: Lock

 kernel/time/timer.c | 136 ++++++++++++++++++++++++++++++++------------
 localversion-rt     |   2 +-
 2 files changed, 102 insertions(+), 36 deletions(-)

-- 
2.38.1

