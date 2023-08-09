Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BC5C001DE
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjHITSY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHITSY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD54200
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2AC1fUgQW+Us4rnKHEfGpyn8nJ0V5mqOqoeFs9llcf8=;
        b=ELU7YQ4183eSaozQW/sv7Fqmr5RGQUhzG/zSO+NJP3tKgEkPPQ/He8+NonFlDjlfANnmIi
        p4Xs5QgI/FrsqzUIHg9dmraaUeVpvetNPR3xww4/54adF6Pv+iQZyE8py8Cy9YpMQZSzst
        /wKkgRPnUp7OrqUoKiCPG2q1KGku7lw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-1WfYVhBRMv-540OdSfctxQ-1; Wed, 09 Aug 2023 15:16:20 -0400
X-MC-Unique: 1WfYVhBRMv-540OdSfctxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5682E185A78F
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:20 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7265E40BC780;
        Wed,  9 Aug 2023 19:16:19 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 13/86] rteval: Add SPDX-License-Identifier tag to delta-1.3_1.4.sql
Date:   Wed,  9 Aug 2023 21:14:35 +0200
Message-Id: <20230809191548.359938-14-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the SPDX-License-Identifier tag to delta-1.3_1.4.sql.

As this file does not contain direct license references it falls under the project license, i.e., GPL v2 or later.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/sql/delta-1.3_1.4.sql | 1 +
 1 file changed, 1 insertion(+)

diff --git a/server/sql/delta-1.3_1.4.sql b/server/sql/delta-1.3_1.4.sql
index bfa4152..e0c0162 100644
--- a/server/sql/delta-1.3_1.4.sql
+++ b/server/sql/delta-1.3_1.4.sql
@@ -1,3 +1,4 @@
+-- SPDX-License-Identifier: GPL-2.0-or-later
 -- SQL delta update from rteval-1.3.sql to rteval-1.4.sql
 
 UPDATE rteval_info SET value = '1.4' WHERE key = 'sql_schema_ver';
-- 
2.39.3

