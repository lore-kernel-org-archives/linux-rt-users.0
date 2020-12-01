Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B7C64E7B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 10:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0692080A
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 10:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dxzQhHNu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDBLxqfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgLAKan (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgLAKan (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 05:30:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D093C0613CF;
        Tue,  1 Dec 2020 02:30:02 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:29:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606818599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+mh8IiMhr9jjVGTsprtu7DC4kjlpsleCKlPdsklsk0=;
        b=dxzQhHNuiY+WE/Mf3VqgPhfFScEEbv9hmeUPWpDqyIJnfuNH76ehOaK1NKFxSleLUBcnj9
        3LenQS5u5+8P7fgYqrbiBlOlzrp3WCRRHHDOAl9yR5xcq6Da8fKl9hZUf7nFT+ayHV7+8C
        zt75fr+CssEFzO5R6VNFMrasDOSs458jP7awFd5XcA2HFIjDebaDXKVQEKC6yvfzJ24LLM
        vV+Tc+Rpc1S498kyAp2vnUSIW6XlEw2vsg6+xleMy2Jow8R9BXRPfNQbB5VyoQzA7Ew5ub
        c4Ptx0eSlucAai1Ylpw/dZJhhy9HjDuoQv0tuhg1qEttUbA5O0Pmj+0XdFfIVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606818599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+mh8IiMhr9jjVGTsprtu7DC4kjlpsleCKlPdsklsk0=;
        b=aDBLxqfNefkVgwl4hajC6l9jEZH94ouwvCI4CleXd6A/c+YCiyjMRftI4sxKH9n9xqvWG/
        BH5OV+PICLzK7RCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc6-rt13
Message-ID: <20201201102958.5gu5jjysk42q74si@linutronix.de>
References: <20201130175344.27uunqcpftzpbtle@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201130175344.27uunqcpftzpbtle@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-30 18:53:44 [+0100], To Thomas Gleixner wrote:
> Known issues
>      - It has been pointed out that due to changes to the printk code the
>        internal buffer representation changed. This is only an issue if tools
>        like `crash' are used to extract the printk buffer from a kernel memory
>        image.

I'm going to drop this in the next release. According to John, progress
has been made now that the ringbuffer changes were merged upstream:
- makedumpfile
  https://github.com/makedumpfile/makedumpfile/commit/c617ec63339222f3a44d73e36677a9acc8954ccd
  Should be part of to be released 1.6.9

- kexec-tools
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=4149df9005f2cdd2ecf70058dfe7d72f48c3a68c
  Should be part of a post v2.0.20 release.

- crash
  https://github.com/crash-utility/crash/commit/a5531b24750e7949c35640d996ea14c0587938bc
  Has been merged into the 7.3.0 development phase a few hours ago.

- Tools shipped by the kernel
  - lx-dmesg (gdb helper script) in scripts/gdb/linux
  - dmesg (gdb macro) Documentation/admin-guide/kdump/gdbmacros.txt
  will be part of the v5.10 release.

Sebastian
