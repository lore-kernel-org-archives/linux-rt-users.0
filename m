Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B56C7EE2F
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjFAU24 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjFAU2w (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217D8199
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGwHwqxRVENN0/67TDjlWY1dABIsmuKaifQxjaGJZq0=;
        b=eMittaa4ZRmWixzPOhBwzBUZx3mXST6uA/WDX6WFGFZOxcRbtyrVCs7OLGLOnxeYXFgovo
        8zaIl0d1auqeQsSzX/s3EERD6ImF3YAZ4mp+x0fSt0WC3zZ+LasU+1MkDiZo98uLQ9JHLU
        XjAke13Q8N2Y34UjJJP+6V8rmLQV8fk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-7sedtibXPbeXZ_kiptGp2w-1; Thu, 01 Jun 2023 16:28:00 -0400
X-MC-Unique: 7sedtibXPbeXZ_kiptGp2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A5DD101A53A
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B547C154D9;
        Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 09/10] Added code to check if the proc/net/if_inet6 file exists while loading IPv6 addresses in the IPv6Addresses class
Date:   Thu,  1 Jun 2023 16:27:35 -0400
Message-Id: <20230601202734.813515-10-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Added code to check if the proc/net/if_inet6 file exists while loading IPv6 addresses in the IPv6Addresses class. If it doesn't, then the system has IPv6 disabled, and that chunk of code is passed.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/newnet.py | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/rteval/sysinfo/newnet.py b/rteval/sysinfo/newnet.py
index 63417d9e59f1..2911400ceb6c 100644
--- a/rteval/sysinfo/newnet.py
+++ b/rteval/sysinfo/newnet.py
@@ -72,19 +72,23 @@ class IPv6Addresses():
             and a list of ipv6addresses
         '''
         MYP = '/proc/net/if_inet6'
-        with open(MYP, 'r') as f:
-            mystr = f.readline().strip()
-            while len(mystr) > 0:
-                ipv6addr , _, _, _, _, intf = mystr.split()
-                ipv6addr = compress_iv6(ipv6addr)
-                if intf == 'lo':
-                    mystr = f.readline().strip()
-                    continue
-                if intf not in self.data:
-                    self.data[intf] = [ipv6addr]
-                else:
-                    self.data[intf].append(ipv6addr)
+        try:
+            with open(MYP, 'r') as f:
                 mystr = f.readline().strip()
+                while len(mystr) > 0:
+                    ipv6addr , _, _, _, _, intf = mystr.split()
+                    ipv6addr = compress_iv6(ipv6addr)
+                    if intf == 'lo':
+                        mystr = f.readline().strip()
+                        continue
+                    if intf not in self.data:
+                        self.data[intf] = [ipv6addr]
+                    else:
+                        self.data[intf].append(ipv6addr)
+                    mystr = f.readline().strip()
+        # if IPv6 is disabled, the if_net6 files does not exist, so we can pass
+        except FileNotFoundError:
+            pass
 
 class IPv4Addresses():
     ''' Obtains a list of IPv4 addresses from the proc file system '''
-- 
2.31.1

