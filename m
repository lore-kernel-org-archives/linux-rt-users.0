Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4776CC001E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Aug 2023 06:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbjHPG6q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Aug 2023 02:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242223AbjHPG6d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Aug 2023 02:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D601FC7
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Aug 2023 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692169071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MrvngQBbFE1c0Hh7ZgNXeBqnlL0aLXn38H8xSna1pQM=;
        b=SdSbZdKo946EhzM4nEdWj6WmS7uLjommJHZ3sUQP7oaTAA3bdhLNTkjmUnJcFIiIhArKRo
        d0YPphEMtXrmtKNUE9Y4iZuRflScgpYb7qoocn1k8R/Oe9VfzhKcHbWPNGsfwvgivoNAaK
        CK4DfqpdwvDVqCncy8T8q8gtDpgEnnU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-Vo6JI0a4PUOHzhExFYWv_w-1; Wed, 16 Aug 2023 02:57:48 -0400
X-MC-Unique: Vo6JI0a4PUOHzhExFYWv_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21B3F80006E
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Aug 2023 06:57:47 +0000 (UTC)
Received: from fedora.. (unknown [10.43.17.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 860D640C207A;
        Wed, 16 Aug 2023 06:57:46 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/2] rteval: Default to higher cyclictest bucket count on non-RT kernels
Date:   Wed, 16 Aug 2023 08:57:38 +0200
Message-ID: <20230816065740.283407-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When running rteval on non-RT systems, the default number of cyclictest
buckets is not enough to get useful statistics out of it.

To make testing of rteval easier on such systems, this patchset
proposes to set the default value of --cyclictest-buckets to 50000
when a non-RT kernel is detected.

This is a value that should, at least when tested on my machine,
not overflow in a typical run on a non-RT kernel.

Tomas Glozar (2):
  rteval: Support custom argument default value help
  rteval: Set higher cyclictest bucket count on non-RT kernels

 rteval/modules/__init__.py               | 3 ++-
 rteval/modules/measurement/cyclictest.py | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.41.0

