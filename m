Return-Path: <SRS0=J2Xz=SG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F13C4360F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 13:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB2C20882
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 13:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfDDNsl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:48:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDDNsl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Apr 2019 09:48:41 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hC2jP-00031f-Sg; Thu, 04 Apr 2019 15:48:40 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 0/4] rt-tests: deadline: Fix segmentation faults
Date:   Thu,  4 Apr 2019 15:48:10 +0200
Message-Id: <20190404134814.13376-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

the deadline test binaries may crash under certain circumstances.

That seems to be caused by stack buffer overflows. While here, I've noticed that
some memory wasn't free'd. So, added that as well.

Thanks,
Kurt

Kurt Kanzenbach (4):
  rt-tests: cyclicdeadline: fix segmentation fault on close
  rt-tests: cyclicdeadline: add missing free calls
  rt-tests: deadline_tests: fix stack buffer flow
  rt-tests: deadline_test: add missing frees

 src/sched_deadline/cyclicdeadline.c | 4 +++-
 src/sched_deadline/deadline_test.c  | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.11.0

