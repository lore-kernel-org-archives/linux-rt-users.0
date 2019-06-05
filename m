Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F14FC28CC5
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D67206C3
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfFEQGa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:30 -0400
Received: from mail.monom.org ([188.138.9.77]:35582 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfFEQGa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:30 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 4EC8B500517;
        Wed,  5 Jun 2019 18:06:28 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id 000BB5004BB;
        Wed,  5 Jun 2019 18:06:27 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 00/12] rt-tests: Add --duration argument to tests
Date:   Wed,  5 Jun 2019 18:06:05 +0200
Message-Id: <20190605160617.22987-1-wagi@monom.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

An updated version of the --duration series.
It is also available from github:

https://github.com/igaw/rt-tests/tree/dw-devel

changes since v1:
 - '--duration' patch splitted up
 - added short option support to pi_stress
 - added build warning
 - added 32bit ARM 'support' to queuelat patch

Daniel Wagner (12):
  rt_numa.h: Remove unused function
  queuelat: Use clock syscall for ARM 32 bit
  rt-utils: Move parse_time_string()
  pi_stress: Allow short command line arguments
  pi_stress: Rename -t command line option to -D
  pmqtest: Add duration command line argument
  ptsematest: Add duration command line argument
  cyclicdeadline: Add duration command line argument
  signaltest: Add duration command line argument
  sigwaittest: Add duration command line argument
  svsematest: Add duration command line argument
  rt-migrate-test: Add duration command line argument

 src/cyclictest/cyclictest.c           | 33 --------------------------
 src/cyclictest/rt_numa.h              |  7 ------
 src/include/rt-utils.h                |  2 ++
 src/lib/rt-utils.c                    | 34 +++++++++++++++++++++++++++
 src/pi_tests/pi_stress.8              |  4 ++++
 src/pi_tests/pi_stress.c              | 12 +++++-----
 src/pmqtest/pmqtest.8                 |  5 ++++
 src/pmqtest/pmqtest.c                 | 17 ++++++++++++--
 src/ptsematest/ptsematest.8           |  5 ++++
 src/ptsematest/ptsematest.c           | 14 ++++++++++-
 src/queuelat/queuelat.c               | 31 ++++++++++++++++++++----
 src/rt-migrate-test/rt-migrate-test.8 |  5 ++++
 src/rt-migrate-test/rt-migrate-test.c | 12 +++++++++-
 src/sched_deadline/cyclicdeadline.c   | 12 +++++++++-
 src/signaltest/signaltest.8           |  5 ++++
 src/signaltest/signaltest.c           | 14 ++++++++++-
 src/sigwaittest/sigwaittest.8         |  5 ++++
 src/sigwaittest/sigwaittest.c         | 15 +++++++++++-
 src/svsematest/svsematest.8           |  5 ++++
 src/svsematest/svsematest.c           | 15 +++++++++++-
 20 files changed, 193 insertions(+), 59 deletions(-)

-- 
2.20.1
