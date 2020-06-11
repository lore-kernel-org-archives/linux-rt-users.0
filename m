Return-Path: <SRS0=F/kx=7Y=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B96DC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Jun 2020 18:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3FB20857
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Jun 2020 18:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591899037;
	bh=yqmq8AmKIW17auCMMPk4zPtnKbRm//AMqgtIec/ABoI=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=dicV8GQ2moXDhXCKN0QdsaqoQlHhOHgsZUSF6fO/CfTpt2QkcTH6+MW2Vi8WU5nmQ
	 +yH7/9eCiOz2YQiuK0rwd9pDqNb0z3DGchloG9m7SaIypV6Tc777deM0SQlD9kTS+B
	 4DseCWW+I4SbeBQtiJNlvT3b0e5N7xycRUAK8mqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFKSKc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKSKY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Jun 2020 14:10:24 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118C020878;
        Thu, 11 Jun 2020 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591899023;
        bh=yqmq8AmKIW17auCMMPk4zPtnKbRm//AMqgtIec/ABoI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nGPe1M6ZLwWHUrzTuPMNr8S9L1L9z/MhKeJdFwVvVTzBz8Xhpw/Ln2eyE00Gcpe4I
         xScGUde2NpYIlEvbIwqRsYWZOiLbtk/BTFNfs+n2q1KMAYH4sK4Es3kYEVrdIchs95
         8avVZXVYUkmbFMoSIlUJGZdMiMEW1qucg3VXfpFs=
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
Subject: [PATCH RT 4/4] Linux 4.19.127-rt55-rc1
Date:   Thu, 11 Jun 2020 13:10:17 -0500
Message-Id: <57fbd85f3ed648a2be749b8eb79c84fa109f0e08.1591898986.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591898986.git.zanussi@kernel.org>
References: <cover.1591898986.git.zanussi@kernel.org>
In-Reply-To: <cover.1591898986.git.zanussi@kernel.org>
References: <cover.1591898986.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.19.127-rt55-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 3165a8781ff5..58b8cb2d7489 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt54
+-rt55-rc1
-- 
2.17.1

