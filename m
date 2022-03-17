Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91157C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Mar 2022 15:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiCQPkq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiCQPkn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Mar 2022 11:40:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8087720C2EA;
        Thu, 17 Mar 2022 08:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 981A1CE23BC;
        Thu, 17 Mar 2022 15:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6707C340F2;
        Thu, 17 Mar 2022 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647531562;
        bh=muK9ioYGxlpIqdRAEOJJqqju0/Qdv+BbLGk8bujE/IM=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=N9LRRRKonLVFo0yNQOViTj46/OnGVjZGcgmy2rO/C91mDnGMlVaNbIsjItv9gyc7K
         MGHO3/T1FTtrZ8avJFySYpnKoa7aF1lU3F6v9jW9V7abcNTNh4YlEjcwxKA2nODeoW
         0cf+dvhLohff6gG1XlnRUny47SMRTXg1qu4cAWLNU6N6dfILx8T0cmqFqIHE/dAD2E
         //Mc3cR2REHnCa4s9KdDgOXUZP6q9bQ4JGuWO4j1YbV8JPu7yf4mKBV8C7sUayRFkM
         v9WjmsJa7/p7jqw/m49E90DP7lRqvJhEL8M1y08iadIkfhx6DpGsrc2h347CMxol63
         mHPvPR2WhNmLw==
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
Subject: [PATCH RT 2/2] Linux 5.4.182-rt72-rc1
Date:   Thu, 17 Mar 2022 10:39:17 -0500
Message-Id: <a018941c62b30e26140ec9369fc7e14d0a7e49a3.1647531550.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1647531549.git.zanussi@kernel.org>
References: <cover.1647531549.git.zanussi@kernel.org>
In-Reply-To: <cover.1647531549.git.zanussi@kernel.org>
References: <cover.1647531549.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v5.4.182-rt72-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index f38a3cc7f310..70396d6f53b7 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt71
+-rt72-rc1
-- 
2.17.1

