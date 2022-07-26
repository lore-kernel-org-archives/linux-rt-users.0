Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017AC00140
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 15:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiGZPvm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiGZPvk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 11:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BDC4120A6
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658850699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/UFemyaSfGivnYq4Pazz5fte9HXy1RBs/X4T6Ikf6VY=;
        b=b+NWYfeJruC9QtG9A7oZl2abzNCp6WDNUv0oaOv+366DSQOdR4Odf/d8gULttEqBD5H8V5
        TZz1EthGT0RK+ipzi5YDwU7xFI1CaX35Qsku4LUnS+SbfX6+4IOdaMWrvXEAjGBBRP+WPp
        mOKj3TEMDMP3b0BsOa8+DN91/Y1Wq2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-YdcVPtyWP5yIbU0QLGv9vA-1; Tue, 26 Jul 2022 11:51:38 -0400
X-MC-Unique: YdcVPtyWP5yIbU0QLGv9vA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03DF9101A54E
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 15:51:38 +0000 (UTC)
Received: from magodse.remote.csb (unknown [10.2.17.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C9F02166B26;
        Tue, 26 Jul 2022 15:51:37 +0000 (UTC)
From:   Manasi Godse <magodse@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com, magodse@redhat.com
Subject: [PATCH] rteval: Add man page entry for -S, --source-download option
Date:   Tue, 26 Jul 2022 08:51:35 -0700
Message-Id: <20220726155135.787696-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Update the man page for rteval kernel download option

Signed-off-by: Manasi Godse <magodse@redhat.com>
---
 doc/rteval.8 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/rteval.8 b/doc/rteval.8
index 25dcfcc298e7..a8129f18a9f5 100644
--- a/doc/rteval.8
+++ b/doc/rteval.8
@@ -108,6 +108,10 @@ Log the output of the loads in the report directory
 .TP
 .B \-O, \-\-onlyload
 Only run the loads (don't run measurement threads)
+.TP
+.B \-S KERNEL_VERSION, \-\-source\-download=KERNEL_VERSION
+download a source kernel from kernel.org and exit
+
 
 .SH MODULE OPTIONS
 These are options that affect the execution behavior of the measurement and load modules.
-- 
2.31.1

