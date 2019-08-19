Return-Path: <SRS0=6kRx=WP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01EC3A59F
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 06:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033652086C
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 06:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfHSGnN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:43:13 -0400
Received: from mail.monom.org ([188.138.9.77]:33102 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfHSGnM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 02:43:12 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 3DA3B5007F3;
        Mon, 19 Aug 2019 08:43:11 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id 155CE5007D2;
        Mon, 19 Aug 2019 08:43:11 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH rt-tests v1 v1 4/4] deadline_test: Increase buffer to avoid overflow
Date:   Mon, 19 Aug 2019 08:43:04 +0200
Message-Id: <20190819064304.4676-5-wagi@monom.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819064304.4676-1-wagi@monom.org>
References: <20190819064304.4676-1-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Increase the size of the char buffer. gcc 9.1.1 reports:

src/sched_deadline/deadline_test.c:1803:24: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
 1803 |   sprintf(setcpu_buf, "%d", cpu_count - 1);
      |                        ^~
src/sched_deadline/deadline_test.c:1803:23: note: directive argument in the range [-2147483648, 2147483646]
 1803 |   sprintf(setcpu_buf, "%d", cpu_count - 1);
      |                       ^~~~
src/sched_deadline/deadline_test.c:1803:3: note: ‘sprintf’ output between 2 and 12 bytes into a destination of size 10
 1803 |   sprintf(setcpu_buf, "%d", cpu_count - 1);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/sched_deadline/deadline_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index e2898de328bb..5b5f40dbb74d 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -1795,7 +1795,7 @@ int main (int argc, char **argv)
 
 	/* -b has us bind to the last CPU. */
 	if (!all_cpus && !setcpu) {
-		setcpu_buf = malloc(10);
+		setcpu_buf = malloc(12);
 		if (!setcpu_buf) {
 			perror("malloc");
 			exit(-1);
-- 
2.21.0
