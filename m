Return-Path: <SRS0=K3q3=X5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93149C4360C
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 17:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787DF20862
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 17:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbfJDRp7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:45:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37500 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387790AbfJDRp7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Oct 2019 13:45:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iGReL-0008Mj-QN; Fri, 04 Oct 2019 19:45:53 +0200
Date:   Fri, 4 Oct 2019 19:45:53 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191004174553.5fk2amnp4jblc7cy@linutronix.de>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191004170411.GA31114@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191004170411.GA31114@pc636>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-10-04 19:04:11 [+0200], Uladzislau Rezki wrote:
> if another, we can free the object allocated on previous step if
> it already has it. If another CPU does not have it, save it in 
> ne_fit_preload_node for another current CPU to reuse later. Further
> we can not migrate because of:
> 
> <snip>
>     spin_lock(&vmap_area_lock);
>     preempt_enable();
> <snip>

ah right. So you keep the lock later on, I somehow missed that part.
That way it actually makes sense.

Sebastian
