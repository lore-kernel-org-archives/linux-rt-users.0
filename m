Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC761C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Nov 2022 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiKJPg2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKJPg0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Nov 2022 10:36:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D6A25F5
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Nov 2022 07:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668094531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gUzXk+m1ogWF4FNnHlP1trT7zGSrNW9lJU7yTn5BVLE=;
        b=Q8qdTr954fdWT+1EkFpSfC052rdK16hFQcDQzk8PjwrZooTv6zRfglenLqHsAMY5zVYlhN
        bcXJAfK+CgGr+dhAGSclnyMWBp5JXFv6R1HRy9sz6vlxiiELDKeeWMXavlWtRRN7lP9ghc
        vrx41InXAAULpWYsiB5kZ3UbERcSoC8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-kKvIj8n6McisG4X1B7HKmg-1; Thu, 10 Nov 2022 10:35:30 -0500
X-MC-Unique: kKvIj8n6McisG4X1B7HKmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B00C086EB21
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Nov 2022 15:35:29 +0000 (UTC)
Received: from lleshchi.bos.com (unknown [10.22.11.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F7282166B29;
        Thu, 10 Nov 2022 15:35:29 +0000 (UTC)
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH] rt-tests: hwlatdetect: Update to integer division
Date:   Thu, 10 Nov 2022 10:35:27 -0500
Message-Id: <20221110153527.553524-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In Python 3, "/" is a float division operator, as opposed to Python 2,
which defaults to integer division. This results in an error when
calculating width, which assumes an integer.

Update width division to integer division with the "//" operator.

Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 7b1ae646577a..929107f9c252 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -454,9 +454,10 @@ if __name__ == '__main__':
 
     if args.window:
         w = microseconds(args.window)
+        width = w//2
         if w < int(detect.get("width")):
-            debug(f"shrinking width to {w//2} for new window of {w}")
-            detect.set("width", w/2)
+            debug(f"shrinking width to {width} for new window of {w}")
+            detect.set("width", width)
         debug(f"window parameter = {w}")
         detect.set("window", w)
         debug(f"window for sampling set to {w}us")
-- 
2.31.1

