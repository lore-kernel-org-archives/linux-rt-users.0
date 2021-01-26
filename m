Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B887C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 04:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B5C22D04
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 04:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbhAZE5p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:57:45 -0500
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:43418 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAZCPV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jan 2021 21:15:21 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 10Q2CpDk015217; Tue, 26 Jan 2021 11:12:51 +0900
X-Iguazu-Qid: 34tMYNXf55fqpcru9S
X-Iguazu-QSIG: v=2; s=0; t=1611627171; q=34tMYNXf55fqpcru9S; m=tc5LxCBO603iDjGU54gdT/VMZG78PJS1DuW4A8w3QJs=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1512) id 10Q2ConG008787;
        Tue, 26 Jan 2021 11:12:50 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 10Q2Co9s023652;
        Tue, 26 Jan 2021 11:12:50 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 10Q2CoTm014894;
        Tue, 26 Jan 2021 11:12:50 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, dwagner@suse.de,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [rteval PATCH 0/2] Relax some architecture specific constraints 
Date:   Tue, 26 Jan 2021 11:12:39 +0900
X-TSB-HOP: ON
Message-Id: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Here are a couple of patches that enable running rteval on arm64
targets. A previous version was sent at [0].

The first patch removes the requirement for having a "model name" in
/proc/cpuinfo. This isn't provided on an arm64 kernel unless running
in "compat" mode.

The second patch uses the default kernel compilation target instead of
"bzImage" and "modules". "bzImage" isn't used on arm64. Instead of
building knowledge of architecture-specific targets it maybe better to
build the default. The default should build the kernel and modules
anyways.

More details in the patch commit log.

Feedback welcome.

Thanks,
Punit

[0] https://lore.kernel.org/linux-rt-users/877doa1uwx.fsf@kokedama.swc.toshiba.co.jp/

Punit Agrawal (2):
  rteval: cyclictest.py: Make 'model name' optional
  rteval: cyclictest.py: Make build targets architecture independent

 rteval/modules/loads/kcompile.py         | 2 +-
 rteval/modules/measurement/cyclictest.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.29.2

