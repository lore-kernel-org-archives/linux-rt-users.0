Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C0FC2B9F4
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Jun 2021 06:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F517613D5
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Jun 2021 06:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQGpE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Jun 2021 02:45:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54114 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhFQGpE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Jun 2021 02:45:04 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43E0921A90;
        Thu, 17 Jun 2021 06:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623912176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlOILA7jsNh5twa7+cPUkRbacNU/rdVVlnPtbAv6zRs=;
        b=qaivZVfld7nYISEp4o12HjZl8Lv/qxccCUoZiheLqv6D6K4cLZCZ1Uzx7vru9rDjZunhOP
        /zoNhqn9JEAvJu0HEztLVA2XxEPFQqhELMemwiE8MUjlgboH4iYjT1jb6JnkQMu9xK7GwN
        FUW1bmV+WyxrEdrfoPce29KNOUB3jaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623912176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlOILA7jsNh5twa7+cPUkRbacNU/rdVVlnPtbAv6zRs=;
        b=tQrxV0AL4ac3ufTYsqpdiRowdMuP/zLvPCHp0gTMkVOGwjsYuRUix5EKDFmpYcELuf/dJo
        ZvqZWUcex8ICnxBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 295A3118DD;
        Thu, 17 Jun 2021 06:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623912176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlOILA7jsNh5twa7+cPUkRbacNU/rdVVlnPtbAv6zRs=;
        b=qaivZVfld7nYISEp4o12HjZl8Lv/qxccCUoZiheLqv6D6K4cLZCZ1Uzx7vru9rDjZunhOP
        /zoNhqn9JEAvJu0HEztLVA2XxEPFQqhELMemwiE8MUjlgboH4iYjT1jb6JnkQMu9xK7GwN
        FUW1bmV+WyxrEdrfoPce29KNOUB3jaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623912176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlOILA7jsNh5twa7+cPUkRbacNU/rdVVlnPtbAv6zRs=;
        b=tQrxV0AL4ac3ufTYsqpdiRowdMuP/zLvPCHp0gTMkVOGwjsYuRUix5EKDFmpYcELuf/dJo
        ZvqZWUcex8ICnxBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id C3EyCfDuymDxawAALh3uQQ
        (envelope-from <dwagner@suse.de>); Thu, 17 Jun 2021 06:42:56 +0000
Date:   Thu, 17 Jun 2021 08:42:55 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jonathan Schwender <schwenderjonathan@gmail.com>
Subject: Re: [PATCH 2/3] Subject: [PATCH v4 2/2] cyclictest: Add
 --mainaffinity=[CPUSET] option.
Message-ID: <20210617064255.yreuwr57dvwond26@beryllium.lan>
References: <20210616231800.19228-1-jkacur@redhat.com>
 <20210616231800.19228-2-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616231800.19228-2-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jun 16, 2021 at 07:17:59PM -0400, John Kacur wrote:
> From: Jonathan Schwender <schwenderjonathan@gmail.com>
> 
> This allows the user to specify a separate cpuset for the main pid,
> e.g. on a housekeeping CPU.
> If --mainaffinity is not specified, but --affinity is, then the
> current behaviour is preserved and the main thread is bound
> to the cpuset specified by --affinity
> 
> Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
> - Little fix-up applying patch
> Signed-off-by: John Kacur <jkacur@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

