Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9BC636C9
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 08:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E36161181
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 08:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhGSIEb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:04:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46572 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhGSIEA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jul 2021 04:04:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DC0F201DB;
        Mon, 19 Jul 2021 08:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626681626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r83aqrTsG19aNdJ/lLU2QHd+GC28h7GfOLHYenMnxyk=;
        b=UaGw0nKjV+NDW9KNo7yxdh987iCD1yYKleO9YeepG/yUlMe8tyaV9qkym0veN8Kq44azUs
        5dSe+w94tuA/MGjYMSQk32aUyeOjtUMLkV2QfI7tvbdDoc/nF2Of+RDe9CYSYprGiyKpZW
        rCXaR8/pH8j/fQRw0p8LrYDmg4ueKwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626681626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r83aqrTsG19aNdJ/lLU2QHd+GC28h7GfOLHYenMnxyk=;
        b=LqGxQEFCWRAcwQ/8JWJy8XcUB4MkydR1URz0v8HaXaZzW8dlqvwTH2N3DO3nKEek0EdpLN
        8bPY8zbi2ycI3oDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1EA1C133D0;
        Mon, 19 Jul 2021 08:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OmImBxox9WDFBQAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 19 Jul 2021 08:00:26 +0000
Date:   Mon, 19 Jul 2021 10:00:25 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 1/3] rt-numa: Use sched_getaffinity() instead
 of pthread_getaffinity_np()
Message-ID: <20210719080025.rldl2u424payj6v3@beryllium.lan>
References: <20210708151827.21430-1-dwagner@suse.de>
 <20210708151827.21430-2-dwagner@suse.de>
 <7e1f5d9-43f3-84ea-4c87-725cea71f15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e1f5d9-43f3-84ea-4c87-725cea71f15@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jul 09, 2021 at 01:58:51PM -0400, John Kacur wrote:
> It looks okay on the surface but I would like to know where you tested.

x86_64 and armv7. FWIW, pthread_getaffinity_np() is a fancy wrapper
around sched_getaffinity():

  https://github.com/bminor/glibc/blob/master/nptl/pthread_getaffinity.c#L34

> Also, in your message you explain that you can't do a static build
> but we never made static builds a requirment for rt-tests.

So you are saying static builds are not supported at all?

> I know from
> your cover letter than you are trying to do something with arm, if this
> is your motivation you should put it in your message. Even if this is your 
> motivation is there a reason we have to have a static build there?

Sure thing, I'll add more to the commit message. I just find it strange
that you are starting to argue static builds are not supported. This is
very handy especially since the linker dependency on libnuma. I can drop
the binary on the target without the need to install libnuma into the
rootfs. It is not available on all distro for armv7.

Another user of static builds is the LAVA test suite. It ships the
rt-tests programs as static builds so that the test can run without the
need to pre populate the rootfs with the correct binary:

  https://github.com/Linaro/test-definitions/tree/master/automated/linux/cyclictest/bin
  https://github.com/Linaro/test-definitions/blob/master/automated/linux/cyclictest/cyclictest.sh#L41

I am not really a big fan of this either and wont defend it. I am just
listening existing users.

> Finally, you put "fixes f240656b056b", it is useful to know where this
> was introduced in trying to figure out whether we can really replace a 
> pthread call with the sched call, but then phrase it that way, because
> as far as I know that commit is not a problem needing fixing, so put
> "pthread_getaffinity_np call introduced in f240656b056b"
> or something like that.

From my POV it is fixing a bug. If you decide static builds are not
supported, please say so. This allows me to discuss this issue with the
LAVA folks.

Thanks,
Daniel

