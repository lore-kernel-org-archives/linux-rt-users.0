Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0333BC001DB
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 16:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjHHQk4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjHHQkG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 12:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FDA1558F
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691510019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mQ6k3dv+oTuBGdhIsWHtsf0MK4U2RHr3iubL52JwIPY=;
        b=KOYLV9A3OhZB2VoAM6MTCw7WT5RLs4oGS2q1LEMloYgZc3FakpEf1EsDpyBPqjtGfpkLN2
        BTVCVd/ehiUtMygdnKUqFPqwykWntOfPa/eG6a8Z9ppau8iS4MkJTBmnpv4MsiDpjJbSRX
        yPlYtUrrmb8LQunnCunDPF8zomv8CoU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-i5HNqAB1MQu6RDNDKK2_Hg-1; Tue, 08 Aug 2023 07:52:41 -0400
X-MC-Unique: i5HNqAB1MQu6RDNDKK2_Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EE3885CCE3
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 11:52:41 +0000 (UTC)
Received: from fedora.. (unknown [10.43.17.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90533140E963;
        Tue,  8 Aug 2023 11:52:40 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rteval: Correct Python version in doc/rteval.txt
Date:   Tue,  8 Aug 2023 13:52:01 +0200
Message-ID: <20230808115201.43187-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

doc/rteval.txt specifies that rteval is a Python 2.x program. This is
not true, since rteval no longer works with Python 2.x:
$ python2 rteval-cmd
  File "rteval-cmd", line 67
    print(f"Don't know how to summarize {repfile} (tarfile open failed)")
                                                                       ^
SyntaxError: invalid syntax

Replace "Python 2.x" with "Python 3.x".

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 doc/rteval.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/rteval.txt b/doc/rteval.txt
index 7342866..569168e 100644
--- a/doc/rteval.txt
+++ b/doc/rteval.txt
@@ -21,7 +21,7 @@ of a network packet). To give a realtime application the best chance
 of meeting its deadline(s), a realtime OS must minimize the time
 between event occurance and the servicing of that event (latency). 
 
-This paper describes the 'rteval' program, a Python 2.x program
+This paper describes the 'rteval' program, a Python 3.x program
 developed at Red Hat to help quantify realtime performance on the
 Realtime kernel. Rteval is an attempt to put together a synthetic
 benchmark which mimics a well behaved realtime application, running on
-- 
2.39.3

