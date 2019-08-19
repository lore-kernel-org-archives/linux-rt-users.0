Return-Path: <SRS0=6kRx=WP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E80C3A59B
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 06:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDA52086C
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 06:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfHSGnL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:43:11 -0400
Received: from mail.monom.org ([188.138.9.77]:33074 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfHSGnL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 02:43:11 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 599F95005CF;
        Mon, 19 Aug 2019 08:43:09 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id 2C239500294;
        Mon, 19 Aug 2019 08:43:09 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH rt-tests v1 v1 0/4] Fix gcc warning
Date:   Mon, 19 Aug 2019 08:43:00 +0200
Message-Id: <20190819064304.4676-1-wagi@monom.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On F29 and F30 gcc is warning about too small buffers. Let's fix this.

changes v1:
 - Increase the buffer to needed exact size as pointed out by Sebastian

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
