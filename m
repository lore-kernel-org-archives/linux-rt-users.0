Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE4EC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C9061A81
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 09:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353067AbhJAJlS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:41:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56090 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352790AbhJAJlN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Oct 2021 05:41:13 -0400
Date:   Fri, 1 Oct 2021 11:39:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633081168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DD4ehTMclhwNQaExoPfU8uEQ05KO67BCb22v01Tha7s=;
        b=uMV90ruKXQNQ6ieCN8Hyyhz55Hc3ywxVT5BIgwcXrxm6Xh+Tw1zomFRMLciimdGGmQCOuF
        RA9Ry/oOqSFDZPwOFP7zt2/kcGvNIR7DNGjLX7lGxdxfwufiIFDWPD2ylg/fEVsGM6+JlR
        ypLLd++9BxvmiHAvCV6IHGokY3NVlpgnYjJLTlGLD+r4pGX9+hvRoUtR7ZoOvqUstvhraK
        4DS5xFBjOFqRrYFie+yBgHTZUaM5XOj6VjrSzCimHi5nP8z7YTyCeQUYNyRKMM9SJc1szj
        HR2NNOgwrjTcETBPsmBfXb9I4FYcgfD29cb6/D5mQkWQ2wKwT/30Dehww9P0Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633081168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DD4ehTMclhwNQaExoPfU8uEQ05KO67BCb22v01Tha7s=;
        b=erasrF5y6F8hs7mdkzHGnnywVdAbjDzaf3df2geLnKIz3g+UXFXodGaeE+PcKKh+v8YZAd
        gnPNGWserBPQSFBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.285-rt226
Message-ID: <20211001093927.d4q26bqyeh4s2iik@linutronix.de>
References: <163307726840.24858.2277036113555626320@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163307726840.24858.2277036113555626320@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-01 08:34:28 [-0000], Daniel Wagner wrote:
> Unfortunatly, I am not able to upload the patches to the usual places
> because I had to create a new gpg subkey as my old one expired. And
> now kup tells me my signature is invalid. I created a ed25519 signing
> key instead of a rsa one. Maybe this is what kup upsets. No idea and
> the security tools are helpful as always... NOT.

Did you update keyring on korg's side?
   https://korg.docs.kernel.org/pgpkeys.html

Sebastian
