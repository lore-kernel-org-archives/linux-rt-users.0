Return-Path: <SRS0=5OrQ=RV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6FEC43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Mar 2019 11:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242C620854
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Mar 2019 11:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCRLkZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:40:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfCRLkZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Mar 2019 07:40:25 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h5qcr-0004SO-Uf; Mon, 18 Mar 2019 12:40:18 +0100
Date:   Mon, 18 Mar 2019 12:40:17 +0100
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
Message-ID: <20190318114017.tazjaegln2obt3zg@linutronix.de>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
 <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A52669@ALA-MBD.corp.ad.wrs.com>
 <20190308094131.ge4wbsvz4p6xikdf@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A5643B@ALA-MBD.corp.ad.wrs.com>
 <20190315164236.rzbwe7reeprjv3um@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A63C81@ALA-MBD.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <597B109EC20B76429F71A8A97770610D12A63C81@ALA-MBD.corp.ad.wrs.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-18 01:41:10 [+0000], Liu, Yongxin wrote:
> 
> Consider the recursive call to nd_region_acquire_lane() in the following situation.
> Will there be a dead lock?
> 
> 
>     Thread A                    Thread B
>        |                           |
>        |                           |
>      CPU 1                       CPU 2
>        |                           |
>        |                           |
>  get lock for Lane 1         get lock for Lane 2
>        |                           |
>        |                           |
>  migrate to CPU 2            migrate to CPU 1
>        |                           |
>        |                           |
>  wait lock for Lane 2        wait lock for Lane 1 
>        |                           |
>        |                           |
>        _____________________________
>                    |
>                 dead lock ?

Bummer. That would dead lock indeed.
Is it easily possible to recognize the recursive case? 

> 
> Thanks,
> Yognxin

Sebastian
