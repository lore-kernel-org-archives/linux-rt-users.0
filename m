Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B697C6FD1C
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Mar 2023 20:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCTUBX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCTUBV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Mar 2023 16:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ECC24729
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Mar 2023 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679342418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VLdKgj4+WVR+d9i0P6IUaXA9yjHWXiqkGmOulRR5eEk=;
        b=DC7TMwVhZPpqw/B782uAqmrOuO+U9iZ+BbI/CJZJlAWiLWFBL6bNwK/1HRORrLDTQ3SPxA
        G+opSb3CJQu/azIyjgf8+Lp5cIoBnc7yF3ajw9cXQu2UvHT3RLy0KBStLHmqP4myVuS+VS
        M5W7sUjxAN82V/APIcIj6kEv084wDYQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-oAwANaBLOzWrhjRM7RjbCg-1; Mon, 20 Mar 2023 16:00:14 -0400
X-MC-Unique: oAwANaBLOzWrhjRM7RjbCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32EBC1C0432C;
        Mon, 20 Mar 2023 20:00:14 +0000 (UTC)
Received: from localhost (unknown [10.22.11.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D27841121319;
        Mon, 20 Mar 2023 20:00:13 +0000 (UTC)
Date:   Mon, 20 Mar 2023 17:00:13 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.10.162-rt78] Restore initialization of
 wake_q_sleeper.next in fork.c
Message-ID: <ZBi7TbNgBAZL6tdw@uudg.org>
References: <20230320193731.GA36840@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320193731.GA36840@zipoli.concurrent-rt.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Mar 20, 2023 at 03:37:31PM -0400, Joe Korty wrote:
> In the transition from 5.10.158-rt77 to 5.10.162-rt78,
> the initialization of task_struct::wake_q_sleeper.next
> was dropped.  Restore it.
> 
> This appears to be only a problem in 5.10.  5.15 does not
> have wake_q_sleeper; 4.19 does have it but its initialization
> there is still present.
> 
> The 5.10.162-rt78 patch that damaged fork.c is:
> 
>    0170-locking-rtmutex-add-sleeping-lock-implementation.patch
> 
> I do not have a simple test that brings out this problem.
> My test consists of a shell script and eight binaries,
> all of which were written in Ada.  strace shows that it
> does a few thousand forks in rapid succession.  One of the
> forks stalls out, after which no fork after that returns.
> Eventually the 122 second stallout occurs and a large
> number of threads are shown to be waiting for tasklist
> lock, either in do_exit or in copy_process.  The kernel
> .config has rt and many debug features enabled, lockdep
> included.

Joe, thank you for investigating that problem and for writing a patch.

Earlier today Steffen Dirkwinkel sent a similar patch:

    https://lore.kernel.org/all/20230320080347.32434-1-linux@steffen.cc/

Would you mind giving your ACK to his patch? I have that patch queued for
my next build already.

Thank you,
Luis
 
> Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com
> 
> Index: b/kernel/fork.c
> ===================================================================
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -960,6 +960,7 @@ static struct task_struct *dup_task_stru
>  	tsk->splice_pipe = NULL;
>  	tsk->task_frag.page = NULL;
>  	tsk->wake_q.next = NULL;
> +	tsk->wake_q_sleeper.next = NULL;
>  	tsk->pf_io_worker = NULL;
>  
>  	account_kernel_stack(tsk, 1);
> 
---end quoted text---

