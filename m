Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F00DEEAA42
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Sep 2023 02:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjIOCcg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 22:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjIOCcg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Sep 2023 22:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E499B269D
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Sep 2023 19:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694745104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WdqM9+ntA2gHdo4tESusAskDOpZ1bZ/J8rwXx/BjGro=;
        b=cS+FSJeid5mI36ygXHOguM5/I97M6SfbLKsGvmnrQcyB8WhDevVjfJwVOIOkWQboTq+cLU
        0BxzpQtTJvdtM8bNL0ezhqNY4PA7teTeqf9lDeqcIwA2fbka2ha5tUHW9Wlbjy4/Un5bQu
        G+0PnpoBVMaVfXj1/8+JT8EZZM/CduQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-kQs_kJDSOau-rg8Mifc1wA-1; Thu, 14 Sep 2023 22:31:40 -0400
X-MC-Unique: kQs_kJDSOau-rg8Mifc1wA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFFD4185A790;
        Fri, 15 Sep 2023 02:31:39 +0000 (UTC)
Received: from localhost (unknown [10.22.17.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E28B5175B5;
        Fri, 15 Sep 2023 02:31:36 +0000 (UTC)
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
        Wang Yong <wang.yong12@zte.com.cn>,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/2] Linux v5.10.194-rt95-rc1
Date:   Thu, 14 Sep 2023 23:31:33 -0300
Message-ID: <20230915023135.201399-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 5.10.194-rt95-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2023-09-21.

To build 5.10.194-rt95-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.194.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.194-rt95-rc1.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.194-rt94:


Luis Claudio R. Goncalves (1):
  Linux 5.10.194-rt95-rc1

Wang Yong (1):
  arm64: signal: Use ARCH_RT_DELAYS_SIGNAL_SEND

 arch/arm64/include/asm/signal.h | 12 ++++++++++++
 arch/arm64/kernel/signal.c      |  9 +++++++++
 localversion-rt                 |  2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/signal.h

-- 
2.41.0

