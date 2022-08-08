Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CE7C25B0E
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiHHM4v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbiHHM4n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:43 -0400
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D8A5588
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:41 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 1BECC416A2;
        Mon,  8 Aug 2022 14:56:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 1BECC416A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963399;
        bh=ZqO092KYvya3/ahPQoasLBIjBb8XtL++HVpLcH+QVNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXpI+u9mUpuYa2qPKYItHKdnCWtc19Xo6qv+BgRIy7+gmFlXm0SNFUFYntFSDF3ti
         7dcai/iajU5Do2yI9yvjYFJF9Pv1D4DZCU3Z41J1fXWYyGQyn61OTYEmEl3UQTrHig
         Jnz9a+dynQMHoLODbfFwO/7uIZeePG3lXInOxVEM=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 08/10] mm/memcg: Add a comment regarding the release `obj'.
Date:   Mon,  8 Aug 2022 14:56:00 +0200
Message-Id: <20220808125602.97747-9-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Please fold into
    mm/memcg: Protect memcg_stock with a local_lock_t

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 50d2d5432018..70c374761bb8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3249,6 +3249,10 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 	}
 
 	stock->cached_objcg = NULL;
+	/*
+	 * The `old' objects needs to be released by the caller via
+	 * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
+	 */
 	return old;
 }
 
-- 
2.37.1

