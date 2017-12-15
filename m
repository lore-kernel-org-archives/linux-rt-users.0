From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.14-rt timer issues using PREEMPT_RT_FULL=y and NO_HZ_FULL_ALL=y
Date: Fri, 15 Dec 2017 19:22:49 +0100
Message-ID: <20171215182248.afzsdu2ng2kmlbvx@linutronix.de>
References: <20171212215818.GA18168@a.fritz.box>
 <20171213175339.udcexwcmscotipwc@linutronix.de>
 <20171213191454.GA17027@a.fritz.box>
 <20171214162503.wjyko5jnisjgaq5e@linutronix.de>
 <20171214180150.GA18502@a.fritz.box>
 <20171214182736.b5d33naqsuaw5sz2@linutronix.de>
 <20171214205750.GA6801@a.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: bert schulze <spambemyguest@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40886 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755409AbdLOSWu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Dec 2017 13:22:50 -0500
Content-Disposition: inline
In-Reply-To: <20171214205750.GA6801@a.fritz.box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-14 21:57:50 [+0100], bert schulze wrote:
> Running disk I/O and cpu workloads alongside cyclictest, no freeze
> observed at all so far.

good. Case closed then.

Sebastian
