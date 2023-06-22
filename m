Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1822EB64DC
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jun 2023 17:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjFVRtr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjFVRtq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Jun 2023 13:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B3B2135
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jun 2023 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687456128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eGKnzYDbYEhg7BBW8U5rdkwvje1qY3KiHataSW+mHfQ=;
        b=An87CMdIRWJcwwYT2goUC3yNX3tHEw05/khkkakPI37KqaZUXHnNLIk9tisyIbnG91desE
        LcSElbxVTIRgIzJoarNxX1Q1LSyAaaVEw4fUtwjSpxraMCMHYcE5n94B0Hjf3OHi1MomDh
        aKqdb946dBUXHKgwpMM+4qYbrEkC798=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-_TSQv88HPgqDumruySS5hQ-1; Thu, 22 Jun 2023 13:48:45 -0400
X-MC-Unique: _TSQv88HPgqDumruySS5hQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C8D2102D008
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jun 2023 17:48:45 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.9.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35FBB40C2063;
        Thu, 22 Jun 2023 17:48:45 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] rteval-cmd: added code to handle downloading kernel versions of the x.x format.
Date:   Thu, 22 Jun 2023 13:48:02 -0400
Message-Id: <20230622174801.251292-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval-cmd: added code to handle downloading kernel versions of the x.x
format

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rteval-cmd b/rteval-cmd
index cbba9cd2e451..d019da41d8d3 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -291,7 +291,11 @@ if __name__ == '__main__':
                 kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", rtevcfg.srcdownload).group(0)
                 url = "https://git.kernel.org/torvalds/t/"
             else:
-                kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", rtevcfg.srcdownload).group(0)
+                try:
+                    kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", rtevcfg.srcdownload).group(0)
+                except AttributeError:
+                    # if kernel version specified is of the form x.x and not x.x.x
+                    kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}", rtevcfg.srcdownload).group(0)
                 major_version = re.search(r"\d{1,2}", kernel_prefix).group(0)
                 url = "https://kernel.org/pub/linux/kernel/v" + major_version + ".x/"
 
-- 
2.39.3

