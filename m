Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31EAC2B9F4
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Jun 2021 06:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922E760C40
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Jun 2021 06:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFQGnj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Jun 2021 02:43:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53746 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFQGnj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Jun 2021 02:43:39 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F8FE21ADF;
        Thu, 17 Jun 2021 06:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623912091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXAeTzp6+Hm30H9D8nun73+VXLwARz7QNknNw2o0ZNQ=;
        b=ZuYjyGDaBbNAjqDhi5r9/EnciNeZgxlxN3rf6009CKt02s5MGJNE/EHA/Uv9LatanXEFNG
        hC19QpSvmE/vLBIwOwq9m0gMvTZzrrMZNgq8KH9bBymbxE4kyFwIo0tHcu2b4D5ukTFWks
        amonoYRcgtJ7iBpHghn7V00juuziPtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623912091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXAeTzp6+Hm30H9D8nun73+VXLwARz7QNknNw2o0ZNQ=;
        b=2T4bvkEOZ9RMxQy7Y9c070XYt8SXpVytoRCuyfs96MsXZqUXPFrSmR22kRjqIqfMS3xoou
        v9gLlTBhX7UmoyAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4F898118DD;
        Thu, 17 Jun 2021 06:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623912091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXAeTzp6+Hm30H9D8nun73+VXLwARz7QNknNw2o0ZNQ=;
        b=ZuYjyGDaBbNAjqDhi5r9/EnciNeZgxlxN3rf6009CKt02s5MGJNE/EHA/Uv9LatanXEFNG
        hC19QpSvmE/vLBIwOwq9m0gMvTZzrrMZNgq8KH9bBymbxE4kyFwIo0tHcu2b4D5ukTFWks
        amonoYRcgtJ7iBpHghn7V00juuziPtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623912091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXAeTzp6+Hm30H9D8nun73+VXLwARz7QNknNw2o0ZNQ=;
        b=2T4bvkEOZ9RMxQy7Y9c070XYt8SXpVytoRCuyfs96MsXZqUXPFrSmR22kRjqIqfMS3xoou
        v9gLlTBhX7UmoyAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 1XRrEpvuymBnawAALh3uQQ
        (envelope-from <dwagner@suse.de>); Thu, 17 Jun 2021 06:41:31 +0000
Date:   Thu, 17 Jun 2021 08:41:31 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jonathan Schwender <schwenderjonathan@gmail.com>
Subject: Re: [PATCH 1/3] cyclictest: Move main pid setaffinity handling into
 a function
Message-ID: <20210617064131.nar4v5x3qmfczqsv@beryllium.lan>
References: <20210616231800.19228-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616231800.19228-1-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jun 16, 2021 at 07:17:58PM -0400, John Kacur wrote:
> From: Jonathan Schwender <schwenderjonathan@gmail.com>
> 
> Move error handling for setting the affinity of the main thread
> into a separate function.
> This prevents duplicating the code in the next commit,
> where the main thread pid can be restricted to one of
> two bitmasks depending on the passed parameters.
> 
> Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
