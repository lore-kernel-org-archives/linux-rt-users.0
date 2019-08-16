Return-Path: <SRS0=9Pks=WM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F9C3A59C
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 06:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F84020644
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 06:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfHPGmS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:42:18 -0400
Received: from mail.monom.org ([188.138.9.77]:52450 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPGmS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Aug 2019 02:42:18 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 7B7A75006AC;
        Fri, 16 Aug 2019 08:42:16 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id 4B98B500665;
        Fri, 16 Aug 2019 08:42:16 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH rt-tests v0 0/4] Fix gcc warning
Date:   Fri, 16 Aug 2019 08:42:00 +0200
Message-Id: <20190816064204.6339-1-wagi@monom.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On F29 and F30 gcc is warning about too small buffers. Let's fix this.

Daniel Wagner (4):
  pmqtest: Increase buffer to avoid overflow
  sigwaittest: Increase buffer to avoid overflow
  svsematest: Increase buffer to avoid overflow
  deadline_test: Increase buffer to avoid overflow

 src/pmqtest/pmqtest.c              | 4 ++--
 src/sched_deadline/deadline_test.c | 2 +-
 src/sigwaittest/sigwaittest.c      | 2 +-
 src/svsematest/svsematest.c        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.21.0
