Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34D3C7EE23
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFAU3T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjFAU3S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A981BD
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VWG2fXNVhB4XfbfQNvpqvx10l3d1E9bX/ANPHSpf0g=;
        b=g4yiPFGg1xXWLw5xp46nTs1Z4hbJPlYsdFMsIg5O6dAcEiy4YbmgyhDO73OYDFy0cvC+ga
        zlAhz2qeUFfsh41dbu9NXe/aUiCkzIK+4D0HMDCky3ckLfuBvt1SNGVsFfRi4VQuRINe3r
        c62XRlmUEAsBnzX9oxkXRMvMOSn/VJ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-tIEc0IoSNNGeHJpdFzhEpQ-1; Thu, 01 Jun 2023 16:28:01 -0400
X-MC-Unique: tIEc0IoSNNGeHJpdFzhEpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C49B13C025CE
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A614AC154D9;
        Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 10/10] rteval: Use f-strings in __init__.py
Date:   Thu,  1 Jun 2023 16:27:36 -0400
Message-Id: <20230601202734.813515-11-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in __init__.py

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/__init__.py | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
index 5767e5b7f6fe..31059c564d59 100644
--- a/rteval/sysinfo/__init__.py
+++ b/rteval/sysinfo/__init__.py
@@ -83,27 +83,23 @@ if __name__ == "__main__":
 
     print(f"\tRunning on {si.get_base_os()}")
     print(f"\tNUMA nodes: {si.mem_get_numa_nodes()}")
-    print("\tMemory available: %03.2f %s\n" % si.mem_get_size())
+    print(f"\tMemory available: {si.mem_get_size()[0]:03.2f} {si.mem_get_size()[1]}\n")
 
     print("\tServices: ")
     for (s, r) in list(si.services_get().items()):
-        print("\t\t%s: %s" % (s, r))
+        print(f"\t\t{s}: {r}")
     (curr, avail) = si.kernel_get_clocksources()
 
-    print("\tCurrent clocksource: %s" % curr)
-    print("\tAvailable clocksources: %s" % avail)
+    print(f"\tCurrent clocksource: {curr}")
+    print(f"\tAvailable clocksources: {avail}")
     print("\tModules:")
     for m in si.kernel_get_modules():
-        print("\t\t%s: %s" % (m['modname'], m['modstate']))
+        print(f"\t\t{m['modname']}: {m['modstate']}")
     print("\tKernel threads:")
     for (p, i) in list(si.kernel_get_kthreads().items()):
-        print("\t\t%-30.30s pid: %-5.5s policy: %-7.7s prio: %-3.3s" % (
-            str(i["name"])+":", p, i["policy"], i["priority"]
-            ))
+        print(f"\t\t{str(i['name'])[:30]+':':<30} pid: {str(p)[:5]:<5} policy: {str(i['policy'])[:7]:<7} prio: {str(i['priority'])[:3]:<3}")
 
-    print("\n\tCPU topology info - cores: %i  online: %i  sockets: %i" % (
-        si.cpu_getCores(False), si.cpu_getCores(True), si.cpu_getSockets()
-        ))
+    print(f"\n\tCPU topology info - cores: {si.cpu_getCores(False)}  online: {si.cpu_getCores(True)}  sockets: {si.cpu_getSockets()}")
 
     xml = si.MakeReport()
     xml_d = libxml2.newDoc("1.0")
-- 
2.31.1

