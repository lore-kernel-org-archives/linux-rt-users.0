Return-Path: <SRS0=m88/=7S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F2C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 23:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA387206FA
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 23:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgFEXmX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbgFEXmX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jun 2020 19:42:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2A9206E6;
        Fri,  5 Jun 2020 23:42:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jhLyf-002sAG-QK; Fri, 05 Jun 2020 19:42:21 -0400
Message-ID: <20200605234149.965509211@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Jun 2020 19:41:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 0/8] Linux 5.4.44-rt27-rc1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 5.4.44-rt27-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 6/9/2020.

Enjoy,

-- Steve


To build 5.4.44-rt27-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.44.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.44-rt27-rc1.patch.xz

You can also build from 5.4.44-rt26 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.44-rt26-rt27-rc1.patch.xz


Changes from 5.4.44-rt26:

---


John Ogness (1):
      printk: console must not schedule for drivers

Kevin Hao (1):
      mm: slub: Always flush the delayed empty slubs in flush_all()

Liwei Song (1):
      mm: Don't warn about atomic memory allocations during suspend

Sebastian Andrzej Siewior (3):
      fs/dcache: Include swait.h header
      Revert "rt: Improve the serial console PASS_LIMIT"
      mm/zswap: Use local lock to protect per-CPU data

Steven Rostedt (VMware) (1):
      Linux 5.4.44-rt27-rc1

汪勇10269566 (1):
      printk: Force a line break on pr_cont(" ")

----
 drivers/tty/serial/8250/8250_core.c | 11 +----------
 fs/proc/base.c                      |  1 +
 kernel/printk/printk.c              |  2 ++
 localversion-rt                     |  2 +-
 mm/slub.c                           | 11 +++++------
 mm/zswap.c                          | 21 ++++++++++++---------
 6 files changed, 22 insertions(+), 26 deletions(-)
