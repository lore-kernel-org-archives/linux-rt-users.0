Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27684C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Jan 2022 09:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiAQJ5G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Jan 2022 04:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiAQJ5C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Jan 2022 04:57:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A92C061574;
        Mon, 17 Jan 2022 01:57:02 -0800 (PST)
Date:   Mon, 17 Jan 2022 10:56:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642413420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzvRqxBXdzo2fgu6tNsZvofRJReWOyHLMw9wZRQ5/Xc=;
        b=OtlhbGpKlCvuuHkiZde2l86i2OCZmhcDACPiobuw8ff0efn828P/TQF6mJsm6fuPjJ4lxM
        wlcnnmetLOXzMVs2MAdNXdKclF2VPtJQUQVGPZRCafmlyWN4aZSQMvlG2zDXgdcapqlChR
        JmcLOfVroRn6b1I3o7adW1AlR7GUl3o8ODILoRLW1dsEDDE3h4uJLUfJQyiTfMnFq3GTmM
        5zMvKgpEyG80Jj3xa9G3xC88RI8A+K4IYNjxxh2DJIZvAB15LqylFm4d5uu6pif/+noyxe
        SobfN0iVSudsgPLwQm9m5MONftP37oX5mNUfKQMUL0zx6YN+RfTiovCL2Z69KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642413420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzvRqxBXdzo2fgu6tNsZvofRJReWOyHLMw9wZRQ5/Xc=;
        b=oQ7L6ds0Nbia9Pb60r1GXCW8z+/p6LFWnyigjOKX1YknoP8fJIJuY8d658kWakKLdMevwc
        1ePV5ok6KIsjBJBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.299-rt230
Message-ID: <YeU9ahVNB8aLHoBl@linutronix.de>
References: <164232885429.16727.14256146043064078052@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164232885429.16727.14256146043064078052@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-01-17 09:36:33 [+0100], Daniel Wagner wrote:
> Hello RT-list!
> 
> I'm pleased to announce the 4.4.299-rt230 stable release.
> 
> This is just an update to the latest stable release. No RT specific
> changes.
> 
> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v4.4-rt
>   Head SHA1: 6c3d1a0e6e3f5eec61f856fa284426dc880f7bd5
> 
> Signing key fingerprint:
> 
>   5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

The uploads still stuck? You want me to ping?

> Enjoy!
> Daniel
> 

Sebastian
