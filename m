Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B78EB64DA
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjF1Twp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124]:46634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231340AbjF1Twk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 15:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687981910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QdblTJptRPmkAHzRXJCpZwSX2GSzZyea2sWXWtATT9g=;
        b=XvsoTtTaHYwsOJCLzMMAfYdsE+70RQXy2o8LG6PfSApjPfI6HxWX1SuJfXCOzQKUdSiA/3
        s/SbO161LuU++X0KxbfAzn2CIN8QVXPmjC5WmxaQIYfPh6EILaJWNekNrfGDXiyL7qVEKH
        jbYmWy75KlO/cvq70a3pB/lnDUspSqc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-tsw6LAEDMhax-W8PbJ9hOg-1; Wed, 28 Jun 2023 15:51:48 -0400
X-MC-Unique: tsw6LAEDMhax-W8PbJ9hOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B17BE8E4680
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 19:51:47 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 909ABF5CDF;
        Wed, 28 Jun 2023 19:51:47 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 0/3] Updates for converting optparse to argparse in
Date:   Wed, 28 Jun 2023 15:51:42 -0400
Message-Id: <20230628195145.636652-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

These commits can be pulled from the "argparse" branch in
https://github.com/AnubhavS1/rteval. 

Anubhav Shelat (3):
  rteval: added code to download default kernel version if no version is
    specified
  rteval: fixed comments
  rteval/server: edited files to use optparse instead of argparse

 rteval-cmd                       | 12 ++++++++++--
 rteval/modules/__init__.py       |  4 ++--
 rteval/rtevalConfig.py           |  2 +-
 server/remove_rtevalrun          | 16 ++++++++--------
 server/rteval_testserver.py      |  1 -
 server/testclient_sendreportfile | 10 +++++-----
 6 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.39.3

