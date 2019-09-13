Return-Path: <SRS0=sGjS=XI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC38C49ED7
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Sep 2019 14:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33EA20717
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Sep 2019 14:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbfIMONz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:13:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:53775 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388349AbfIMONz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Sep 2019 10:13:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 07:13:54 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="385420725"
Received: from jacubero-mobl.amr.corp.intel.com ([10.254.63.107])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 07:13:54 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [BUG RT] backtrace on v5.2.9-rt3
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
In-Reply-To: <20190913134243.3zoliue6yqfzyatl@linutronix.de>
Date:   Fri, 13 Sep 2019 07:13:53 -0700
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <67E837E1-E67B-4C49-96EF-4626CFE71954@linux.intel.com>
References: <20190830120106.301bd9f3@gandalf.local.home>
 <20190913134243.3zoliue6yqfzyatl@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



> On Sep 13, 2019, at 6:42 AM, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> On 2019-08-30 12:01:06 [-0400], Steven Rostedt wrote:
>> 
>> I'm triggering the following call splat on 5.2-rt.
>> 
>> [   63.099414] 006: BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
>> [   63.108423] 006: in_atomic(): 0, irqs_disabled(): 1, pid: 173, name: kworker/6:1
> …
>> [   63.141041] 006: Call Trace:
>> [   63.143916] 006:  dump_stack+0x5c/0x80
>> [   63.147654] 006:  ___might_sleep.cold.92+0x8d/0x9a
>> [   63.152423] 006:  rt_spin_lock+0x31/0x40
>> [   63.156332] 006:  intel_engine_breadcrumbs_irq+0x56/0x320 [i915]
>> [   63.162350] 006:  intel_engine_signal_breadcrumbs+0x11/0x20 [i915]
>> [   63.168540] 006:  i915_hangcheck_elapsed+0x199/0x420 [i915]
> …
>> [   63.309375] 006:  process_one_work+0x1e8/0x4c0
> …
>> Attached is the config and the full dmesg.
> 
> just for book keeping: Clark reported the same thing, posted patches and
> will try an alternative on Monday (as far as I'm been told). I will
> continue to reply in the other thread.
> 
> Sebastian

I was able to reproduce Clark’s earlier splat report and also test the posted patches with no issues. 
This was also the approach that Chris Wilson suggested.  I agree Steven’s issue looks to be the same, but with LPC did not have time to go back to it.

Sean
