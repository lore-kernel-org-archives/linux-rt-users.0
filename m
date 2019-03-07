Return-Path: <SRS0=0bBW=RK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B5C43381
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Mar 2019 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E8820675
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Mar 2019 14:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfCGOdv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:33:51 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54757 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGOdv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Mar 2019 09:33:51 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h1u5h-0006dO-0e; Thu, 07 Mar 2019 15:33:45 +0100
Date:   Thu, 7 Mar 2019 15:33:44 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yongxin Liu <yongxin.liu@windriver.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, dan.j.williams@intel.com,
        pagupta@redhat.com, paul.gortmaker@windriver.com,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH RT] nvdimm: make lane acquirement RT aware
Message-ID: <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306095709.23138-1-yongxin.liu@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-06 17:57:09 [+0800], Yongxin Liu wrote:
> In this change, we replace get_cpu/put_cpu with local_lock_cpu/
> local_unlock_cpu, and introduce per CPU variable "ndl_local_lock".
> Due to preemption on RT, this lock can avoid race condition for the
> same lane on the same CPU. When CPU number is greater than the lane
> number, lane can be shared among CPUs. "ndl_lock->lock" is used to
> protect the lane in this situation.

so what was the reason that get_cpu() can't be replaced with
raw_smp_processor_id()?

Sebastian
