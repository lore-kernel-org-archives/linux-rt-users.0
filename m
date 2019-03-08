Return-Path: <SRS0=UNtE=RL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C1C43381
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Mar 2019 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF4E2081B
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Mar 2019 09:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCHJli (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:41:38 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfCHJli (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Mar 2019 04:41:38 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h2C0S-0008GF-4i; Fri, 08 Mar 2019 10:41:32 +0100
Date:   Fri, 8 Mar 2019 10:41:31 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Liu, Yongxin" <Yongxin.Liu@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "Gortmaker, Paul" <Paul.Gortmaker@windriver.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH RT] nvdimm: make lane acquirement RT aware
Message-ID: <20190308094131.ge4wbsvz4p6xikdf@linutronix.de>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
 <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A52669@ALA-MBD.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <597B109EC20B76429F71A8A97770610D12A52669@ALA-MBD.corp.ad.wrs.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-08 00:07:41 [+0000], Liu, Yongxin wrote:
> The lane is critical resource which needs to be protected. One CPU can use only one
> lane. If CPU number is greater than the number of total lane, the lane can be shared
> among CPUs. 
> 
> In non-RT kernel, get_cpu() disable preemption by calling preempt_disable() first.
> Only one thread on the same CPU can get the lane.
> 
> In RT kernel, if we only use raw_smp_processor_id(), this doesn't protect the lane. 
> Thus two threads on the same CPU can get the same lane at the same time.
> 
> In this patch, two-level lock can avoid race condition for the lane.

but you still have the ndl_lock->lock which protects the resource. So in
the unlikely (but possible event) that you switch CPUs after obtaining
the CPU number you block on the lock. No harm is done, right?

> Thanks,
> Yongxin

Sebastian
