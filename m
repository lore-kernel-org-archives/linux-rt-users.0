Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D9C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Jul 2022 17:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiGRRtj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiGRRtj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Jul 2022 13:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC1F02B608
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Jul 2022 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658166576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/v9C8IVWnHwkh1IYyzNz1WEisDLhjKbD5jwVdQcA0h4=;
        b=GE5iMSK7ajGOYHHqhpyKDZUkT3rOUuDoAKQIGzDUm9OiCyhY1sMzeesrEvGLQu4CtdyXyd
        vqNqEBViZpOHbZv6ZNwN5YoX8lEqjrRwSkugqdB3t2qCxPOGEJwnRKb2rRIZtPl9dw0Z+J
        pJxDCq93fh4zdLeNZY9aEMsSDR8A9VI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-v0jdJGJgNRutCmzUmqsSaw-1; Mon, 18 Jul 2022 13:49:21 -0400
X-MC-Unique: v0jdJGJgNRutCmzUmqsSaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C61D101A586
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Jul 2022 17:49:21 +0000 (UTC)
Received: from lleshchi.bos.com (unknown [10.22.10.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13BC01121314;
        Mon, 18 Jul 2022 17:49:21 +0000 (UTC)
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH] Add measurement and load location to run report
Date:   Mon, 18 Jul 2022 13:49:18 -0400
Message-Id: <20220718174918.570599-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The run report produced at the end of a run does not contain information
on load and measurement thread locations.

Adjust MakeReport() functions of LoadModules and MeasurementModules
class so that new properties with number of loads and cpu information
are added to the XML report and can be read by rteval_text.xsl.

Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>

diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
index 2c2105efa964..f08c1ce07cac 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -30,6 +30,7 @@ import libxml2
 from rteval.Log import Log
 from rteval.rtevalConfig import rtevalCfgSection
 from rteval.modules import RtEvalModules, rtevalModulePrototype
+from rteval.misc import compress_cpulist, online_cpus
 
 class LoadThread(rtevalModulePrototype):
     def __init__(self, name, config, logger=None):
@@ -131,6 +132,11 @@ class LoadModules(RtEvalModules):
     def MakeReport(self):
         rep_n = RtEvalModules.MakeReport(self)
         rep_n.newProp("load_average", str(self.GetLoadAvg()))
+        rep_n.newProp("loads", str(self.ModulesLoaded()))
+        cpulist = self._cfg.GetSection(self._module_config).cpulist
+        if not cpulist:
+            cpulist = compress_cpulist(sorted(online_cpus()))
+        rep_n.newProp("loadcpus", str(cpulist))
 
         return rep_n
 
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 318248bd7e35..356daff5ef73 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -24,7 +24,7 @@
 
 import libxml2
 from rteval.modules import RtEvalModules, ModuleContainer
-
+from rteval.misc import compress_cpulist, online_cpus
 
 class MeasurementProfile(RtEvalModules):
     """Keeps and controls all the measurement modules with the same measurement profile"""
@@ -189,6 +189,11 @@ measurement profiles, based on their characteristics"""
 
         # Get the reports from all meaurement modules in all measurement profiles
         rep_n = libxml2.newNode("Measurements")
+        cpulist = self.__cfg.GetSection("measurement").cpulist
+        if not cpulist:
+            cpulist = compress_cpulist(sorted(online_cpus()))
+        rep_n.newProp("measurecpus", str(cpulist))
+
         for mp in self.__measureprofiles:
             mprep_n = mp.MakeReport()
             if mprep_n:
diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index c40063e3dd19..7ecfac6b6140 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -13,6 +13,14 @@
     <xsl:value-of select="run_info/date"/><xsl:text> </xsl:text><xsl:value-of select="run_info/time"/>
     <xsl:text>&#10;</xsl:text>
 
+    <xsl:text>   Loads:        </xsl:text>
+    <xsl:value-of select="loads/@loads"/><xsl:text> loads run on cores </xsl:text><xsl:value-of select="loads/@loadcpus"/>
+    <xsl:text>&#10;</xsl:text>
+
+    <xsl:text>   Measurement:  </xsl:text>
+    <xsl:text>measurement threads run on cores </xsl:text><xsl:value-of select="Measurements/@measurecpus"/>
+    <xsl:text>&#10;</xsl:text>
+
     <xsl:text>   Run time:     </xsl:text>
     <xsl:value-of select="run_info/@days"/><xsl:text> days </xsl:text>
     <xsl:value-of select="run_info/@hours"/><xsl:text>h </xsl:text>
-- 
2.31.1

