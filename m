Return-Path: <SRS0=Yj13=52=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB7C2BB85
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Apr 2020 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202B52084D
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Apr 2020 20:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586549716;
	bh=yo+6fYCu0++Y9+eNTxSwJiBUzd4rBhPyaXFFLb325J0=;
	h=From:To:Subject:Date:List-ID:From;
	b=U+Rf5/MEZiEOao+4ET0egy+F5afFnSqETLIan5gB+wd0Be6YRUgJK/aLp6PqAgHnl
	 v83cEgYz8GIf44KUPrOc1fyQHjq3t9UiZ25w0s5iyJMlke/ubkaJviFHgbTjUiIXvf
	 yd/s4Da/mP3EQbJyBcOMBFyX8EOC9r3MSLo4QPJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJUPE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDJUPE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Apr 2020 16:15:04 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9694A20732;
        Fri, 10 Apr 2020 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586549704;
        bh=yo+6fYCu0++Y9+eNTxSwJiBUzd4rBhPyaXFFLb325J0=;
        h=From:To:Subject:Date:From;
        b=bmJPmlxGsoRCIPO9DE5a6GNFyOGl/qxnFT8YIhHg7V+Wu1Y09N72dEwtv1rUyi++i
         fGp7baLEn7NgVNQT/oAB6L+kftFQ/zu/vvBxRduRl+kXnmEA+cCsm47C4IWqxk/GCd
         +MXV8i6F4STug8eiOq+X7PL6EOK7GfFGl9iBsu0Y=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/2] Linux v4.14.175-rt81-rc1
Date:   Fri, 10 Apr 2020 15:15:00 -0500
Message-Id: <cover.1586549682.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.14.175-rt81-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-04-17.

To build 4.14.175-rt81-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.175.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.175-rt81-rc1.patch.xz

You can also build from 4.14.175-rt80 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.175-rt80-rt81-rc1.patch.xz


Enjoy,

-- Tom


Steven Rostedt (VMware) (1):
  irq_work: Fix checking of IRQ_WORK_LAZY flag set on non PREEMPT_RT

Tom Zanussi (1):
  Linux 4.14.175-rt81-rc1

 kernel/irq_work.c | 12 +++++++++---
 localversion-rt   |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.17.1

