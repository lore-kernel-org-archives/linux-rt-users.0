Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8BEC10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A09920879
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750902;
	bh=h3EKyp2y0KA/EbGf8calTP5ncSY3sAhisgLfGi0RqKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=XwGKDgO3reAUlJtUqcaQmmAw1w1tNbw6ndG0mbna2EHyytW2ViN0qq8coYsvKZAxp
	 WzHN37xudTxRRmpFmQqmgTzSYPba2XVF6/kotqgneSHSqotV7pMil6jGtPzeTd4U2L
	 c2LtbN3zV0ZI33htGxObdHTGhhAd0MueYqvgmwKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfDHTOq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbfDHTOk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:40 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131572190A;
        Mon,  8 Apr 2019 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750880;
        bh=h3EKyp2y0KA/EbGf8calTP5ncSY3sAhisgLfGi0RqKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=z+FN30JEutAyN4YZjBk+Y4u/DzDAfKiYemKpYEXRowtNO2tV8M/KalXvlhPT1IiFW
         KZ/HLZa7Za5eqI0DmyBvOGlEsFuwj7xl5GP3rfIQ0NdJvt5CzA5kWWq5MLvrd4Z31D
         FwiOv5MmEy9YMiuSOCPBMO7CeBUEMVQTFrquOB+k=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 13/13] Linux 4.14.109-rt58
Date:   Mon,  8 Apr 2019 14:14:15 -0500
Message-Id: <d805ec17820ce0dc625fe3787c782eb0130130f7.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Tom Zanussi <tom.zanussi@linux.intel.com>

---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index c06cc4356292..f9df2cf089cf 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt57
+-rt58
-- 
2.14.1

