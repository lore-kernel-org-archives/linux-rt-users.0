Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C774BC432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3D61002
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 13:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhH3NLl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:11:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58646 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhH3NLk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Aug 2021 09:11:40 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D07922081;
        Mon, 30 Aug 2021 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630329046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tGTT8Uu35ojObTkBX5LPhK0BXIPeAuPtnzjtpqjzEo8=;
        b=YNn5TFnoMfii1dsu8C5xD7Jgp1VGaHnG4DAky64bYO2tV2Y7QRHLbr9VQip14H36yJk0rU
        huQFHV4n/2UsV7k75sQicC+wMWhnMlVH3LcHM71ya49DgXPHInxuL4d8wcT5mgauYyCVxo
        vRPirMj1SgInYRmLm3b8mpiIsWtj7+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630329046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tGTT8Uu35ojObTkBX5LPhK0BXIPeAuPtnzjtpqjzEo8=;
        b=5eIs1cGTB2tfT2wQDhRRKm6tpCACbGHuRr4o4w9L8RKfDqva1E29FtH5WF/VG82wRQt+hJ
        +mBQZGAT77gJbzCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F1F29136F2;
        Mon, 30 Aug 2021 13:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id BM3EOtXYLGFXcAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 30 Aug 2021 13:10:45 +0000
Date:   Mon, 30 Aug 2021 15:10:45 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 1/1] rt-numa: Use sched_getaffinity() instead
 of pthread_getaffinity_np()
Message-ID: <20210830131045.jshul4pn53ondn3s@carbon.lan>
References: <20210719081505.520-1-dwagner@suse.de>
 <20210719081505.520-2-dwagner@suse.de>
 <c85f2cf8-4c30-3171-223-b6a95853637a@redhat.com>
 <20210829195824.y6sxfey2hazr2mko@beryllium.lan>
 <6293e08b-6147-eaf6-a53-b8d55a1a8172@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6293e08b-6147-eaf6-a53-b8d55a1a8172@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Mon, Aug 30, 2021 at 08:54:18AM -0400, John Kacur wrote:
> I hadn't planned on doing so, but I can do so if it will help you out.
> I can probably get to this, this afternoon my time, or if not, then 
> tomorrow.

Great. Thanks!

> Could you provide a link to LAVA again so I don't have to go looking for 
> it.?

  https://github.com/Linaro/test-definitions

and the main script for cyclictest is here:

  https://github.com/Linaro/test-definitions/tree/master/automated/linux/cyclictest

There is the 'bin' folder which contains a static build binary. I know,
this is a bit strange. I'll try to argue with upstream and see if we get
this dropped eventually. But for this update I'd like to get the JSON
output feature enabled first and not get lost in the discussion why the
static build binary should be dropped.

BTW, I've queued the JSON changes in my tree:

  https://github.com/igaw/test-definitions/tree/rt-tests-json

I think I could get this ready before Plumbers, so that we can discuss
the next steps during a MC/BoF.

Thanks,
Daniel
