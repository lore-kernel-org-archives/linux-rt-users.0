Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A44C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jun 2022 11:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353499AbiFVLFd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351916AbiFVLF3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Jun 2022 07:05:29 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6F3BBF3
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jun 2022 04:05:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C574A61F1105;
        Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8S7EXAM5RrCF; Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 650B761B8B66;
        Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UEWKmIl3aMrq; Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 1E3BD61B8B48;
        Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de,
        Richard Weinberger <richard@nod.at>
Subject: [v5.15 0/4] Backport MEMCG changes from v5.16
Date:   Wed, 22 Jun 2022 13:05:02 +0200
Message-Id: <20220622110506.10534-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is a backport of Sebastian's MEMCG changes to v5.15, with these patches applied,
it is possible to use memory cgroups together with PREEMPT_RT on v5.15, just like on v5.16.

Richard Weinberger (1):
  Allow MEMCG on PREEMPT_RT

Sebastian Andrzej Siewior (3):
  mm/memcg: Disable threshold event handlers on PREEMPT_RT
  mm/memcg: Protect per-CPU counter by disabling preemption on
    PREEMPT_RT where needed.
  mm/memcg: Add a local_lock_t for IRQ and TASK object.

 init/Kconfig    |    1 -
 mm/memcontrol.c | 1257 +++++++++++++++++++++++++----------------------
 2 files changed, 672 insertions(+), 586 deletions(-)

-- 
2.26.2

