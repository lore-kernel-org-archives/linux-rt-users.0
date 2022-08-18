Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC12C00140
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Aug 2022 18:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbiHRS70 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Aug 2022 14:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345264AbiHRS7Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Aug 2022 14:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B32EBFC79
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Aug 2022 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660849162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGb9AUD76XSe+9n25olXgP8J31+p67LHtLCVbcvi+vk=;
        b=ObCbwyMa1Lfm4I1p2gSKEwBDfNYItVzhQcx9D2rJYVYBsPQBr/5OXHvjy3r+YMDWdcLLfD
        bVJ1dqr0+YMUV+ZmoNovoDPJ0bSBKeKKocPdXHpaO/j8c7+H1qNY2H7Qt/A6fQIsuOOg8j
        Rd64h6OgxzYqLkzJtyOntg1QI3xP8io=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-AZpQlQbzPEiLEdtn3aT2zQ-1; Thu, 18 Aug 2022 14:59:21 -0400
X-MC-Unique: AZpQlQbzPEiLEdtn3aT2zQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B75461824603;
        Thu, 18 Aug 2022 18:59:20 +0000 (UTC)
Received: from localhost (unknown [10.22.16.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BD4740CFD05;
        Thu, 18 Aug 2022 18:59:20 +0000 (UTC)
Date:   Thu, 18 Aug 2022 15:59:19 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Yajun Deng <yajun.deng@linux.dev>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.10-rt] locking/rtmutex: switch to EXPORT_SYMBOL() for
 ww_mutex_lock{,_interruptible}()
Message-ID: <Yv6MB4bj9xpDtF+O@uudg.org>
References: <20220803062430.1307312-1-yajun.deng@linux.dev>
 <Yv5ppS3wDbKFs9tv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv5ppS3wDbKFs9tv@linutronix.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 18, 2022 at 06:32:37PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-08-03 14:24:30 [+0800], Yajun Deng wrote:
> > We can use EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL() in
> > ww_mutex_lock_interruptible() and ww_mutex_lock(). That match
> > ww_mutex_unlock() well. And also good for 3rd kernel modules.
> 
> Not that I am fan of this but it will sync the symbols with what landed
> upstream as of commit
>    f8635d509d807 ("locking/ww_mutex: Implement rtmutex based ww_mutex API functions")
> 
> therefore it would be good to have.
> Luis?

Looks good to me. I can add that to my next update.

Luis
 
> > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> 
> Sebastian
> 
---end quoted text---

