Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12357EB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 09:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjF3JXG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjF3JWu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B403596
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688116841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KC6zfdFi9pUi2JSY8bcPZesV3mdmP8ItoD16DWromLI=;
        b=FhUT2DEF7ZG1DG9rz33ZxqI4Ary0nqfnlvKsWSWdXZLTOMEW8Hqh7mR2b1Ak5NFRq2E1kA
        V0EtdHSlTRY9UlH8pNo30Wl/aB+tRFMoa71QxyWn74zQqlOZm/61AQMoMqdJQz7CZ/hSy7
        br9lQOcSWSnMZfk7nSnf/0g/5N4tN1g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-f_GOVp1wOYSPY41XApsdRg-1; Fri, 30 Jun 2023 05:20:39 -0400
X-MC-Unique: f_GOVp1wOYSPY41XApsdRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D37381D9EC
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 09:20:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 016F840C6F5A;
        Fri, 30 Jun 2023 09:20:37 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/6] rteval: Exclude isolcpus from loads report
Date:   Fri, 30 Jun 2023 11:19:07 +0200
Message-ID: <20230630091951.916865-7-tglozar@redhat.com>
In-Reply-To: <20230630091951.916865-1-tglozar@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use SysTopology.default_cpus() to report cores on which measurements and
loads and run by default to reflect the default behavior (no isolcpus).

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/loads/__init__.py       | 2 +-
 rteval/modules/measurement/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
index 761cc8c..74aad58 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -138,7 +138,7 @@ class LoadModules(RtEvalModules):
             # Convert str to list and remove offline cpus
             cpulist = CpuList(cpulist).cpulist
         else:
-            cpulist = SysTop().online_cpus()
+            cpulist = SysTop().default_cpus()
         rep_n.newProp("loadcpus", collapse_cpulist(cpulist))
 
         return rep_n
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index d99873e..0e395be 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -194,7 +194,7 @@ measurement profiles, based on their characteristics"""
             # Convert str to list and remove offline cpus
             cpulist = CpuList(cpulist).cpulist
         else:
-            cpulist = SysTop().online_cpus()
+            cpulist = SysTop().default_cpus()
         rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
 
         for mp in self.__measureprofiles:
-- 
2.41.0

