Return-Path: <SRS0=GyRq=5E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5753C4332D
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 14:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68622098B
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 14:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCSOY4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:24:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32935 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCSOY4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Mar 2020 10:24:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jEw6O-0002to-4v; Thu, 19 Mar 2020 15:24:52 +0100
Date:   Thu, 19 Mar 2020 15:24:52 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Graziadei <thomas.graziadei@omicronenergy.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix lazy preemption for powerpc 32bit
Message-ID: <20200319142452.dqmkuruts3i6wjyt@linutronix.de>
References: <0c91d808-b077-408c-b120-99e806efaeb5@EXC03-ATKLA.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c91d808-b077-408c-b120-99e806efaeb5@EXC03-ATKLA.omicron.at>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-03-18 21:26:40 [+0100], Thomas Graziadei wrote:
> From: Thomas Graziadei <thomas.graziadei@omicronenergy.com>
> 
> The 32bit powerpc assembler implementation of the lazy preemption
> set the _TIF_PERSYSCALL_MASK on the low word. This could lead to
> modprobe segfaults and a kernel panic - not syncing: Attempt to
> kill init! issue.
> 
> Fixed by shifting the mask by 16 bit using andis and lis.

bah. Thank you for catching this.
Still e500 based powerpc I assume?

> Signed-off-by: Thomas Graziadei <thomas.graziadei@omicronenergy.com>

Sebastian
