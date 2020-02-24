Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EF6C3567B
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 08:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73E522525
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 08:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBXIzE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:55:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgBXIzD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 03:55:03 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j69W0-0005YK-NS; Mon, 24 Feb 2020 09:55:00 +0100
Date:   Mon, 24 Feb 2020 09:55:00 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zanussi@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 17/25] x86/fpu: Don't cache access to
 fpu_fpregs_owner_ctx
Message-ID: <20200224085500.nub2zjcucwx2nwiw@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <25549e4ff2e5d78e663cf6e5cd8ed108ef03ff44.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25549e4ff2e5d78e663cf6e5cd8ed108ef03ff44.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-21 15:24:45 [-0600], zanussi@kernel.org wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> v4.14.170-rt75-rc1 stable review patch.
> If anyone has any objections, please let me know.

Please don't apply this for the reasons I mentioned in
	https://lkml.kernel.org/r/20200122084352.nyqnlfaumjgnvgih@linutronix.de

I guess they still apply (haven't checked).

Sebastian
