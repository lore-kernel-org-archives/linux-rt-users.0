Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B05C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3303664E44
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBSQWF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSQWD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:22:03 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E342C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:21:23 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b14so6050561qkk.0
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2zxXlx024qoKhuCIt7mmdUCxTCwI2SOyl0d1edB2hGY=;
        b=F4Wr2O8RAq74vLQ+ehdxrgl7Tk8MhSrCo18Al76MYIJc+djhXwOaOm5AUQUlHgAyRV
         J7ko9VZpakbUQnucO8uE5HlxWPD3y02lqqVcLCpvQOV34JAWQKQ7AfoiwrqdYjUEjYeS
         PMjxAx+kmY3WvFuMUawuDzPgS2iOPe8udDjeMLMnrjn7LPeyuYor6XZYK+RUHRJm021X
         Qxavm/Ah6050b/MCPg0S9SZl8y57McOfTLfg3H6aL8+Ps1FILT7qT/dC9JRc9eYQpVqA
         q6BuA8Oi1+NbVEFWQYrNIZUnykrJMW8l/UZP41Zh4DdfZLWn6l69mDEcXdZ2yubTjFwn
         I2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=2zxXlx024qoKhuCIt7mmdUCxTCwI2SOyl0d1edB2hGY=;
        b=GXRUePXGTILJswBUZfJqZqAdIG5jj+TJV7cgVLn1ppy8d117XR852hMhkzILIsh7Xg
         E9YKP2/pNaZTP0sPJIgfNtkiqy4ezNneGM+/E3q3JV5+g2hQEOEgyix4ReQu9It+ddvz
         fDtsT2D83fWLU+NBKVv8LcdGweovNWBiORWOuffNKzVCIAxF1xn6T5uyb6tss8md1Ize
         n0Bc5lZVfMzscOTufbFUE9a5BtH2GpzCk7D9nJADRKufJLruY8BHcGYY+ayhedkie12o
         UQR3MoQtTy+P8IV5JCAuB9SUIaBpsl1m5ekXNVagOU/kdpxbhGXXexRSBqHULj3VQFnT
         da3w==
X-Gm-Message-State: AOAM533AkShz8VR/E4z9c5DSfGQYwu4SMMijEdSg1O2hYTMCeiKYFFW+
        D1Pkcy6Ko3TJCPCkqRI31/rBnLEpVknPSQ==
X-Google-Smtp-Source: ABdhPJyfF7zlzH6+0o0qO5BakFTby/Xj34ailHcgrQdBJ5L2fATRDNyRT8ee2UEY+20J43eHyZ5nMQ==
X-Received: by 2002:a37:34b:: with SMTP id 72mr10239848qkd.370.1613751682334;
        Fri, 19 Feb 2021 08:21:22 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id a145sm6554021qkc.125.2021.02.19.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:21:22 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 11:21:21 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Christian Eggers <ceggers@arri.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
In-Reply-To: <20210219161602.j7w6gwk7rao5u3ek@beryllium.lan>
Message-ID: <f06c535-f340-4b51-2c0-369d88d39236@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20210219145422.lvodigbgtymr5ajc@beryllium.lan> <20210219151717.4cqc6lhrsocebw3p@linutronix.de> <2570027.mvXUDI8C0e@n95hx1g2> <20210219161602.j7w6gwk7rao5u3ek@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 19 Feb 2021, Daniel Wagner wrote:

> On Fri, Feb 19, 2021 at 04:21:46PM +0100, Christian Eggers wrote:
> > CONFIG_NUMA is not available on ARM32:
> 
> libnuma is not happy if the kernel doesn't have the config
> option. Well, in this case we just revert the patch I suppose.
> 

Yeah, I'm not happy with this.
To be sure Daniel did a lot of good work cleaning-up some of the numa 
calls and cleaning up the somewhat artificial smp / numa divide.

That work needs to continue, but I want the ability to build cyclictest
without NUMA, and that also means we need the small helpers.

John
