Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D64C7EE25
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jun 2023 01:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjFIBLy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 21:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjFIBLt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2023 21:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166CE125
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Jun 2023 18:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686273070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2HTjxfXRs9/sIRuYG4/H8vlV2W5zqxFh+rpFVOJDPzE=;
        b=aV9Nb+Cmc8z2EmO+J8X4da/GRAYtTdP+Ni2zubUiTjbIzhvzTfiOcwuZ2Us2Fz4WLDGyvl
        hvHvytaX946lULR/LDzLqcqFTB3x88pp5tsPf+n1peWLU4p17nXR7PqycTZd6ZuRfU9X3i
        lI0AMflnTou0I7+9t+96SzV9u2R+/gc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-thxdYsb8NTaDm4Ew1yyieA-1; Thu, 08 Jun 2023 21:11:06 -0400
X-MC-Unique: thxdYsb8NTaDm4Ew1yyieA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 421D3802355;
        Fri,  9 Jun 2023 01:11:06 +0000 (UTC)
Received: from localhost (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 748692026D6A;
        Fri,  9 Jun 2023 01:11:05 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/3] Linux v5.10.180-rt89-rc1
Date:   Thu,  8 Jun 2023 22:11:01 -0300
Message-Id: <20230609011104.967128-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 5.10.180-rt89-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2023-06-15.

To build 5.10.180-rt89-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.180.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.180-rt89-rc1.patch.xz

Signing key fingerprint:

  4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.180-rt88:


Luis Claudio R. Goncalves (3):
  Revert "printk: declare printk_deferred_{enter,safe}() in
    include/linux/printk.h"
  Revert "mm/page_alloc: fix potential deadlock on
    zonelist_update_seqseqlock"
  Linux 5.10.180-rt89-rc1

 include/linux/printk.h | 19 -------------------
 localversion-rt        |  2 +-
 mm/page_alloc.c        | 14 --------------
 3 files changed, 1 insertion(+), 34 deletions(-)

-- 
2.40.1

