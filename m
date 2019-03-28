Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7746BC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 17:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D7420823
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 17:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfC1RjG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:39:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53721 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1RjG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 13:39:06 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9YzT-00072K-6b; Thu, 28 Mar 2019 18:38:59 +0100
Date:   Thu, 28 Mar 2019 18:38:59 +0100
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
Message-ID: <20190328173858.hpbtoep42ucomav2@linutronix.de>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
 <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A52669@ALA-MBD.corp.ad.wrs.com>
 <20190308094131.ge4wbsvz4p6xikdf@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A5643B@ALA-MBD.corp.ad.wrs.com>
 <20190315164236.rzbwe7reeprjv3um@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A63C81@ALA-MBD.corp.ad.wrs.com>
 <20190318114017.tazjaegln2obt3zg@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A649C1@ALA-MBD.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <597B109EC20B76429F71A8A97770610D12A649C1@ALA-MBD.corp.ad.wrs.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-18 11:48:28 [+0000], Liu, Yongxin wrote:
> 
> > 
> > Bummer. That would dead lock indeed.
> > Is it easily possible to recognize the recursive case?
> 
> Not easily. I don't have test case for recursive call. 
> For now, just code analysis.

So I've been playing with qemu's nvdimm device. So I *think* the
recursive case is here not possible because qemu only supports pmem
while it would require the blk mode to trigger it. It is just a wild
guess…

On top of qemu's nvdimm device I can create a block device via
	ndctl create-namespace  namespace0.0 --mode=sector

and then I trigger the code path in question.

I would *really* prefer to understand the recursive case and avoid it.
That way the recursive case is explicitly known and uses another path.
The lock can then be always acquired which gives you always lockdep
coverage (which is now missing unless you have more LANEs than CPUs).

The local_lock thingy is completely unneeded: a simple get_cpu_light()
would do the job.

> Yongxin

Sebastian
