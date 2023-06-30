Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B176EB64DA
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 09:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjF3JWp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjF3JWL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7335AC
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688116835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tRUqNTYssrfrME3hSrSBfQvAN/7TVYWHu229+gTIvDY=;
        b=fLkp8tox/qJxsD/apmIH72G2T9p4mz2OaC+6NC+5yO+78B+3VH1rCIVixeQd0mpvdpQlaH
        ZOV+u6DtwXPCvaJKI9O6MHog8AC2ALFo56PQ+ZS9IN4NiyRIFwuof8OaVXbPcAz8kbkQMC
        I8FFmgeIX9H3AmS3pmwITSTkP58xKZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-AMCz_1gGNSWqFdQvq0CzSg-1; Fri, 30 Jun 2023 05:20:33 -0400
X-MC-Unique: AMCz_1gGNSWqFdQvq0CzSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BD931044589
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 09:20:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF4F40C6CCD;
        Fri, 30 Jun 2023 09:20:32 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/6] rteval: Handle isolcpus correctly
Date:   Fri, 30 Jun 2023 11:19:01 +0200
Message-ID: <20230630091951.916865-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is a patch set that enables rteval to do load calculations and reporting
correctly on systems with isolated CPUs.

Tomas Glozar (6):
  rteval: Detect isolcpus in systopology
  rteval: Report isolated CPUs
  rteval: Exclude isolcpus from kcompile by default
  rteval: Exclude isolcpus from stressng by default
  rteval: Fix CPU count calculation for hackbench
  rteval: Exclude isolcpus from loads report

 rteval/modules/loads/__init__.py       |  2 +-
 rteval/modules/loads/hackbench.py      |  6 +++-
 rteval/modules/loads/kcompile.py       |  8 +++--
 rteval/modules/loads/stressng.py       |  5 +++
 rteval/modules/measurement/__init__.py |  2 +-
 rteval/rteval_text.xsl                 |  4 +++
 rteval/sysinfo/cputopology.py          | 11 +++++++
 rteval/systopology.py                  | 43 ++++++++++++++++++++++++++
 8 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.41.0

