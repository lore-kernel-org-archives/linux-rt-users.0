Return-Path: <SRS0=oonB=UR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8972C31E5E
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9252080C
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfFRKjt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:39:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRKjt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 06:39:49 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hdBWg-0005SS-Jz; Tue, 18 Jun 2019 12:39:42 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 0/6] rt-tests: deadline: Cleanups
Date:   Tue, 18 Jun 2019 12:38:35 +0200
Message-Id: <20190618103841.27249-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

this addresses some issues in the deadline tests:

 - Remove duplicated code
 - Add usage message to cyclicdeadline
 - Fix cgroup setup for cyclicdeadline

Thanks,
Kurt

Kurt Kanzenbach (6):
  rt-tests: deadline: Remove duplicated code for sched_{set,get}_attr
  rt-tests: cyclicdeadline: Remove unused getcpu code
  rt-tests: deadline: Remove duplicated gettid() code
  rt-tests: cyclicdeadline: Add options to usage
  rt-tests: cyclicdeadline: Print fail only if something failed
  rt-tests: cyclicdeadline: Fix cgroup setup

 src/sched_deadline/cyclicdeadline.c | 71 ++++++++-------------------------
 src/sched_deadline/deadline_test.c  | 78 ++-----------------------------------
 2 files changed, 20 insertions(+), 129 deletions(-)

-- 
2.11.0

