Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC7C6FD1C
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Mar 2023 16:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCVQlg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVQle (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2023 12:41:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4235B431;
        Wed, 22 Mar 2023 09:41:33 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:41:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679503291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H35Xn4Ez1Llei0rXrSUFk/V7AalLs0NT9SOJ/A81a2U=;
        b=r6o3xs/Z6PN3egyrQF6DPRWVMslm2ov0b9cRfWormubdWVKx44grqdkMMgYLHYphPakCZB
        dwM08h4Q8FzPUc2ANedG7KgcSLcZhtgBxkXojEX0fAYwzukpUrQkfvsBhEfDHhXB1ADmki
        WVojNxI1yrQGYprFG9TTgJST1gKx1hOtzrYr8C/pid4i1xIlGOheQ7mZQt8uwl74l1RExv
        I11GX+XCGlLGOJUIMYcANIp9q52ho2to1wvZXa8umS653I5FTsVVuGZyE19S9GX+pmniSL
        fkFxQDkLgLpcoBZsrPhkMq/U3y8J3ze/3aha0E3YZN8c/2yhKvqYzeZkRWeFdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679503291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H35Xn4Ez1Llei0rXrSUFk/V7AalLs0NT9SOJ/A81a2U=;
        b=Mc3cwGOksNaGs4LGYzu/pNVK+cNcOKaKmo0NremMVJ4ESLCRaWt4dbSavfHsBph8G90WUY
        70UGpfNAbTVBFjCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Crystal Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
Message-ID: <20230322164130.CmC_J49n@linutronix.de>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
 <Y+47FVJ+hI+NA2In@linutronix.de>
 <87k00cr7ix.ffs@tglx>
 <Y/NT1/ynarp9cDlS@linutronix.de>
 <Y/NcnrwKr2u6tamQ@linutronix.de>
 <874jrgqjsw.ffs@tglx>
 <84c1de84ac129de7c7597c48d3ec19ccc0672492.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84c1de84ac129de7c7597c48d3ec19ccc0672492.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-03-04 23:39:57 [-0600], Crystal Wood wrote:
> > This still leaves the problem vs. io_wq_worker_sleeping() and it's
> > running() counterpart after schedule().
> 
> The closest thing I can see to a problem there is io_wqe_dec_running()->
> io_queue_worker_create()->io_wq_cancel_tw_create()->kfree(), but that only
> happens with func == create_worker_cont(), and io_wqe_dec_running() uses 
> create_worker_cb(). 

So we may good then. The while loop in io_wq_cancel_tw_create() worries
me a little. I am not sure if only the submitted work gets cancel or
maybe other as well, including the one leading the kfree. 

> Are there any workloads I could run to stress out that path (with my
> asserts in place)?

None that I can think of. Maybe something from the io-ring test suite.
But then you may need to bend to code to get the task_add() to fail.
Maybe Jens knows something.

> -Scott

Sebastian
