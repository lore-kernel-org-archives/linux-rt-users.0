Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687D5C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 02:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D0F64E85
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 02:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhBXCSb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:18:31 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:47296 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhBXCSb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 21:18:31 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 11O2GOa6013738; Wed, 24 Feb 2021 11:16:24 +0900
X-Iguazu-Qid: 2wGqsXjpwXaZ7kPo5C
X-Iguazu-QSIG: v=2; s=0; t=1614132984; q=2wGqsXjpwXaZ7kPo5C; m=Pj/a2vQCHezrKplRBALsxkuS/Z0ShozhPPGbEFKtPfk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 11O2GN6r002064
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 11:16:23 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 842C610007F;
        Wed, 24 Feb 2021 11:16:23 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11O2GNwA006391;
        Wed, 24 Feb 2021 11:16:23 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, dwagner@suse.de,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [rteval PATCH v2 0/3] Make rteval usable on arm, arm64 and i386
Date:   Wed, 24 Feb 2021 11:16:00 +0900
X-TSB-HOP: ON
Message-Id: <20210224021603.446274-1-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

This is an updated version of the series to improve support of rteval
on arm, arm64 and i386. Previous version can be found at [0].

Changes -
* The biggest change in this version is to improve the logic to
  construct CPU description on arm and arm64 architectures. The
  changes also incorporate feedback from John on the previous version.

* Include the patch to systopology.py required on systems that do not
  have numa domains. The patch was previously posted separately at [1].

Feedback welcome.

Thanks,
Punit


[0] https://lore.kernel.org/linux-rt-users/20210126021241.112944-1-punit1.agrawal@toshiba.co.jp/
[1] https://lore.kernel.org/linux-rt-users/20210127083412.118047-1-punit1.agrawal@toshiba.co.jp/

Punit Agrawal (3):
  rteval: cyclictest.py: Update logic to get core description
  rteval: cyclictest.py: Make build targets architecture independent
  rteval: systopology.py: Add support for systems that don't have Numa

 rteval/misc.py                           | 24 ++++++++++++++-
 rteval/modules/loads/kcompile.py         |  2 +-
 rteval/modules/measurement/cyclictest.py |  8 +++--
 rteval/systopology.py                    | 38 ++++++++++++++++++++----
 4 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.30.0

