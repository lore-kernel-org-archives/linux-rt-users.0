Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E091BC001DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Aug 2023 09:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjHKJx3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 05:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjHKJx1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Aug 2023 05:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FECA272D
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Aug 2023 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691747564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zE9rv0HA/KBTKXYuphjpvmuQ1ww4xnPNMvMexqXWeSs=;
        b=cyWDh4JDcXWkSJLg0kI52ueak0mWT/I6qW6S72ewwOEpcRH6BPqMmtlgxtFQGkEWEvZIVz
        MLQXs3C7X6Ss4YuIHXBIrhfdaJKwBeNr6JBMhyVqb70jiC6nUxAlwv91asavXoG1oj7u5K
        0Z/pZDOXZ8c7EoDdE/DrA+S66fcBHCM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-QRgyD_55PbOGM1WagSHB0Q-1; Fri, 11 Aug 2023 05:52:42 -0400
X-MC-Unique: QRgyD_55PbOGM1WagSHB0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 982463801F71
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Aug 2023 09:52:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF8FF2026D4B;
        Fri, 11 Aug 2023 09:52:41 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 0/3] rteval: Add cmdline option to run measurements on isolcpus by default
Date:   Fri, 11 Aug 2023 11:52:25 +0200
Message-ID: <20230811095228.200772-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A common usecase for rteval is estimating the performance of workloads
running on isolated CPUs. rteval does not run measurement on isolated CPUs by
default (i.e. without --measurement-cpulist specified).

Add option --measurement-run-on-isolcpus that adds isolated CPUs to the default
cpulist together with rteval.conf [measurement] option run-on-isolcpus with
the same effect.

v2: Fixed error in rteval/modules/measurement/__init__.py that broke rteval when
run-on-isolcpus not present in rteval.conf.

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

