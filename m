Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0631EB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 09:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjF3JXA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjF3JWp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01035B0
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688116837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3tMRVpZxvOfTdQ/kvXFloJOtsCjvgOA3FpDw9MKwGY=;
        b=Pr/ZtxY/sQ3atDoM0A4fYmFIXPMDIvOzm8mPFGA0Zke0emmbTrLh5HADRt0og8gbQftUOm
        BLLcJzvZEnUKHgQQ9qcVDMd1ON3lT98EyI/jtaSYW4x+uzE/918ldOqM6cJb03E2KHQhNT
        pgfVUOJDjkTRhHPX8wRQuRWM1w6aqsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-2hM7KjZ-NBy_qOBrV0vE6g-1; Fri, 30 Jun 2023 05:20:35 -0400
X-MC-Unique: 2hM7KjZ-NBy_qOBrV0vE6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5730800CA9
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 09:20:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5573340C6CD2;
        Fri, 30 Jun 2023 09:20:34 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/6] rteval: Report isolated CPUs
Date:   Fri, 30 Jun 2023 11:19:03 +0200
Message-ID: <20230630091951.916865-3-tglozar@redhat.com>
In-Reply-To: <20230630091951.916865-1-tglozar@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a flag for whether a CPU is isolated in CPUtopology and display
the number of isolated CPUs in text report.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/rteval_text.xsl        |  4 ++++
 rteval/sysinfo/cputopology.py | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index 7ecfac6..0ef649b 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -59,6 +59,10 @@
 	<xsl:value-of select="SystemInfo/CPUtopology/@num_cpu_cores"/>
 	<xsl:text> (online: </xsl:text>
 	<xsl:value-of select="SystemInfo/CPUtopology/@num_cpu_cores_online"/>
+    <xsl:if test="SystemInfo/CPUtopology/@num_cpu_cores_isolated != 0">
+      <xsl:text>, isolated: </xsl:text>
+      <xsl:value-of select="SystemInfo/CPUtopology/@num_cpu_cores_isolated"/>
+    </xsl:if>
 	<xsl:text>)</xsl:text>
       </xsl:when>
       <xsl:when test="hardware/cpu_topology">
diff --git a/rteval/sysinfo/cputopology.py b/rteval/sysinfo/cputopology.py
index 2bb6323..f60b059 100644
--- a/rteval/sysinfo/cputopology.py
+++ b/rteval/sysinfo/cputopology.py
@@ -25,6 +25,7 @@
 
 import os
 import libxml2
+from rteval.systopology import SysTopology
 
 class CPUtopology:
     "Retrieves an overview over the installed CPU cores and the system topology"
@@ -34,6 +35,7 @@ class CPUtopology:
         self.__cputop_n = None
         self.__cpu_cores = 0
         self.__online_cores = 0
+        self.__isolated_cores = 0
         self.__cpu_sockets = 0
 
     def __read(self, dirname, fname):
@@ -51,6 +53,10 @@ class CPUtopology:
 
         self.__cputop_n = libxml2.newNode('CPUtopology')
 
+        # Get list of isolated CPUs from SysTopology
+        systopology = SysTopology()
+        isolated_cpus = {'cpu' + n for n in systopology.isolated_cpus_str()}
+
         cpusockets = []
         for dirname in os.listdir(self.sysdir):
             # Only parse directories which starts with 'cpu'
@@ -82,6 +88,10 @@ class CPUtopology:
                                                       'physical_package_id')
                             cpu_n.newProp('physical_package_id', str(phys_pkg_id))
                             cpusockets.append(phys_pkg_id)
+                            is_isolated = dirname in isolated_cpus
+                            if is_isolated:
+                             self.__isolated_cores += 1
+                            cpu_n.newProp('isolated', str(int(dirname in isolated_cpus)))
                         break
 
         # Count unique CPU sockets
@@ -97,6 +107,7 @@ class CPUtopology:
         # Summarise the core counts
         self.__cputop_n.newProp('num_cpu_cores', str(self.__cpu_cores))
         self.__cputop_n.newProp('num_cpu_cores_online', str(self.__online_cores))
+        self.__cputop_n.newProp('num_cpu_cores_isolated', str(self.__isolated_cores))
         self.__cputop_n.newProp('num_cpu_sockets', str(self.__cpu_sockets))
 
         return self.__cputop_n
-- 
2.41.0

