Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6755C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Nov 2022 16:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiKNQp7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 11:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbiKNQp5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Nov 2022 11:45:57 -0500
X-Greylist: delayed 1167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 08:45:56 PST
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E392F014;
        Mon, 14 Nov 2022 08:45:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD446E2FD1;
        Mon, 14 Nov 2022 17:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1668444354;
        h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
         references; bh=e07aYwGXb0YQRnAR0Zm0B/N0R42SMJqw3YBe+GiJpqc=;
        b=q2YXMls6QVIpPSd7cyyp3m11GKmQlnknmJy3JKIapO9rr2XtWejI7DNKPXjBJJYaOJwykl
        gJxJIR/aQPhE567qM7qRgi/MMeBtkYKuV7SqgAaGcWYsVuMxccmnETEYCIrhib09y/otFm
        bELb2C1AyG7QlyZOM/4xpowHpU/u8zZN3PJ9Rsh12Gehb6dN5BUVks5jKuR0F4dpnSojY9
        Mj7/o6rDGsHMaGGuYDHMumvsWRqmEUgHqk2DB1eIHOEN8Ykwy2Wmzq8/gcHtESv4hWIr2R
        CmfN7uCf996KEryuAugKCs/p22sZ4XKqKmV2gOBAtIgZ0hdkjkaLA4CMAvNOOQ==
Date:   Mon, 14 Nov 2022 17:45:52 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.19.255-rt114
Message-ID: <20221114164552.jogogw726hdobunk@carbon.lan>
References: <166841697922.6047.1364424530338819464@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166841697922.6047.1364424530338819464@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Nov 14, 2022 at 05:26:21PM +0100, Daniel Wagner wrote:
> Signing key fingerprint:
> 
>   5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

I forgot to mention: I had to update my subkey, in order to verify my
tags, you need to fetch a new key from

  git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
