Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F955C433E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB52221F0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbhAZE5g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:57:36 -0500
Received: from mo-csw-fb1516.securemx.jp ([210.130.202.172]:56480 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbhAZCPQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jan 2021 21:15:16 -0500
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 10Q1BwqD018869; Tue, 26 Jan 2021 10:11:58 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 10Q14OFu008727; Tue, 26 Jan 2021 10:04:24 +0900
X-Iguazu-Qid: 34tMYNXf55aqHOiNyS
X-Iguazu-QSIG: v=2; s=0; t=1611623064; q=34tMYNXf55aqHOiNyS; m=6YlMLkLdxiHvIG3c85flImX4ZXkNzMppLO+Wu8L47Pc=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 10Q14Njo037913;
        Tue, 26 Jan 2021 10:04:23 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 10Q14NM7011628;
        Tue, 26 Jan 2021 10:04:23 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 10Q14MGl011337;
        Tue, 26 Jan 2021 10:04:23 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        dwagner@suse.de, linux-rt-users@vger.kernel.org
Subject: Re: Some issues running rteval on arm64, arm and i386
References: <877doa1uwx.fsf@kokedama.swc.toshiba.co.jp>
        <f4fac09b-dd20-3949-87e1-6855b0cec521@redhat.com>
Date:   Tue, 26 Jan 2021 10:04:20 +0900
In-Reply-To: <f4fac09b-dd20-3949-87e1-6855b0cec521@redhat.com> (John Kacur's
        message of "Fri, 22 Jan 2021 18:27:00 -0500 (EST)")
X-TSB-HOP: ON
Message-ID: <877do0zey3.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

John Kacur <jkacur@redhat.com> writes:

[...]

> In the past we targetted x86_64 only with rteval, but I definitely am 
> interested in patches that would make it work on other architectures where 
> the rt-kernel runs.

Thanks for confirming.

> Could you resend the patches inline in separate mails, as you would when
> sending patches for the linux kernel? The reason for this is it makes it
> easier to comment on the code.

Sure, no problem. I'll resend the patches inline in a separate thread
shortly.

Thanks,
Punit

[...]

