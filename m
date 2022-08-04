Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A6AC19F2A
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Aug 2022 15:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiHDPsP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiHDPsO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Aug 2022 11:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D09E426AE2
        for <linux-rt-users@vger.kernel.org>; Thu,  4 Aug 2022 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659628092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ouTVt//4ICOg5e54sb8UIo25dfe5W+R9q9Q63n1/lSg=;
        b=WkwXZraY/RUNeuIIlgyK3U08BXpMfnoDKtVAeYFqoV5cOi8HK4qOTVXGAqV4Ogvj2J2dPt
        coHzrgjnUbP8n0qsm+NAVeZ8GvNSS1y3g5cO0o79rsoN53Es78OI0yIFkLExT0ze0Wtk2+
        ckUfNLtZQBeFNJlv9ZdhEJSTtzRtX1g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-5zCg8r6wN36dP0M38-3DlQ-1; Thu, 04 Aug 2022 11:48:08 -0400
X-MC-Unique: 5zCg8r6wN36dP0M38-3DlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EBF68061CB
        for <linux-rt-users@vger.kernel.org>; Thu,  4 Aug 2022 15:48:08 +0000 (UTC)
Received: from lleshchi.bos.com (unknown [10.22.9.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57449909FF;
        Thu,  4 Aug 2022 15:48:08 +0000 (UTC)
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v2] rteval: Add measurement and load location to run report
Date:   Thu,  4 Aug 2022 11:48:07 -0400
Message-Id: <20220804154807.252163-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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
index 2c2105efa964..5e5a5d85b616 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -30,6 +30,7 @@ import libxml2
 from rteval.Log import Log
 from rteval.rtevalConfig import rtevalCfgSection
 from rteval.modules import RtEvalModules, rtevalModulePrototype
+from rteval.systopology import collapse_cpulist, SysTopology
 
 class LoadThread(rtevalModulePrototype):
     def __init__(self, name, config, logger=None):
@@ -131,6 +132,12 @@ class LoadModules(RtEvalModules):
     def MakeReport(self):
         rep_n = RtEvalModules.MakeReport(self)
         rep_n.newProp("load_average", str(self.GetLoadAvg()))
+        rep_n.newProp("loads", str(self.ModulesLoaded()))
+        cpulist = self._cfg.GetSection(self._module_config).cpulist
+        if not cpulist:
+            st = SysTopology()
+            cpulist = collapse_cpulist(st.online_cpus())
+        rep_n.newProp("loadcpus", cpulist)
 
         return rep_n
 
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 318248bd7e35..371fc5d08f44 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -24,7 +24,7 @@
 
 import libxml2
 from rteval.modules import RtEvalModules, ModuleContainer
-
+from rteval.systopology import collapse_cpulist, SysTopology
 
 class MeasurementProfile(RtEvalModules):
     """Keeps and controls all the measurement modules with the same measurement profile"""
@@ -189,6 +189,12 @@ measurement profiles, based on their characteristics"""
 
         # Get the reports from all meaurement modules in all measurement profiles
         rep_n = libxml2.newNode("Measurements")
+        cpulist = self.__cfg.GetSection("measurement").cpulist
+        if not cpulist:
+            st = SysTopology()
+            cpulist = collapse_cpulist(st.online_cpus())
+        rep_n.newProp("measurecpus", cpulist)
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

