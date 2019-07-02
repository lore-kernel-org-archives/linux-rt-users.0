Return-Path: <SRS0=UpHf=U7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64705C06510
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 11:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A08721473
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 11:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Mr/LFjeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGBLkc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:40:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43270 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBLkc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Jul 2019 07:40:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id q10so6867373otk.10
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Jul 2019 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UZfV2K+vRYovbEmc4xW7M1m9m9UVMdISiH4IGr65Si4=;
        b=Mr/LFjeFjw7cM6DFoT/rxsSW5RZSb+dKMgku3GcGQdxop8pLBt2PCjuJOGB0DnKGr8
         y+eel+EX1BM6oTsftcMzwx6/ym9BvPEAJL/nt9xVUq2HnjNO3yEGnOjbmJWAhIQoqiqG
         tlLmeztHo601FwmlOmlZcXXdyI3kS7zYxAdXSARtTSIj5FdNSNUDltufKQShSRo+/imn
         pl0PghOGttHdahEkBAbT+g0JPj7F6b3PMwkBY96PzbG1Qf1WEwBk3DCKhREmCF0YKbw0
         HzL5RDljRgCLjNekj+KA8N7aU5ViICFg9xXw9SeX8dhrCmBbSJd0b2y/hdpFt1M2ahpa
         O1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UZfV2K+vRYovbEmc4xW7M1m9m9UVMdISiH4IGr65Si4=;
        b=EIfSkOuIrXxIxzPY3DhdYBNolKBXALASn/aDAu8tGAixJy5DgEIL/sGObABoIfgwk0
         DSrFD2k43YYHTAu+QUSZckjGnT/bgs4XFYgNFdCzPOiEAAaqtnc6LBJtMqsPBAUTG9Jp
         Dj1VEEWloOcNypdGhP3Y9WZTx3JyXG0RIjrGj9ccJ2/HnzNSSZNJvBxoWbKjAl0uBzxs
         BNpOkfATFgJPtGPDrhCDxEwDUdq+gEYLl/7szx32oLj5xOJGnTeOEX84uEQe/WvdlTIl
         jwN5sdIqPg5ZryOt+n5/IMgGY8beJMeIm40vBq+Zzz9auTw6B/Q5kcpB4nL1mvLKZPdp
         PchA==
X-Gm-Message-State: APjAAAVYM8yVmY+fsHZgelxWHAZmVIKRl0lNQxzRNxG6J3ikJDqoeOxM
        HXZYB5SyyFayEHTXVbCvSTkbDg==
X-Google-Smtp-Source: APXvYqzCF2ozBteJsHr5zFDBDsymWiXtSW4SlZ6y2apRXBV5YzsVBF5ktI7w2WTAb24no37gXJLlgg==
X-Received: by 2002:a9d:4b95:: with SMTP id k21mr25701582otf.281.1562067631380;
        Tue, 02 Jul 2019 04:40:31 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:9575:16b6:1dd6:2173])
        by smtp.gmail.com with ESMTPSA id q2sm5171073oia.45.2019.07.02.04.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 04:40:30 -0700 (PDT)
Date:   Tue, 2 Jul 2019 06:40:28 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <minyard@acm.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190702114028.GE5041@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190510103318.6cieoifz27eph4n5@linutronix.de>
 <20190628214903.6f92a9ea@oasis.local.home>
 <20190701190949.GB4336@minyard.net>
 <20190701161840.1a53c9e4@gandalf.local.home>
 <20190701204325.GD5041@minyard.net>
 <20190701170602.2fdb35c2@gandalf.local.home>
 <20190701171333.37cc0567@gandalf.local.home>
 <20190701172825.7d861e85@gandalf.local.home>
 <20190702070418.h6ynkkgk6v6s3aii@linutronix.de>
 <20190702083536.vt346ysqmq6q23iz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702083536.vt346ysqmq6q23iz@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jul 02, 2019 at 10:35:36AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-02 09:04:18 [+0200], Kurt Kanzenbach wrote:
> > > In fact, my system doesn't boot with this commit in 5.0-rt.
> > >
> > > If I revert 90e1b18eba2ae4a729 ("swait: Delete the task from after a
> > > wakeup occured") the machine boots again.
> > >
> > > Sebastian, I think that's a bad commit, please revert it.
> > 
> > I'm having the same problem on a Cyclone V based ARM board. Reverting
> > this commit solves the boot issue for me as well.
> 
> Okay. So the original Corey fix as in v5.0.14-rt9 works for everyone.
> Peter's version as I picked it up for v5.0.21-rt14 is causing problems
> for two persons now.
> 
> I'm leaning towards reverting it back to old version for now…

Just to avoid confusion... it wasn't my patch 1921ea799b7dc56
(sched/completion: Fix a lockup in wait_for_completion()) that caused
the issue, nor was it Peter's version of it.  Instead, it was the patch
mentioned above, 90e1b18eba2ae4a729 ("swait: Delete the task from after a
wakeup occured"), which came from someone else.  I can verify by visual
inspection that that patch is broken and it should definitely be removed.
Just don't want someone to be confused and remove the wrong patch.

-corey


> 
> > Thanks,
> > Kurt
> 
> Sebastian
