Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D3CC10F27
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 17:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66271208C3
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 17:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCIRNw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:13:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59783 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgCIRNw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 13:13:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jBLyQ-0003eN-3m; Mon, 09 Mar 2020 18:13:50 +0100
Date:   Mon, 9 Mar 2020 18:13:50 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org,
        Luiz Capitulino <lcapitulino@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] mm: Revert the DEFINE_PER_CPU_PAGEVEC implementation
Message-ID: <20200309171350.kjb3pdjazhxm2li2@linutronix.de>
References: <20200309170354.pw5drgdga5flgs36@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200309170354.pw5drgdga5flgs36@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-03-09 18:03:54 [+0100], To linux-rt-users@vger.kernel.org wrote:
…
>   mm-perform-lru_add_drain_all-remotely.patch

I need to think again about this one. I don't think we get this
upstream. We don't want to acquire the local-locks cross-CPU like we do
here. Also the bug/problem exists even if -RT is not involved.

Sebastian
