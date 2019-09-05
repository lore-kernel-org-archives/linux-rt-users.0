Return-Path: <SRS0=A69s=XA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C78C43331
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Sep 2019 16:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C347206DE
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Sep 2019 16:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbfIEQCx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:02:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbfIEQCx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Sep 2019 12:02:53 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i5uDj-00048Z-J2; Thu, 05 Sep 2019 18:02:51 +0200
Date:   Thu, 5 Sep 2019 18:02:51 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Austin Schuh <austin.linux@gmail.com>
Cc:     linux-rt-users@vger.kernel.org,
        Brian Silverman <bsilver16384@gmail.com>
Subject: Re: Extra context switches with signalfd on CONFIG_PREEMPT_RT
Message-ID: <20190905160251.nhgemb3fadw6swgq@linutronix.de>
References: <CABsbf=Egk6wqEFPTvf9_UtVze80=b38nPzVOdZk-t=QOcUXCWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABsbf=Egk6wqEFPTvf9_UtVze80=b38nPzVOdZk-t=QOcUXCWw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-29 13:55:27 [-0700], Austin Schuh wrote:
> 
> This is still RT, but is pretty inefficient.  Any suggestions on what
> might be going wrong before I start digging in?

there is a pi-boost sched_switch with state R->D  and then de-boost
switch back. This looks like there is a wakeup while a lock is held
which is required by the task that is woken up.

> Thanks,
>   Austin

Sebastian
