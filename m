Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767AEC43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jun 2022 11:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiFVLFl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353536AbiFVLFa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Jun 2022 07:05:30 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442BA3BBF9
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jun 2022 04:05:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D056C61F110F;
        Wed, 22 Jun 2022 13:05:25 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tSUmUmJhCUHL; Wed, 22 Jun 2022 13:05:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3BCA361B8B4F;
        Wed, 22 Jun 2022 13:05:25 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ybq52P9-ddFk; Wed, 22 Jun 2022 13:05:25 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E7DA361B8B48;
        Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de,
        Richard Weinberger <richard@nod.at>
Subject: [v5.15 4/4] Allow MEMCG on PREEMPT_RT
Date:   Wed, 22 Jun 2022 13:05:06 +0200
Message-Id: <20220622110506.10534-5-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220622110506.10534-1-richard@nod.at>
References: <20220622110506.10534-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

With these backported, it is safe to us MEMCG again:
mm/memcg: Add a local_lock_t for IRQ and TASK object.
mm/memcg: Protect per-CPU counter by disabling preemption on PREEMPT_RT w=
here needed.
mm/memcg: Disable threshold event handlers on PREEMPT_RT

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 init/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 0b8a65ae1d72..45bcaa8e7481 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -938,7 +938,6 @@ config PAGE_COUNTER
=20
 config MEMCG
 	bool "Memory controller"
-	depends on !PREEMPT_RT
 	select PAGE_COUNTER
 	select EVENTFD
 	help
--=20
2.26.2

