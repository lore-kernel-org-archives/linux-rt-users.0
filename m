Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835FC43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7EE214DA
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556824579;
	bh=LhNYXfe4zOWYZBa7odxryiZv0JhrJtxrhhNF3bcbJmI=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=wdVJFva1WC9wkRVUv7j8U0f05PzBSeNmFKRYj3FEhk7Ly4LB8IDgqdErcWq8mPOzV
	 tgqLAXT0hfeZNgj28hViMr+G8dTRNqSgAwT3S7M/FXBK7gHlk3dFJEXr+rFNaz8UZD
	 kWiL2Sf/wzjntAKMZcbtW4BCMFZ7luo24g6dy7VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEBTQO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEBTQG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:16:06 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0CB20C01;
        Thu,  2 May 2019 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556824565;
        bh=LhNYXfe4zOWYZBa7odxryiZv0JhrJtxrhhNF3bcbJmI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HdSIomsOrR/YtQFu+YTpB7UcZSQN5CYN3OcSihyyUXNpg8dI717D1vJRO41/aiWaO
         EEoHmFPwBOf2pdu1LzzREfvG7DK9DQi1PPl4BZUHsf1KhR5ak4JZdScXSHR1d66+il
         ZmRiOMSjNfvpOtrquZ9aWUqwenB4/lJG/TPJo2lI=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 4/4] Linux 3.18.138-rt116-rc1
Date:   Thu,  2 May 2019 14:15:39 -0500
Message-Id: <f0b31190556bc9dee60350acef811af6dda34c70.1556824516.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

v3.18.138-rt116-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index f2aa035883e8..7cd9a55e8702 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt115
+-rt116-rc1
-- 
2.14.1

