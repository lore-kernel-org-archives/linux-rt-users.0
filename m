Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA9CC001DE
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Aug 2023 09:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHJJCS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHJJCR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Aug 2023 05:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B62115
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691658089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G7DsU+JM1+qVisOKCfMjCLMQ1ZKWjJFBR+4H3UcrSYM=;
        b=B1cEyUAuFtc/LrUbePbS7KO9zyWRZ/4LpilFSC9/feuYpm/x8X241bo7+ugvnYK6a4Mt0g
        Oj1J+1OcFtSUGvdlKlvivI0d9hFeam4iIW4YdgSa5mdHFf0d1PQZ6azXAOHw+enlChfWt4
        lKwPLNyB3zQoOrj/tt8YqdWTZAtygz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-677-Gmnlb7ppOoOqCu6sHDXDkw-1; Thu, 10 Aug 2023 05:01:28 -0400
X-MC-Unique: Gmnlb7ppOoOqCu6sHDXDkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EACF85C6E2
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 09:01:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93FC2401E6A;
        Thu, 10 Aug 2023 09:01:27 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/3] rteval: Add cmdline option to run measurements on isolcpus by default
Date:   Thu, 10 Aug 2023 11:01:20 +0200
Message-ID: <20230810090123.151924-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A common usecase for rteval is estimating the performance of workloads
running on isolated CPUs. rteval does not run measurement on isolated CPUs by
default (i.e. without --measurement-cpulist specified).

Add option --measurement-run-on-isolcpus that adds isolated CPUs to the default
cpulist together with rteval.conf [measurement] option run-on-isolcpus with
the same effect.

Tomas Glozar (3):
  rteval: Allow arguments specific to module group
  rteval: Add run_on_isolcpus option to measurements
  rteval: Support run-on-isolcpus in cyclictest

 rteval/modules/__init__.py               | 18 ++++++++++--------
 rteval/modules/measurement/__init__.py   | 17 ++++++++++++++---
 rteval/modules/measurement/cyclictest.py | 12 ++++++++++--
 3 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.41.0

