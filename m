Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ECCC35679
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A9120842
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 09:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgBXJwa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:52:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBXJwa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 04:52:30 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6APb-0007Fy-EJ; Mon, 24 Feb 2020 10:52:27 +0100
Date:   Mon, 24 Feb 2020 10:52:27 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zanussi@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 21/25] smp: Use smp_cond_func_t as type for the
 conditional function
Message-ID: <20200224095227.kfzl2lhonpmderlj@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <c7bd8ba713f3e67bf77ea6847ab85ab47f8168a2.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7bd8ba713f3e67bf77ea6847ab85ab47f8168a2.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-21 15:24:49 [-0600], zanussi@kernel.org wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> v4.14.170-rt75-rc1 stable review patch.
> If anyone has any objections, please let me know.

This alone makes no sense. I had this in the devel tree as part of a
three patch series to remove a limitation in on_each_cpu_cond_mask().
This does not apply to the v4.14 series due to lack of the
on_each_cpu_cond_mask() function.

Sebastian
