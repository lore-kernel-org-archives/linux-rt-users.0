Return-Path: <SRS0=xxJu=ZV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82774C432C3
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Nov 2019 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D3D21774
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Nov 2019 16:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfK2Qsu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:48:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49167 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfK2Qsu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Nov 2019 11:48:50 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iajRi-0002HW-7q; Fri, 29 Nov 2019 17:48:42 +0100
Date:   Fri, 29 Nov 2019 17:48:42 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: xdpsock poll with 5.2.21rt kernel
Message-ID: <20191129164842.qimcmjlz5xq7uupw@linutronix.de>
References: <CAD56B7dwKDKnrCjpGmrnxz2P0QpNWU3CGBvOtqg3RBx3ejPh9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD56B7dwKDKnrCjpGmrnxz2P0QpNWU3CGBvOtqg3RBx3ejPh9g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-11-12 17:42:42 [-0500], Paul Thomas wrote:
> Any thoughts would be appreciated.

Could please enable CONFIG_DEBUG_ATOMIC_SLEEP and check if the kernel
complains?

> thanks,
> Paul

Sebastian
