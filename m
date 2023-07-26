Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869FEC0015E
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jul 2023 08:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjGZIdc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjGZIcg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jul 2023 04:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F89549D3
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 01:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690359748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Foepon5LXKDoKtwDtPISEDa0IltaOMc6AW/oxukkyU=;
        b=JmpaisWqJmOEpDvqzLBKTxdRLSHtisarGC9D6d9ukFb2FOGAJ43ctyVNq8qDAZaIPo20bn
        Shp0iK1weyRX3Qe7IZVhrmuBD7IPhvF0YEr/0IsamE84Qe/hRXezc4c1Lh3iKW/wENveHr
        jN2j/guceclbDiZf7H0urksKyE+Tqkk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-t-I07g5XPWa2wi-NF--zmA-1; Wed, 26 Jul 2023 04:22:26 -0400
X-MC-Unique: t-I07g5XPWa2wi-NF--zmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B65E1066556
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 08:22:26 +0000 (UTC)
Received: from fedora.. (unknown [10.43.17.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF3A200B41D;
        Wed, 26 Jul 2023 08:22:25 +0000 (UTC)
From:   tglozar@redhat.com
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rteval: Add missing docstrings in SysTopology
Date:   Wed, 26 Jul 2023 10:22:12 +0200
Message-ID: <20230726082212.258414-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tomas Glozar <tglozar@redhat.com>

Add docstrings for isolated_cpus_str and default_cpus_str.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/systopology.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index 19443f9..a991e70 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -407,10 +407,12 @@ class SysTopology:
         return cpulist
 
     def isolated_cpus_str(self):
+        """ return a list of strings of numbers of all isolated cpus """
         cpulist = [str(cpu) for cpu in self.isolated_cpus()]
         return cpulist
 
     def default_cpus_str(self):
+        """ return a list of strings of numbers of all default schedulable cpus """
         cpulist = [str(cpu) for cpu in self.default_cpus()]
         return cpulist
 
-- 
2.39.3

