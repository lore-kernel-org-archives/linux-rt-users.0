Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DBEEB64DC
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Jul 2023 15:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGCPaK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGCPaI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Jul 2023 11:30:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29716E67
        for <linux-rt-users@vger.kernel.org>; Mon,  3 Jul 2023 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688398207; x=1719934207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uyGwRS+nY7W/8//fBcX/32H/jEj3LS6U/pum37IbKPw=;
  b=ijkeHTvYNVn20SsYcMm4aZw3QCOCVCaR1YL9QZRaQ5OUoGYH/o1/E1c+
   HOUYy7c0Xcx3/HDUfbQBoMGOvImZHyr975PUKO3sYNZIR5FkyLMD27doT
   5ZFrx1LeUz0WJGkad40nYf52wMW3W9eGepUolCpIG8cgW7ZUHVq3moKgU
   UGtx8ade520nV7NYr6AUMdID1czj0dfU5IlGUTx/lW47O5EFvaHY8rkil
   NtxbkXmvqOUhIWEN3K+WcBNsAkRpNONZY6d2dlSOTAuaZsIZQ0qyiNjLw
   kvRpIuaTtAukqkt5eP2KMwUMCwtumzNGQYx4yS6hBxWlV6M/p3wWXcVi4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366394168"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="366394168"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 08:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892574979"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="892574979"
Received: from dryan13-mobl.ger.corp.intel.com (HELO [10.213.232.206]) ([10.213.232.206])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 08:30:03 -0700
Message-ID: <5af9b5cb-2342-8de3-07f2-86f2be6201eb@linux.intel.com>
Date:   Mon, 3 Jul 2023 16:30:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] tentative fix for drm/i915/gt regression on preempt-rt
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-rt-users@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230630130949.coN0sVU4@linutronix.de>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230630130949.coN0sVU4@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Hi,

On 30/06/2023 14:09, Sebastian Andrzej Siewior wrote:
> On 2023-06-22 20:57:50 [-0400], Paul Gortmaker wrote:
> [ longer report about what is broken.]
> 
> Commit ade8a0f598443 ("drm/i915: Make all GPU resets atomic") introduces
> a preempt_disable() section around the invocation of the reset callback.
> I can't find an explanation why this is needed. There was a comment
> saying
> | * We want to perform per-engine reset from atomic context (e.g.
> | * softirq), which imposes the constraint that we cannot sleep.
> 
> but it does not state the problem with being preempted while waiting for
> the reset. The commit itself does not explain why an atomic reset is
> needed, it just states that it is a requirement now. On !RT we could
> pull packets from a NICs and forward them other NICs for 2ms.
> 
> I've been looking over the reset callbacks and gen8_reset_engines() +
> gen6_reset_engines() acquire a spinlock_t. Since this becomes a sleeping
> lock on PREEMPT_RT it must not be acquired with disabled preemption.
> i915_do_reset() acquires no lock but then has two udelay()s of 50us
> each. Not good latency wise in a preempt-off section.
> 
> Could someone please explain why atomic is needed during reset, what
> problems are introduced by a possible preemption?

Atomic requirement from that commit text is likely referring to removing 
the old big sleeping mutex we had in the reset path. So it looks 
plausible that preempt_disable() section is not strictly needed and 
perhaps motivation simply was, given those 20-50us polls on hw registers 
involved, to make them happen as fast as possible and so minimize visual 
glitching during resets.

Although that reasoning would only apply on some hw generations, where 
the irqsave spinlock is not held across the whole sequence anyway.

And I suspect those same platforms would be the annoying ones, if one 
simply wanted to try without the preempt_disable section, given our 
wait_for_atomic macro will complain loudly if not used from an atomic 
context.

But I think we do have a macro for short register waits which works with 
preempting enabled. I will try and cook up a patch and submit to our CI 
during the week, then see what happens.

Or even moving the preempt_disable down so it just encompasses the 
register write + wait. That would then be under the spinlock which is 
presumable okay on RT? (Yes I know it wouldn't' solve one half of your 
"complaint" but lets just entertain the idea for now.)

Regards,

Tvrtko
