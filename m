Return-Path: <SRS0=rES8=BA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F9C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jul 2020 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A13620658
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jul 2020 21:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMYj8scF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgGUVK1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:10:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53283 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728606AbgGUVK1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Jul 2020 17:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595365826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=06s0uynvCjRAzVCgEnLM2UzKulG/ROS2u9fES0UHDO4=;
        b=JMYj8scFUi/Bez5coinC8CVuInyubganpTJ+MRg5PYlUdbl1qa9pOtT0Lg59RBbKs9FXHx
        ksnmq3sFANFGyW0NCJ24egn4S/PtXQtf9GWXrB+Ot9lmomQ8dgWIo4ecm6qj0TODENTX4w
        JfxIGAjrjnUPzRSxAxsFu2KNNX6iAtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Ak0ZEojrPGKaoWzC0o6tsg-1; Tue, 21 Jul 2020 17:10:24 -0400
X-MC-Unique: Ak0ZEojrPGKaoWzC0o6tsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FFF9800597
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Jul 2020 21:10:23 +0000 (UTC)
Received: from tagon.redhat.com (ovpn-116-3.rdu2.redhat.com [10.10.116.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DD6E60E1C;
        Tue, 21 Jul 2020 21:10:23 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH] pi_stress: limit the number of inversion groups to the number of online cores
Date:   Tue, 21 Jul 2020 16:10:22 -0500
Message-Id: <20200721211022.734344-1-williams@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Each inversion group is three SCHED_FIFO threads, so the chances of more groups
than online cores actually getting to run is very slim. Limit the number of
groups requested to be <= the number of online cpus.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/pi_tests/pi_stress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 0ed844c636cd..ce446d4ea037 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1327,6 +1327,12 @@ void process_command_line(int argc, char **argv)
 			break;
 		case 'g':
 			ngroups = strtol(optarg, NULL, 10);
+			if (ngroups > num_processors) {
+				pi_error("the number of groups cannot exceed "
+					 "the number of online processors (%d)\n",
+					 num_processors);
+				exit(-1);
+			}
 			pi_info("number of groups set to %d\n", ngroups);
 			break;
 		case 'r':
-- 
2.26.2

