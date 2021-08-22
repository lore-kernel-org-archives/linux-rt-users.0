Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE323C432BE
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 17:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B77E61267
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 17:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhHVRaX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 22 Aug 2021 13:30:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHVRaX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 22 Aug 2021 13:30:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3EA611FF41;
        Sun, 22 Aug 2021 17:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629653381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klW31E8dR4Zwtd4/Z1nhnP9NPAf5+HU6dD0AVNCEUT4=;
        b=jSb15gCICuza1TQgBphvIu4BuMJ7W+vGpxXnZ69l4GlX/7+Dr1hA4TKM2fxkiQItjYEs2z
        3VJ+K7UCjthae5ejJU3ZDRPMZMxQWSDqQwBJ0ppGIm49Fm2cQeWlKIYrLlMfu4xLTbKOWN
        S09aN4mQqVkD+g1LsHBfJK+NM64xcTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629653381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klW31E8dR4Zwtd4/Z1nhnP9NPAf5+HU6dD0AVNCEUT4=;
        b=EQ0YuumLo8lISKbEp98dcFjjyz9cmWkfbNfMEVD6hVJyAqrpZnZbu3A7TsL7YVUr+TY743
        Bodbo+pHmYmzcnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 232F513A9E;
        Sun, 22 Aug 2021 17:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d5crB4WJImEoQAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 22 Aug 2021 17:29:41 +0000
Subject: Re: [patch] kcsan: Make it RT aware
To:     Mike Galbraith <efault@gmx.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <dc0cb448d46f465bb0064b1c301cb0b3ab4f8492.camel@gmx.de>
 <34f1e1dadb2c3d19389427303da6ea53e321e726.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <86f35f7c-c545-d870-b36e-5d091799f54c@suse.cz>
Date:   Sun, 22 Aug 2021 19:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <34f1e1dadb2c3d19389427303da6ea53e321e726.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/22/21 6:35 PM, Mike Galbraith wrote:
> On second thought, burn both patches.  Making K[AC]SAN work with RT
> ain't worth the warts.

The stackdepot part of kasan patch will be useful at some point.
slub_debug should eventually switch to stackdepot - it almost did in
mainline already. I'll try to remember and dig that part up when needed.
Thanks.

> 	-Mike
> 

