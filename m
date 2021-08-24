Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA5C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C87761357
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhHXLPi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:15:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42038 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbhHXLPh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:15:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F2AF9220A2;
        Tue, 24 Aug 2021 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629803692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kd6+n5eUDHuqSrehRnZVetOg29gaUTkDP4Ba6jd58b0=;
        b=fMgNluZlUuc11Uki1B5O5lW5KIC2NhxT7G7XfhU7Jmn7J01gpxwsGBmqJC8gMjnt5PN3/k
        qg+8YOgdaNkx2hUUo8smxnmRghLlUiGg1kmwuPGjO4lO+CiLxpcgWieivio6JwoueO6yXX
        MTHsvwBrLWjd8LLWSjsTzUjAf2qKV5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629803692;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kd6+n5eUDHuqSrehRnZVetOg29gaUTkDP4Ba6jd58b0=;
        b=Q3uO2tq/LOMAbPwGc42Si9A/3gmJftd56xsS5ftSRknC6zwRXi5L5eTEh9bNwBC9jyyLsV
        RbLTH5jGJ/Sq6rDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DEE7D1393C;
        Tue, 24 Aug 2021 11:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8zHaNazUJGHKGAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 11:14:52 +0000
Message-ID: <b8a39e05-696a-d459-c651-a3415bc09886@suse.cz>
Date:   Tue, 24 Aug 2021 13:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [patch] mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <70cc66840bbd9446061fc40088575565d8d98e37.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <70cc66840bbd9446061fc40088575565d8d98e37.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/24/21 13:08, Mike Galbraith wrote:
> 
> local_lock_t becoming a synonym of spinlock_t had consequences for the RT
> mods to zsmalloc, which were taking a mutex while holding a local_lock,
> inspiring a lockdep "BUG: Invalid wait context" gripe.
> 
> Converting zsmalloc_handle.lock to a spinlock_t restored lockdep silence.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>

BTW, does anyone really run zswap on a RT system?
