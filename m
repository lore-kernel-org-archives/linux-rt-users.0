Return-Path: <SRS0=2ve0=XL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BBAC4CECD
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588C62067B
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391792AbfIPVVZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:21:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:21872 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbfIPVVZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Sep 2019 17:21:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:21:24 -0700
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="191192461"
Received: from jsanto5x-mobl.amr.corp.intel.com ([10.255.93.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:21:23 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PREEMPT_RT PATCH 2/3] i915: convert all irq_locks spinlocks to
 raw spinlocks
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
In-Reply-To: <20190903080335.pe45dmgmjvdvbyd4@linutronix.de>
Date:   Mon, 16 Sep 2019 14:21:22 -0700
Cc:     Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.com,
        tglx@linutronix.com, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9EF2695D-3FBD-40E0-BE8A-EB71AF4155A5@linux.intel.com>
References: <20190820003319.24135-1-clark.williams@gmail.com>
 <20190820003319.24135-3-clark.williams@gmail.com>
 <20190903080335.pe45dmgmjvdvbyd4@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



> On Sep 3, 2019, at 1:03 AM, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> On 2019-08-19 19:33:18 [-0500], Clark Williams wrote:
>> From: Clark Williams <williams@redhat.com>
>> 
>> The following structures contain a member named 'irq_lock'.
>> These three locks are of type spinlock_t and are used in
>> multiple contexts including atomic:
>> 
>>    struct drm_i915_private
>>    struct intel_breadcrumbs
>>    strict intel_guc
>> 
>> Convert them all to be raw_spinlock_t so that lockdep and the lock
>> debugging code will be happy.
> 
> What is your motivation to make the lock raw?
> I did the following:
> 
> void intel_engine_signal_breadcrumbs(struct intel_engine_cs *engine)
> {
> -       local_irq_disable();
> -       intel_engine_breadcrumbs_irq(engine);
> -       local_irq_enable();
> +       if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
> +               intel_engine_breadcrumbs_irq(engine);
> +       } else {
> +               local_irq_disable();
> +               intel_engine_breadcrumbs_irq(engine);
> +               local_irq_enable();
> +       }
> }
> 
> and lockdep was quiet (+ ignoring/patching the lockdep-irq-off-asserts).
> The local_irq_disable() is here (my interpretation of the situation)
> because that function is called from process context while the remaining
> callers invoke intel_engine_breadcrumbs_irq() from the interrupt
> handler and it acquires irq_lock via a plain spin_lock().  That
> local_irq_disable() would be required if everyone did a _irqsave().

I’ve tested this also on the v5.2.14-rt7 and can confirm that it avoids the need for making the locks raw.

Tested-by: Sean V Kelley <sean.v.kelley@linux.intel.com>

Thanks,

Sean

> 
> I tried to check how much worse the latency gets here but I didn't see
> anything in a brief test. What I saw however is that switching to
> fullscreen while playing a video gives me ~0.5 to ~2ms latency. This is
> has nothing to do with this change, I have to dig deeper… It might be
> one of the preempt_disable() section I just noticed.
> I would prefer to keep the lock non-raw unless there is actual need for
> it.
> 
> Sebastian

