Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABDBC00528
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jul 2023 14:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjGZOtY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjGZOtU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jul 2023 10:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F531FEC
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ziCQqqL5AQbiXGZ21dn7uHF30z6eIldDTDokq8Z9O8g=;
        b=EAmclUmHv9kKmv9aoFqNGcmc0RGPUFneB+3zjtDYRJ3bWsx1wceBuMukJ04Y9r6jj1BWd7
        +/8Z1irCQucqtxzi60u548En0UES7ZK2U1yUVrBSbH2iedmhFdI1nLrAJ8ZWyke73E30fm
        a6tDRueNw3V9MZN8lAVqQmJdiU4nzbs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-Zqn5RjV3PzujXDehr8sCjg-1; Wed, 26 Jul 2023 10:48:30 -0400
X-MC-Unique: Zqn5RjV3PzujXDehr8sCjg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8FDE10504AD
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 14:48:29 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E9854094DC0;
        Wed, 26 Jul 2023 14:48:29 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 2/5] setup: Added SPDX licence
Date:   Wed, 26 Jul 2023 10:48:23 -0400
Message-Id: <20230726144826.355643-3-ashelat@redhat.com>
In-Reply-To: <20230726144826.355643-1-ashelat@redhat.com>
References: <20230726144826.355643-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

setup: Added SPDX licence
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 setup.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.py b/setup.py
index 0ee543487c31..060f903dcb0c 100755
--- a/setup.py
+++ b/setup.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/usr/bin/python3
 import os
 from os.path import isfile, join
-- 
2.39.3

