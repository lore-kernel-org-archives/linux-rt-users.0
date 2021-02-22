Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BCC433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 00:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17FA64EBE
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 00:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBVAeW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Feb 2021 19:34:22 -0500
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:57424 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhBVAeW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Feb 2021 19:34:22 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 11M0VqWJ008395; Mon, 22 Feb 2021 09:31:52 +0900
X-Iguazu-Qid: 34tKPbYPQYjMw5hmN0
X-Iguazu-QSIG: v=2; s=0; t=1613953911; q=34tKPbYPQYjMw5hmN0; m=uNB/SAKDPLI0ejgMunXgzdxTaGf3XAnXpsvDuRSUu/g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1511) id 11M0VpMQ006542
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Feb 2021 09:31:51 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 2E4031000BB;
        Mon, 22 Feb 2021 09:31:51 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11M0Voqh005151;
        Mon, 22 Feb 2021 09:31:50 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     <dwagner@suse.de>, "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <binh1.tranhai@toshiba.co.jp>,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [rteval PATCH 0/2] Relax some architecture specific constraints
References: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp>
Date:   Mon, 22 Feb 2021 09:31:49 +0900
In-Reply-To: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp> (Punit
        Agrawal's message of "Tue, 26 Jan 2021 11:12:39 +0900")
X-TSB-HOP: ON
Message-ID: <87sg5pvt6y.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Punit Agrawal <punit1.agrawal@toshiba.co.jp> writes:

> Hi,
>
> Here are a couple of patches that enable running rteval on arm64
> targets. A previous version was sent at [0].
>
> The first patch removes the requirement for having a "model name" in
> /proc/cpuinfo. This isn't provided on an arm64 kernel unless running
> in "compat" mode.
>
> The second patch uses the default kernel compilation target instead of
> "bzImage" and "modules". "bzImage" isn't used on arm64. Instead of
> building knowledge of architecture-specific targets it maybe better to
> build the default. The default should build the kernel and modules
> anyways.
>
> More details in the patch commit log.
>
> Feedback welcome.
>
> Thanks,
> Punit
>
> [0] https://lore.kernel.org/linux-rt-users/877doa1uwx.fsf@kokedama.swc.toshiba.co.jp/
>
> Punit Agrawal (2):
>   rteval: cyclictest.py: Make 'model name' optional
>   rteval: cyclictest.py: Make build targets architecture independent
>
>  rteval/modules/loads/kcompile.py         | 2 +-
>  rteval/modules/measurement/cyclictest.py | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Ping!

If there are no comments / issues with the patches, it would be
great if they can be merged.

Thanks,
Punit
