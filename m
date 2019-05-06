Return-Path: <SRS0=pVaS=TG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8641FC04AAA
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 May 2019 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6281B205C9
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 May 2019 09:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfEFJWW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 May 2019 05:22:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36694 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFJWW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 May 2019 05:22:22 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hNZpC-0005Ln-CA; Mon, 06 May 2019 11:22:18 +0200
Date:   Mon, 6 May 2019 11:22:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 0/3] do not raise timer softirq unconditionally (spinlockless
 version)
In-Reply-To: <20190506032234.GA31395@amt.cnet>
Message-ID: <alpine.DEB.2.21.1905061121580.1637@nanos.tec.linutronix.de>
References: <20190415201213.600254019@amt.cnet> <20190506032234.GA31395@amt.cnet>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 6 May 2019, Marcelo Tosatti wrote:
> On Mon, Apr 15, 2019 at 05:12:13PM -0300, Marcelo Tosatti wrote:
> > It handles the the race between timer addition and timer interrupt
> > execution by unconditionally (in case of isolated CPUs) raising the
> > timer softirq after making sure the updated bitmap is visible
> > on remote CPUs.
> > 
> > This patchset reduces cyclictest latency from 25us to 14us
> > on my testbox.
>
> Ping?

On my list ....

