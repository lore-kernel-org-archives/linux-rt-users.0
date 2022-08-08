Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A47C00140
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbiHHM4w (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiHHM4n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:43 -0400
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4535F49
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:41 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 8DC36416AA;
        Mon,  8 Aug 2022 14:56:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 8DC36416AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963399;
        bh=yMVPV+D70GOWw86vjSTklQbfqsovADM87cju4pwkeBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9hpScP26o05BTGrVZBOMxNkGPIrab81ok3bMzcyTXeDg7u44zFOQ4cdrYLL4HpBd
         0mrSp1Ss5Ft0cJtq9IGSym0ACOyFgwjOogRcFi4XPxPL+bQxK16wq4V4MgBtWRODZu
         UqMvN+eJ7RySAKPAkDJwbVdHo2DQKPKWarAFkG1g=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 09/10] mm/memcg: Only perform the debug checks on !PREEMPT_RT
Date:   Mon,  8 Aug 2022 14:56:01 +0200
Message-Id: <20220808125602.97747-10-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On PREEMPT_RT interrupts and preemption is always enabled. The locking
function __memcg_stats_lock() always disabled preemptions. The recently
added checks need to performed only on !PREEMPT_RT where preemption and
disabled interrupts are used.

Please fold into:
	"Protect per-CPU counter by disabling preemption on PREEMPT_RT"

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 70c374761bb8..74025c2e2bcc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -773,7 +773,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	 * interrupt context while other caller need to have disabled interrupt.
 	 */
 	__memcg_stats_lock();
-	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		switch (idx) {
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
-- 
2.37.1

