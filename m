Return-Path: <SRS0=gFqs=B7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AE5C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BDF20FC3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598039252;
	bh=gFqOD0U26drtgdxA4LsBWsBNukOx3mLYjKZya5hw0rA=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=VdXucXMv7y+49+aVRhMwDdeu6P+oxcAAfbLdzlMrtf+I5XDe9rEycZeRulcHsaR2O
	 VuMJp1cZxxSN3p0kbATtNg0rou0exHjNhPbfofwNFeimbXC5kIRcGiGGgEfYDFFdib
	 xM/MB/+urOx32qshaat3yCEvT8WLRVAqzw8jwyzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHUTrQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgHUTrN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Aug 2020 15:47:13 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54AE220838;
        Fri, 21 Aug 2020 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598039232;
        bh=gFqOD0U26drtgdxA4LsBWsBNukOx3mLYjKZya5hw0rA=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VGR1w4uxwraxff6F0/nbGvFcCAvg9FdrR87htSQH3T3ziqKQHdyYGYrsytbZXgG3U
         DsqMm+HQDPxSngqOmwPvrcGWMkoeCOHfyPox5OTKXYQ0xkfqBwav7HyPaG+v8YQSMi
         ZwzJg0KTjhSiXSCyNpNLRJ5QoO2ZBLNw5CfA3UQE=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 5/5] Linux 4.19.135-rt61-rc1
Date:   Fri, 21 Aug 2020 14:47:04 -0500
Message-Id: <d975f7e45b5787e2d45fcf0fa654304c85cdba2b.1598039186.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.19.135-rt61-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 66fa05e70f29..c04074665349 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt60
+-rt61-rc1
-- 
2.17.1

