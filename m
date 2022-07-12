Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B0BC43334
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Jul 2022 11:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiGLLqP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiGLLqN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Jul 2022 07:46:13 -0400
X-Greylist: delayed 1398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 04:46:10 PDT
Received: from mail.infraroot.at (mail.infraroot.at [IPv6:2001:41d0:701:1100::afc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE36B195A
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Jul 2022 04:46:10 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id CCF9E3F477;
        Tue, 12 Jul 2022 13:22:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at CCF9E3F477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1657624967;
        bh=CHqd+mf9Z0Ap8s0WhsT9i2n2dxAFfcmjG17ues+W5Aw=;
        h=From:To:Cc:Subject:Date:From;
        b=MmFA6nwei1cURekjCQodPMJ1/FDgSPkd+MQ5YuFHJoL+0hs+lwQ9BfocLw3uFoqLT
         7GZMRMz+rqvchEBdt9iEYbi9wskYj6i3CNCL5jFCI1uPmnFfncVKlecfS9YJhEeqDy
         Vyd+oFKnJhWs39V6/DkggLBFgFjSIEkfWWab1Xhw=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH 0/4] Backport MEMCG changes from v5.17
Date:   Tue, 12 Jul 2022 13:22:34 +0200
Message-Id: <20220712112238.18824-1-goliath@infraroot.at>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is a backport of Sebastian's MEMCG changes to v5.15. With these
patches applied, it is possible to use memory cgroups together
with PREEMPT_RT on v5.15, just like on v5.17.

David Oberhollenzer (1):
  Allow MEMCG on PREEMPT_RT

Sebastian Andrzej Siewior (3):
  mm/memcg: Disable threshold event handlers on PREEMPT_RT
  mm/memcg: Protect per-CPU counter by disabling preemption on
    PREEMPT_RT where needed.
  mm/memcg: Add a local_lock_t for IRQ and TASK object.

 .../admin-guide/cgroup-v1/memory.rst          |    2 +
 init/Kconfig                                  |    1 -
 mm/memcontrol.c                               | 1264 +++++++++--------
 3 files changed, 671 insertions(+), 596 deletions(-)

-- 
2.36.1

