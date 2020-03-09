Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F110C10F27
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C0524680
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583783319;
	bh=jk7Pvpx0sd6QCQwzSvQUmXSsA5DYpbI+9cKslUmsgnw=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=Mk4cVF8AfQDd88PBdpEqz+aHT/lMfsDs6m2lfwzP9o6dDaz643MqvU40utwEvp4TI
	 GRUPqR/vVOQXsWysbcLfhu0BDoodObGj5JLNr/kixaWcoMLPCCoJBgU5q8waljVlPJ
	 UFwtJiL9Ey8OAb3tyGSET18ZeIXfX4eWMi3SffOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCITsU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCITsU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:20 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A6424673;
        Mon,  9 Mar 2020 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783299;
        bh=jk7Pvpx0sd6QCQwzSvQUmXSsA5DYpbI+9cKslUmsgnw=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EjSwCduPsfpPDGQ3IJIy1A7IYqdC8nbDqNFqAkmf6lqW7iS4EBhtXArFa0zWAQ+q1
         aajLPPBZa9wqSMVf7iEC8mzEsESrQ193C0yfA2OLeo4jrO+6J7ItGt1y67n0UhiwLw
         V8hKBvAKiRXSCrIuslcUpY7U4gR0W127sKUl01MY=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 5/8] locallock: Include header for the `current' macro
Date:   Mon,  9 Mar 2020 14:47:50 -0500
Message-Id: <ac7f08d313acd30e95a4876056fdf62c5654c407.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.172-rt78-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit e693075a5fd852043fa8d2b0467e078d9e5cb782 ]

Include the header for `current' macro so that
CONFIG_KERNEL_HEADER_TEST=y passes.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/locallock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 921eab83cd34a..81c89d87723b5 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -3,6 +3,7 @@
 
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
+#include <asm/current.h>
 
 #ifdef CONFIG_PREEMPT_RT_BASE
 
-- 
2.14.1

