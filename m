Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0331EC4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiKKTxl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiKKTxj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:53:39 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061972D7
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:39 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id x15so3991452qvp.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0i1/G2Eeh0NKc0FvdpQoeYirSJMXWFtZW80hlb2MUw=;
        b=eayflIrakiM/5lneoWqspH/vx1S7r+SHJGNlXz5V6edyC4mfbpx4rdHHK0pWvIXH7v
         PzVeUcZPs4R1koZCtwWXu9lRQ/h6SN+zBab5PNKgUsWbW5VkOWpBherISKRumme3dyyb
         AWDlrCqn+Go7R0X30EFXkod0Otcbxl0Pljx4U10xw6ftv6E40DylCkhmao64Ddl7NY0e
         WykSSfijHcA7SIYDvOP3Ep2O3UAI2Eub5DP68X/74rsoBMOr46ZHrrhYb56eOBvgwgM0
         VL9VyY4EZTAvLxhK/d506xarKFErLuWYgla8fUeee8cNqCKUeoU4V2CUh/QsGMCAbH6N
         PeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0i1/G2Eeh0NKc0FvdpQoeYirSJMXWFtZW80hlb2MUw=;
        b=VlhJSqm5arD5VxFT+Gqo+BZtTE6tNcbcZBQBlldYt2ghHW+3xN2g6NJHdgEwdhJa2v
         W5iYY/4sLaE8ik67QNvBo9PyfORv3Z8z1MbiX6XUt2t8dQg5tv+oibDwocwEzaLDmj3C
         5k0ygKE8sg7JHonhM5ZLa83IhMUYAlEE4BsVJU+Ow6i6QrQhn5tO+pTPK3hBJ/Ww+aV5
         AQTYNsu5xlfgI7En/5Cf+DkaMpUm7DDLH03PNAjS4PhGuJLZ7AgEclWDPLtPN9xMXnp5
         tYGxSMSTO/h2JxXbTxS8TXIkrOSVm/qVMlYUPUfNoVJwfQoaVAWx7M/kLpZLFioUR8FZ
         JWmg==
X-Gm-Message-State: ANoB5pnvC1Bvs5Y/JebskxpZyv2FNODU9cvrTzZJJWwfVKz/BkEkKp8f
        rNgHTCzI6FtDtckacFkaJLWEVh0nLxI=
X-Google-Smtp-Source: AA0mqf7LNfzFG8eurXuMoDFtStAocjd7u7rCjrZdM2mXHq+4VQoHJjgSIP/7ukS9+MDlGvbtMfW3uQ==
X-Received: by 2002:a0c:904b:0:b0:4bc:16b3:6a85 with SMTP id o69-20020a0c904b000000b004bc16b36a85mr3206680qvo.129.1668196417463;
        Fri, 11 Nov 2022 11:53:37 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id i17-20020ac85c11000000b00397e97baa96sm1794332qti.0.2022.11.11.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:53:36 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/8] rt-tests: hackbench: Fix compile comparison of different signed ints
Date:   Fri, 11 Nov 2022 14:53:18 -0500
Message-Id: <20221111195323.27402-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111195323.27402-1-jkacur@redhat.com>
References: <20221111195323.27402-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix compile warnings about comparisons of integers of different
signedness.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hackbench/hackbench.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 8c6d83520e57..dda7690b79a0 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -200,7 +200,8 @@ static void *sender(struct sender_context *ctx)
 	/* Now pump to every receiver. */
 	for (i = 0; i < loops; i++) {
 		for (j = 0; j < ctx->num_fds; j++) {
-			int ret, done = 0;
+			int ret;
+			size_t done = 0;
 
 again:
 			ret = write(ctx->out_fds[j], data + done, sizeof(data)-done);
@@ -231,7 +232,8 @@ static void *receiver(struct receiver_context* ctx)
 	/* Receive them all */
 	for (i = 0; i < ctx->num_packets; i++) {
 		char data[datasize];
-		int ret, done = 0;
+		int ret;
+		size_t done = 0;
 
 again:
 		ret = read(ctx->in_fds[0], data + done, datasize - done);
@@ -289,7 +291,7 @@ static int create_worker(childinfo_t *child, void *ctx, void *(*func)(void *))
 
 void signal_workers(childinfo_t *children, unsigned int num_children)
 {
-	int i;
+	unsigned int i;
 	printf("signaling %d worker threads to terminate\n", num_children);
 	for (i=0; i < num_children; i++) {
 		kill(children[i].pid, SIGTERM);
@@ -517,7 +519,7 @@ int main(int argc, char *argv[])
 	if (setjmp(jmpbuf) == 0) {
 		total_children = 0;
 		for (i = 0; i < num_groups; i++) {
-			int c = group(child_tab, total_children, num_fds, readyfds[1], wakefds[0]);
+			unsigned int c = group(child_tab, total_children, num_fds, readyfds[1], wakefds[0]);
 			if( c != (num_fds*2) ) {
 				fprintf(stderr, "%i children started.  Expected %i\n", c, num_fds*2);
 				reap_workers(child_tab, total_children + c, 1);
-- 
2.38.1

