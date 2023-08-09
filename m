Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85169C001DE
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjHITSk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjHITSj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697DE3ABD
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dE+fgBVCvy8rmjmzzir+PHF83UzcSButdWpSvSo6Drs=;
        b=FuUgwcO3uVfIzI+5ItvQDxKqHuLjQ5usmuucBPccWq0DLFvsfEOaqKXM653lBl8ox4DWSS
        t5m18oBHOj/Jmh/T07QvgcDgHXA4i6BDpyfMDfnNTlTezXetRp53j05UoTAHqhwKmPv17o
        zOfbJOYvYQC7+WbBUJyd+VkuYmu4pKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-7SvhMDJuMMO7NjRZs1uj7g-1; Wed, 09 Aug 2023 15:16:21 -0400
X-MC-Unique: 7SvhMDJuMMO7NjRZs1uj7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F86B185A791
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:21 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FC2040C6F4E;
        Wed,  9 Aug 2023 19:16:20 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 14/86] rteval: Add SPDX-License-Identifier tag to delta-1.4_1.5.sql
Date:   Wed,  9 Aug 2023 21:14:36 +0200
Message-Id: <20230809191548.359938-15-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the SPDX-License-Identifier tag to delta-1.4_1.5.sql.

As this file does not contain direct license references it falls under the project license, i.e., GPL v2 or later.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/sql/delta-1.4_1.5.sql | 1 +
 1 file changed, 1 insertion(+)

diff --git a/server/sql/delta-1.4_1.5.sql b/server/sql/delta-1.4_1.5.sql
index a190326..bd1336e 100644
--- a/server/sql/delta-1.4_1.5.sql
+++ b/server/sql/delta-1.4_1.5.sql
@@ -1,3 +1,4 @@
+-- SPDX-License-Identifier: GPL-2.0-or-later
 -- SQL delta update from rteval-1.4.sql to rteval-1.5.sql
 
 UPDATE rteval_info SET value = '1.5' WHERE key = 'sql_schema_ver';
-- 
2.39.3

