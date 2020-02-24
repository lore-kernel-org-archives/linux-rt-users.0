Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A2C11D30
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB212082F
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 15:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgBXPwh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:52:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXPwh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 10:52:37 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6G26-0006oN-7y; Mon, 24 Feb 2020 16:52:34 +0100
Date:   Mon, 24 Feb 2020 16:52:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 20/25] kmemleak: Cosmetic changes
Message-ID: <20200224155234.brdcpecpfboyjjon@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <c3cf47877f79afa92634bf376488c8aa71378a26.1582320278.git.zanussi@kernel.org>
 <20200224091204.xzn6cheydarek6ex@linutronix.de>
 <1582557503.12738.22.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1582557503.12738.22.camel@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-24 09:18:23 [-0600], Tom Zanussi wrote:
> > What should be applied instead is
> > 	fb2c57edcb943 ("kmemleak: Change the lock of kmemleak_object to
> > raw_spinlock_t")
> > 
> 
> I did apply that patch (as patch 14/25 of this series).  This patch
> seemed like it was adding some comment bits mised for that one, which
> is all it does.

Bah. So I saw that (#14/25), considered okay but while looking at this
patch I was comparing against v4.14.164-rt73 and forgot about it…

> Thanks,
> 
> Tom

Sebastian.
