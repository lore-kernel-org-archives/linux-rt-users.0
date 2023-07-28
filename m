Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B18EC001DE
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jul 2023 15:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjG1Pas (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjG1Paq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jul 2023 11:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05E1717
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jul 2023 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690558200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m5fEAiPouaQE9rxMgGljpc8HaqHE6X3ooLKaAxipMQg=;
        b=Th8x9oPfaG8jNZyC1kXPv9xAJGG3lRmtYqMxaxeGpCTYXJMVvT0ovYxp4J13Jzu47+PS4E
        9cJ8XmKyl8SHoGbZKcorIorGCANDI6vXyRFhMeELMFHtTTrwmi0t1n/y1EQVjzh8u6bsxV
        9vJwPJJY62RDX7Dkvi2mI75oifMKSRs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-R50APNsPNMOWdAg7Q-HJcQ-1; Fri, 28 Jul 2023 11:29:58 -0400
X-MC-Unique: R50APNsPNMOWdAg7Q-HJcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AFB38030AC
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jul 2023 15:29:58 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.11.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B9942166B25;
        Fri, 28 Jul 2023 15:29:58 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com,
        Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] cyclicdeadline: removed unnesessary text in usage message
Date:   Fri, 28 Jul 2023 11:29:55 -0400
Message-Id: <20230728152955.48977-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

removed unnesessary text in usage message
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index fbe3a75c60b8..4b4050fcbbb7 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -685,7 +685,6 @@ static void usage(int error)
 	       "-a [CPUSET] --affinity     Comma/hyphen separated list of CPUs to run deadline\n"
 	       "                           tasks on. An empty CPUSET runs on all CPUs a deadline\n"
 	       "                           task.\n"
-	       "                           on CPU 4, and thread #5 on CPU 5.\n"
 	       "-D TIME  --duration        Specify a length for the test run.\n"
 	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
 	       "                           days\n"
@@ -1234,7 +1233,7 @@ int main(int argc, char **argv)
 		percent = nr_cpus * 80 / nr_threads;
 	}
 
-	/* Set up the data while sill in SCHED_FIFO */
+	/* Set up the data while still in SCHED_FIFO */
 	for (i = 0; i < nr_threads; i++) {
 		sd = &sched_data[i];
 		/*
-- 
2.39.3

