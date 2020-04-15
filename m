Return-Path: <SRS0=USbd=57=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D15C3815B
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 13:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C06620767
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 13:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633285AbgDONe3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730130AbgDONe1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Apr 2020 09:34:27 -0400
X-Greylist: delayed 8508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 06:34:27 PDT
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F4BC061A0C;
        Wed, 15 Apr 2020 06:34:27 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOiBL-0002uX-Tp; Wed, 15 Apr 2020 15:34:23 +0200
Date:   Wed, 15 Apr 2020 15:34:23 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 0087-rcu-Use-a-raw_spinlock_t-for-kfree-batching.patch
Message-ID: <20200415133423.7mohynwqanoiqzkx@linutronix.de>
References: <20200403170443.pzm24672qo4hufcm@linutronix.de>
 <1586062423.4816.15.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1586062423.4816.15.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-05 06:53:43 [+0200], Mike Galbraith wrote:
> Hi Sebastian,
Hi Mike,

> Just a heads up wrt $subject...
> 
> I had done the same in my 5.6 tree, but then 5.7 came along, and I had
> to revisit due to 34c881745549e adding an allocation under that lock
> with irqs disabled.  The same commit that added the lock added this.
> 
> 	local_irq_save(flags);  // For safely calling this_cpu_ptr().
> 
> Whacking that instead of converting the lock cures 5.6 and 5.7 woes.

So I think you are telling me that I made the lock raw and then they
added in v5.7 a __get_free_page() call in
kfree_call_rcu_add_ptr_to_bulk() which is invoked from the free path.

This is indeed not something that made me happy. Now let me think about
this for a moment…

> 	-Mike

Sebastian
