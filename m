Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEFC25B0E
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Aug 2022 16:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiHPQUi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiHPQUR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Aug 2022 12:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A36154
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Aug 2022 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660666814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i39j09c6BNPejQJZcyInLy3m7+y9efxVFrnR+y/Au40=;
        b=SclkZlD3k+GWpxetbs5snnsC6Si/W9R9HgbdmxSlMzfdfTK5azVrCqu3krYsxiWA0hMnDz
        58rf2sMHKBv/OQ2m4iwEr7qGI5NA1A1iPDw/LdSg6+xsK9eNvMnSgGQtcVh4ErWiTcEEs3
        jM56bo3uHiJfVI+qD3HXNkdpfGj1EP4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-83VE_YbfPeeox7N_klRkhg-1; Tue, 16 Aug 2022 12:20:13 -0400
X-MC-Unique: 83VE_YbfPeeox7N_klRkhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E973381494D
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Aug 2022 16:20:13 +0000 (UTC)
Received: from lleshchi.bos.com (unknown [10.22.18.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 068B72026D4C;
        Tue, 16 Aug 2022 16:20:12 +0000 (UTC)
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v3] rteval: Add measurement and load location to run report
Date:   Tue, 16 Aug 2022 12:20:11 -0400
Message-Id: <20220816162011.606213-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
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
index 2c2105efa964..2f7f1d4356ae 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -30,6 +30,7 @@ import libxml2
 from rteval.Log import Log
 from rteval.rtevalConfig import rtevalCfgSection
 from rteval.modules import RtEvalModules, rtevalModulePrototype
+from rteval.systopology import collapse_cpulist, CpuList, SysTopology as SysTop
 
 class LoadThread(rtevalModulePrototype):
     def __init__(self, name, config, logger=None):
@@ -131,6 +132,13 @@ class LoadModules(RtEvalModules):
     def MakeReport(self):
         rep_n = RtEvalModules.MakeReport(self)
         rep_n.newProp("load_average", str(self.GetLoadAvg()))
+        rep_n.newProp("loads", str(self.ModulesLoaded()))
+        cpulist = self._cfg.GetSection(self._module_config).cpulist
+        if cpulist:
+            cpulist = CpuList(cpulist).cpulist
+        else:
+            cpulist = SysTop().online_cpus()
+        rep_n.newProp("loadcpus", collapse_cpulist(cpulist))
 
         return rep_n
 
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 318248bd7e35..90e1839333bb 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -24,7 +24,7 @@
 
 import libxml2
 from rteval.modules import RtEvalModules, ModuleContainer
-
+from rteval.systopology import collapse_cpulist, CpuList, SysTopology as SysTop
 
 class MeasurementProfile(RtEvalModules):
     """Keeps and controls all the measurement modules with the same measurement profile"""
@@ -189,6 +189,13 @@ measurement profiles, based on their characteristics"""
 
         # Get the reports from all meaurement modules in all measurement profiles
         rep_n = libxml2.newNode("Measurements")
+        cpulist = self.__cfg.GetSection("measurement").cpulist
+        if cpulist:
+            cpulist = CpuList(cpulist).cpulist
+        else:
+            cpulist = SysTop().online_cpus()
+        rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
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

