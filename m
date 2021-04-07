Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CBAC433B4
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B2461369
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 18:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355417AbhDGSsx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355411AbhDGSss (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Apr 2021 14:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39CAE61246;
        Wed,  7 Apr 2021 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617821318;
        bh=w3Pc1s+0Z4zxUfBQzlDJZYxBwkEHPt26/nhiCTN8tI4=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=o8HSUXwIsztDpIiQvU81tnntO4SXW8lNCd/PVx/QzC3C1zhHLA9lWNFqj9EPvIM0Z
         VxSK94R9J40GvRHgNJ8+5sh2N2itXLDeojq+m5DIfxrCLusLcLuHq0OnSNyvhYLti5
         g0MM3aTmZCVL5/+krZNt8DV3fQsi4hM1HF8meoNYprAUMsK+MshL+41t4OFSEDg8VZ
         VdqyWMs/KJ+gFvKhC7cUgGpLudBNRzVdVmpU3tqAUT6Wk8T0aVOw4Gori5NpcWtnoB
         h0OvJFKbE8dBYkfiMeyYJEy+fUtzuSMn7vEZAQfxZxESUUFLDiH5T4tZ+zBYNud1JO
         65nB0AGuAumwA==
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
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 2/2] Linux 5.4.109-rt56-rc1
Date:   Wed,  7 Apr 2021 13:48:33 -0500
Message-Id: <30c2ef9db0f19b0883f950000819940e3b178487.1617821301.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617821301.git.zanussi@kernel.org>
References: <cover.1617821301.git.zanussi@kernel.org>
In-Reply-To: <cover.1617821301.git.zanussi@kernel.org>
References: <cover.1617821301.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v5.4.109-rt56-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 51b05e9abe6f..a6adf38a57d4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt55
+-rt56-rc1
-- 
2.17.1

