Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074C0C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62562184D
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMBp5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgHMBp4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 21:45:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AED320774;
        Thu, 13 Aug 2020 01:45:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k62JX-0074yz-BY; Wed, 12 Aug 2020 21:45:55 -0400
Message-ID: <20200813014534.833107526@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Aug 2020 21:45:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 0/6] Linux 5.4.54-rt33-rc1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 5.4.54-rt33-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 8/14/2020.

Enjoy,

-- Steve


To build 5.4.54-rt33-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.54.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.54-rt33-rc1.patch.xz

You can also build from 5.4.54-rt32 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.54-rt32-rt33-rc1.patch.xz


Changes from 5.4.54-rt32:

---


Ahmed S. Darwish (1):
      net: phy: fixed_phy: Remove unused seqcount

Matt Fleming (1):
      signal: Prevent double-free of user struct

Sebastian Andrzej Siewior (3):
      workqueue: Sync with upstream
      Bluetooth: Acquire sk_lock.slock without disabling interrupts
      rwsem: Provide down_read_non_owner() and up_read_non_owner() for -RT

Steven Rostedt (VMware) (1):
      Linux 5.4.54-rt33-rc1

----
 drivers/net/phy/fixed_phy.c | 28 +++++++++++-----------------
 include/linux/swait.h       | 14 --------------
 kernel/locking/rwsem.c      |  8 ++++----
 kernel/signal.c             |  4 ++--
 kernel/workqueue.c          | 28 +++++++++++++++++++---------
 localversion-rt             |  2 +-
 net/bluetooth/rfcomm/sock.c |  7 ++-----
 7 files changed, 39 insertions(+), 52 deletions(-)
