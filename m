Return-Path: <SRS0=wj13=XW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565FDC4360C
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387F9207E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfI0PSo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:18:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:33225 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfI0PSo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Sep 2019 11:18:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 08:18:43 -0700
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="184011673"
Received: from kwells1-mobl.amr.corp.intel.com ([10.254.66.7])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 08:18:43 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PREEMPT_RT PATCH 2/3] i915: convert all irq_locks spinlocks to
 raw spinlocks
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
In-Reply-To: <CAPAFJkofsYgSOxzM4JDkOV3Ra0C-AEpU2eZJjR9F9e_qv-6=rg@mail.gmail.com>
Date:   Fri, 27 Sep 2019 08:18:42 -0700
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <350F3734-FB0F-4D71-92FD-59EEAF9CCB0B@linux.intel.com>
References: <20190820003319.24135-1-clark.williams@gmail.com>
 <20190820003319.24135-3-clark.williams@gmail.com>
 <20190903080335.pe45dmgmjvdvbyd4@linutronix.de>
 <9EF2695D-3FBD-40E0-BE8A-EB71AF4155A5@linux.intel.com>
 <20190927122934.2bz6ysx27ecw2uxa@linutronix.de>
 <CAPAFJkofsYgSOxzM4JDkOV3Ra0C-AEpU2eZJjR9F9e_qv-6=rg@mail.gmail.com>
To:     Clark Williams <clark.williams@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



> On Sep 27, 2019, at 7:58 AM, Clark Williams <clark.williams@gmail.com> wrote:
> 
> I'm running v5.2.17-rt9 now and have not seen any i915 related splats. I think we're good to drop my patches
> 
> On Fri, Sep 27, 2019 at 7:29 AM Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2019-09-16 14:21:22 [-0700], Sean V Kelley wrote:
> > I’ve tested this also on the v5.2.14-rt7 and can confirm that it avoids the need for making the locks raw.
> > 
> > Tested-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
> 
> Good. I went for an alternative approach in v5.2.17-rt9. Now I believe
> that the three here are obsolete. If not, please give a sign.

Confirmed as well..

Sean

> 
> > Thanks,
> > 
> > Sean
> 
> Sebastian

