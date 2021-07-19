Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADD3C12002
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 08:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CBF61175
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhGSIIm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:08:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47272 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhGSIIj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jul 2021 04:08:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA8C1201DA;
        Mon, 19 Jul 2021 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626681939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSR3arbY+/0OUGQWIObjCSP0TqxVLma/c65BS/28I98=;
        b=tfdTXgo84x8NcDMP1avsaWqUJOVM1HQo7yr+kbo+h53orGjN6CwNoAvqzxmfmfOm8N6BmI
        293Bqkzj6Wll8KiaE4ezX3aNEikIacBXHyIBTCB6zOXGcVeWGp+WCnHIzMTaNoVz7l1Dbj
        QkfcKEP+6Cfy+XVTBSkNh42yndDH7yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626681939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSR3arbY+/0OUGQWIObjCSP0TqxVLma/c65BS/28I98=;
        b=TJ1jo1Mr552tRF72QcHJ8aaLQfoNrbS5CDKtUMKyS8mcQWAJeWgSQvT5Z8SawAcTyCN46J
        FIDaBqEDs9rFkaBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C0912133D0;
        Mon, 19 Jul 2021 08:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id TDhJLlMy9WCbBwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 19 Jul 2021 08:05:39 +0000
Date:   Mon, 19 Jul 2021 10:05:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 3/3] cyclicdeadline: Fix buffer allocation
Message-ID: <20210719080539.i55zfhsssifk2kvr@beryllium.lan>
References: <20210708151827.21430-1-dwagner@suse.de>
 <20210708151827.21430-4-dwagner@suse.de>
 <64899f-ab54-4a29-73a7-32b79ab6a1e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64899f-ab54-4a29-73a7-32b79ab6a1e6@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jul 09, 2021 at 02:01:35PM -0400, John Kacur wrote:
> I applied this but there are others.

All those variables are defined as uint64_t, hence the PRIu64 is
correct.
