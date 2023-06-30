Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC15EB64DA
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 09:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjF3JW4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjF3JWm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D6A3C30
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688116836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGxFzztYxuG3lzbr6gdMoyMVH7K3+cDE30szbMN1MxY=;
        b=CagMp8Ms6jf3dgr+L5vefVNRdspTN/cAy/R8zbHTbhAB8OQNivB9izhb/9DJ4M7alr80pZ
        CxjcjDQZ7/NFwEB28LKYY2WDu5sfr4COc13opAEjh66e1Vq+ChO9YQCZ0SkKxeKROS0kPY
        eYMIvEFCWRAyYzALOYk4U//MH4Lzb7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-pDA9i2l8MfGsk3zvGaIUdA-1; Fri, 30 Jun 2023 05:20:34 -0400
X-MC-Unique: pDA9i2l8MfGsk3zvGaIUdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E92FB88D125
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 09:20:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5430A40C6CCD;
        Fri, 30 Jun 2023 09:20:33 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/6] rteval: Detect isolcpus in systopology
Date:   Fri, 30 Jun 2023 11:19:02 +0200
Message-ID: <20230630091951.916865-2-tglozar@redhat.com>
In-Reply-To: <20230630091951.916865-1-tglozar@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Works similarly to online_cpus:
- add CpuList.isolated_cpulist to filter isolated CPUs
- add SysTopology.isolated_cpus to get list of isolated CPUs
- add CpuList.nonisolated_cpulist to do the opposite filter
- add SysTopology.default_cpus to get CPUs that are used for scheduling
  by default, i.e. online and non-isolated CPUs

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/systopology.py | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index c8f85c5..19443f9 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -127,6 +127,11 @@ class CpuList:
             return True
         return False
 
+    @staticmethod
+    def isolated_file_exists():
+        """ Check whether machine / kernel is configured with isolated file """
+        return os.path.exists(os.path.join(CpuList.cpupath, "isolated"))
+
     @staticmethod
     def longest_sequence(cpulist):
         """ return index of last element of a sequence that steps by one """
@@ -214,6 +219,24 @@ class CpuList:
                 newlist.append(cpu)
         return newlist
 
+    @staticmethod
+    def isolated_cpulist(cpulist):
+        """Given a cpulist, return a cpulist of isolated CPUs"""
+        if not CpuList.isolated_file_exists():
+            return cpulist
+        isolated_cpulist = sysread(CpuList.cpupath, "isolated")
+        isolated_cpulist = CpuList.expand_cpulist(isolated_cpulist)
+        return list(set(isolated_cpulist) & set(cpulist))
+
+    @staticmethod
+    def nonisolated_cpulist(cpulist):
+        """Given a cpulist, return a cpulist of non-isolated CPUs"""
+        if not CpuList.isolated_file_exists():
+            return cpulist
+        isolated_cpulist = sysread(CpuList.cpupath, "isolated")
+        isolated_cpulist = CpuList.expand_cpulist(isolated_cpulist)
+        return list(set(cpulist).difference(set(isolated_cpulist)))
+
 #
 # class to abstract access to NUMA nodes in /sys filesystem
 #
@@ -362,11 +385,35 @@ class SysTopology:
         cpulist.sort()
         return cpulist
 
+    def isolated_cpus(self):
+        """ return a list of integers of all isolated cpus """
+        cpulist = []
+        for n in self.nodes:
+            cpulist += CpuList.isolated_cpulist(self.getcpus(n))
+        cpulist.sort()
+        return cpulist
+
+    def default_cpus(self):
+        """ return a list of integers of all default schedulable cpus, i.e. online non-isolated cpus """
+        cpulist = []
+        for n in self.nodes:
+            cpulist += CpuList.nonisolated_cpulist(self.getcpus(n))
+        cpulist.sort()
+        return cpulist
+
     def online_cpus_str(self):
         """ return a list of strings of numbers of all online cpus """
         cpulist = [str(cpu) for cpu in self.online_cpus()]
         return cpulist
 
+    def isolated_cpus_str(self):
+        cpulist = [str(cpu) for cpu in self.isolated_cpus()]
+        return cpulist
+
+    def default_cpus_str(self):
+        cpulist = [str(cpu) for cpu in self.default_cpus()]
+        return cpulist
+
     def invert_cpulist(self, cpulist):
         """ return a list of online cpus not in cpulist """
         return [c for c in self.online_cpus() if c not in cpulist]
-- 
2.41.0

