Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4D7C0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjHITYV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHITYH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190834226
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NY0Dr+reKtAnYa3Sh9KQI35fSAbEyqdkqVowlWl1GQY=;
        b=DZ3lHO40Fc8srKFPoM0zxg3KePAuu+NNGOKZKQFYDlAZ2N4foa4WSUUHLmtoG91fauT9Kh
        l0zcJWht2fGvFlnzGWrBTeDOwBZrxMfm393bkOWNJHwIXU5nOVXnaAxF84KcwKvwACAwQi
        3qQ2Qdmue1lz+3VLzNaHitfAqM5+8hw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-9XqpShH3MiORtRZxK1rkUQ-1; Wed, 09 Aug 2023 15:16:24 -0400
X-MC-Unique: 9XqpShH3MiORtRZxK1rkUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 174F728EA6F5
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:24 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 201BE40C125C;
        Wed,  9 Aug 2023 19:16:22 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 16/86] rteval: Add SPDX-License-Identifier tag to rteval-1.1.sql
Date:   Wed,  9 Aug 2023 21:14:38 +0200
Message-Id: <20230809191548.359938-17-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the SPDX-License-Identifier tag to rteval-1.1.sql.

As this file does not contain direct license references it falls under the project license, i.e., GPL v2 or later.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/sql/rteval-1.1.sql | 1 +
 1 file changed, 1 insertion(+)

diff --git a/server/sql/rteval-1.1.sql b/server/sql/rteval-1.1.sql
index 3977568..6ec783f 100644
--- a/server/sql/rteval-1.1.sql
+++ b/server/sql/rteval-1.1.sql
@@ -1,3 +1,4 @@
+-- SPDX-License-Identifier: GPL-2.0-or-later
 -- Create rteval database users
 --
 CREATE USER rtevxmlrpc NOSUPERUSER ENCRYPTED PASSWORD 'rtevaldb';
-- 
2.39.3

