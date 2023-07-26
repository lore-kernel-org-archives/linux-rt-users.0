Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE53C001DC
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jul 2023 14:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjGZOtV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjGZOtU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jul 2023 10:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD0219A0
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vU2T5jvHCpq/e7RWM7WfEXHusi8y0fk66XWaJi5dBxQ=;
        b=Pb92VRU40nNgh9n+Omx5qdRZQe3qOwuHNiW0+BifWLOCbbnlKA/hztV73oiErjNVvb6SQp
        otCQUNUfkk1uFjoMWPPo2GcFPHh9EwW6HnHv+mVP1WcqHF1fwPfJ/+XemlzJtJHJngMFyP
        LMY43vC8f5OgIBqrGLByPIcB4T9/hbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-jAt8GQjJPAae6R-p6aEBSQ-1; Wed, 26 Jul 2023 10:48:29 -0400
X-MC-Unique: jAt8GQjJPAae6R-p6aEBSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 313B3800888
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 14:48:29 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 067764094DC0;
        Wed, 26 Jul 2023 14:48:28 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 0/5] Cover letter
Date:   Wed, 26 Jul 2023 10:48:21 -0400
Message-Id: <20230726144826.355643-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Added SPDX licence to python files in python-linux-procfs

Anubhav Shelat (5):
  bitmasklist_test: Added SPDX licence
  setup: Added SPDX licence
  __init__: Added SPDX licence
  procfs: Added SPDX licence
  utilist: Added SPDX licence

 bitmasklist_test.py |  1 +
 procfs/__init__.py  | 16 +---------------
 procfs/procfs.py    | 14 +-------------
 procfs/utilist.py   | 14 +-------------
 setup.py            |  1 +
 5 files changed, 5 insertions(+), 41 deletions(-)

-- 
2.39.3

