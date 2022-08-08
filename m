Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAEFC25B0C
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiHHM4r (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbiHHM4k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:40 -0400
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B79E2DD3
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:38 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id A60D040C26;
        Mon,  8 Aug 2022 14:56:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at A60D040C26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963394;
        bh=h6Gos8dLweIaYo0JZiisZWI7YD6jbXJkPoyzDalCf2E=;
        h=From:To:Cc:Subject:Date:From;
        b=g+KNr9ANDoK0jjqPNlW2fYURK+sntT1hyWHQH2n4v1klNDQwNhsiLhNZwdkdyb9WK
         ksVsk4BkuIg40aSIhiMb/PqmAajdzDV+7IT1zOzZYdEIneZJc/QbmODsHWY7KdDls2
         ck7r8doESy+WDWw+04PFkpqfJQ/VSYQAUoCi4JJA=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 00/10] Backport MEMCG changes from v5.17
Date:   Mon,  8 Aug 2022 14:55:52 +0200
Message-Id: <20220808125602.97747-1-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is a backport of Sebastian's MEMCG changes to v5.15. With these
patches applied, it is possible to use memory cgroups together
with PREEMPT_RT on v5.15, just like on v5.17.

The patch set was tested on my end by building an x86_64 kernel
with PREEMPT_RT, cgroup debug and lockdep enabled. The kernel was
run in Qemu, where a small number of child cgroups were created,
with memory controller enabled for each and an instance of a small
test program running.


Changes in v2:
  - Use the exact patch set merged upstream

David Oberhollenzer (1):
  Allow MEMCG on PREEMPT_RT

Johannes Weiner (1):
  mm/memcg: Opencode the inner part of obj_cgroup_uncharge_pages() in drain_obj_stock()

Michal Hocko (1):
  mm/memcg: Revert ("mm/memcg: optimize user context object stock access")

Sebastian Andrzej Siewior (7):
  mm/memcg: Disable threshold event handlers on PREEMPT_RT
  mm/memcg: Protect per-CPU counter by disabling preemption on PREEMPT_RT where needed.
  mm/memcg: Protect memcg_stock with a local_lock_t
  mm/memcg: Disable migration instead of preemption in drain_all_stock().
  mm/memcg: Add missing counter index which are not update in interrupt.
  mm/memcg: Add a comment regarding the release `obj'.
  mm/memcg: Only perform the debug checks on !PREEMPT_RT

 .../admin-guide/cgroup-v1/memory.rst          |   2 +
 init/Kconfig                                  |   1 -
 mm/memcontrol.c                               | 232 +++++++++++-------
 3 files changed, 146 insertions(+), 89 deletions(-)

-- 
2.37.1

