Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42390C4320A
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F00760F91
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhH0WD4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhH0WDz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:55 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E22C0613D9
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 14so8805024qkc.4
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXgAw+XZkbWOQ6JL8OQXW4OO64PB0CTwsJDhWmw/2t0=;
        b=RswUniWVzeqRFhpNH/+jW47xS27yBmsx1t6zIlvOWNKGYpjQcC0Xz8pL2pGn1kziVd
         LILyMmjzsZze8ZrVdKUHMf63WgU3d6MZG+IUcaEhvK4hrlqJqhu6QYVEKBHHq7AGYLvW
         q5SHCXVOU9VTEaZrY03x4tRZFwzW71jo5nItQdULuGUfyTHuSq5t3DoON3YFJ1/6a/0B
         g7R46TsSXDqWPDd2FueGXKK5FKg/sIDDPvxlTvzYf8XOaJi3eRwbwL9F8OXIktNuGfj6
         6VqQRPmwKokJqbRqzezY/B+oqwGhoZgOfLuKrOqMA9VO8HeYBksHnZcygBEFSo89zQHk
         xGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wXgAw+XZkbWOQ6JL8OQXW4OO64PB0CTwsJDhWmw/2t0=;
        b=Ppxe5zJ0qdTJLvUXnppvJV9yuTWI0hj+aMox5iPdKtH91zgNxxdk0Z+RrA7O+MelkE
         GBd7YrPYFI4yzW+u0xwbuZoWD2Ccknk4p/cgbwoEEX3LI7ozcuIiCDSXmIVcRJbwR3n7
         pHbj53ECFspBd0CIIOMiggKlqm3rVd7eq9TYeo1TMS9rMfyGgDkI7oA7lWTNWYJ8L5av
         f4euSmqVOrwhczATfeiabXsSLvpY+vR2uVLON2dA1kWy0q2U8YG7+3i7pvNs0DJW2gNA
         h4YpoByXyZCPj/J4ajtgRiEfmO2UlNfBLWe7EDsLPkKOduZHva4TqFlUhs0Xj5BB+Tn5
         vgEw==
X-Gm-Message-State: AOAM531rOFnix/fN9tLwihtg2ZYVmyZdkKrudQ/d1ZDru0gVB/xjcniB
        tokQv0pZC0XzG6MpmQfmshfCJL5AcqO5jg==
X-Google-Smtp-Source: ABdhPJyGoroxzvC9j+WcZFRkj4HZyA2JZzbd1UOqduddKn6E3YSZIfcvAuUBQPW45nqlidYKaWyIFg==
X-Received: by 2002:a05:620a:290d:: with SMTP id m13mr2878792qkp.426.1630101785112;
        Fri, 27 Aug 2021 15:03:05 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/8] rt-tests: pi_stress: Add missing parameter and fix types
Date:   Fri, 27 Aug 2021 18:02:42 -0400
Message-Id: <20210827220244.24210-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827220244.24210-1-jkacur@redhat.com>
References: <20210827220244.24210-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add missing parameter in message and correct type.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 3888198f395b..9f4ffa49e926 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -668,7 +668,7 @@ void *low_priority(void *arg)
 		}
 
 		/* initial state */
-		pi_debug("low_priority[%d]: entering start wait (%d)\n", p->id,
+		pi_debug("low_priority[%d]: entering start wait (%ld)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -796,7 +796,7 @@ void *med_priority(void *arg)
 		}
 
 		/* start state */
-		pi_debug("med_priority[%d]: entering start state (%d)\n", p->id,
+		pi_debug("med_priority[%d]: entering start state (%ld)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -949,8 +949,7 @@ void *high_priority(void *arg)
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			pi_error
-			    ("high_priority[%d]: pthread_barrier_wait(finish): %x",
-			     status);
+			    ("high_priority[%d]: pthread_barrier_wait(finish): %x", p->id, status);
 			return NULL;
 		}
 		/* update the group stats */
-- 
2.31.1

