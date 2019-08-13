Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E56C433FF
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA7F20840
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 13:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfHMNUB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:20:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38173 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfHMNUB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 09:20:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so1429168wmm.3
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Aug 2019 06:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s52NghQ7NeF3Ht+jwObNJp7TLBzdVRHeXL6recC2EpY=;
        b=Lo8zNRkGt4nyroa/twy0s1EP0DDSg6mhljnqX7RnJp62ZdFdO2taiCbRh7LYt60WPA
         lYAGyDWmrmPAxifERevCR0AxU6HXn4ARd3xZKgAQIWDhik4OHKkoBEnMX6+IvdG9w1O/
         Ib7Ny1D53eYqR6GhOkY64ssSH1Ob7s4cKr1oZScYLjn4csSs+yerXWGDHVIZZ7oOBII6
         kcuO2IBKF0D37VpQrWXYX4t43+nCo7c43/3hATcpInx4HWkaeCqxAV2Vu7UJP18gTc6P
         X0klHmlQOnf6+giUZvzqOrSJ51ZcFX/uQYO2RU/7qTjWjpYCEf7f57Uikr0KxKB/JG2+
         K5LA==
X-Gm-Message-State: APjAAAUMGl5OFqLcqHzRcCJt1hqA3eRsd5VL6S6t0BxPggsEO9ZA3+4g
        OB6cWD9MZNVYh6ix/MDSmW3nlA==
X-Google-Smtp-Source: APXvYqwD7cPfb0fLaT9AvChqI7gm4G4sobvA99O8eWj5zAXkuHUDriH2zxRg6z82xfANdvYWReMImQ==
X-Received: by 2002:a1c:39c5:: with SMTP id g188mr3078732wma.167.1565702399361;
        Tue, 13 Aug 2019 06:19:59 -0700 (PDT)
Received: from localhost.localdomain ([151.38.194.123])
        by smtp.gmail.com with ESMTPSA id t14sm14870951wrv.12.2019.08.13.06.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 06:19:58 -0700 (PDT)
Date:   Tue, 13 Aug 2019 15:19:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com
Subject: Re: [RT PATCH] sched/deadline: Make inactive timer run in hardirq
 context
Message-ID: <20190813131955.GC4959@localhost.localdomain>
References: <20190731103715.4047-1-juri.lelli@redhat.com>
 <20190813130934.g37ob6wr4br4rkwg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813130934.g37ob6wr4br4rkwg@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 13/08/19 15:09, Sebastian Andrzej Siewior wrote:
> On 2019-07-31 12:37:15 [+0200], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > Both v4.19-rt and v5.2-rt need this.
> > 
> > Mainline "sched: Mark hrtimers to expire in hard interrupt context"
> > series needs this as well (20190726185753.077004842@linutronix.de in
> > particular). Do I need to send out a separate patch for it?
> 
> time will show. I applied it now to my tree and will ping tglx later…

Thanks. tglx actually already applied it to tip (with a fixup):

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=4394ba872c36255d25c6bde151b061f04655ebfb

Best,

Juri
