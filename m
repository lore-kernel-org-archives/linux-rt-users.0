Return-Path: <SRS0=V7AE=TP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2474CC04E53
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 May 2019 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FD620881
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 May 2019 16:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="uOrgnAPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEOQWS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 May 2019 12:22:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40885 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEOQWR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 May 2019 12:22:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id u11so555506otq.7
        for <linux-rt-users@vger.kernel.org>; Wed, 15 May 2019 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WYwUsFSH86jSsfL1qchJ6LUvivM63x63FlzlKbdmfas=;
        b=uOrgnAPc8uE+qBTcPGAZ/2bMJlapwUBTljMhCFiyEwWUGqnQvxXHV8F+8obCeEJm8s
         4YEBF0qNhKDuYxgiEBDbbH6EhCxggKc1eEW4sDFugrOG2PktbT5uc67ibB2sLTrcPf+5
         ZhSA3Ngg82GvDbiMSF0TfjCxvmNMjxxAn2XNp3eOw4nhOFt9CDOK010JZ0FTXf2jMdFR
         NOlzt+CwucWaXURdPwb34To7dVoBPfvl45gkPIpLbI3iacAWIKZ//joKraLZuIchN8It
         LQY55M8O5+xi3GZO/972ZZM7qsHCyEvyUDOEBFPoUSvVfj8cTfhWkg7X6MFdUOSrPYNd
         IzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WYwUsFSH86jSsfL1qchJ6LUvivM63x63FlzlKbdmfas=;
        b=NYuTCBDGzaQW/PGm8hOMVZXixP/MgPC2tCEWYI90fGvQKuZJFGcsK/QpvUAQ8I0WM/
         Pz95ujWM3QxijVqsarPfmzkcwnyijRl8Y5GWkr+nQMUpgETaPRlF+txtknZ+sl0bnsA4
         GgcZe8Vohwh5/PqFCZr5ABVq68E+dOXrxmt4sLjH78aWIytA2+JrnaCAVgmnmwEohuuJ
         uJAau3M0lP9x8WR0AP41oYOj5pO4Nbbrnm890bQYjDDZM+SrpRfuYCxLiygu2kgbjyqG
         R5fBuIdS5SI0GwcH3UZILFyhaM/F3/VuBhuFZPBht6MzNiaftSwqt3SlfOiVifikpTGU
         C9CA==
X-Gm-Message-State: APjAAAUcApIL4Z5MXuwpxTCLLctcTgkaNwVAcB1Xbf8VGOpwHiBRpv4Z
        XhzTfdPxzltTxP0LKhBDctM2Wg==
X-Google-Smtp-Source: APXvYqx9YX6jALD3ezMYYUSQ97jbTW9srhfNABwloH1YvDooZkHcqR7PZkAP4Lndj8fbIzC9xyZS+w==
X-Received: by 2002:a9d:7657:: with SMTP id o23mr26614794otl.358.1557937334761;
        Wed, 15 May 2019 09:22:14 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:9c84:ae86:ff6:562c])
        by smtp.gmail.com with ESMTPSA id r23sm885582otg.49.2019.05.15.09.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 09:22:13 -0700 (PDT)
Date:   Wed, 15 May 2019 11:22:12 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, minyard@acm.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190515162212.GB6050@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
 <20190514091219.nesriqe7qplk3476@linutronix.de>
 <20190514121350.GA6050@minyard.net>
 <20190514153647.wri6ivffbq7r263y@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514153647.wri6ivffbq7r263y@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, May 14, 2019 at 05:36:47PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-05-14 07:13:50 [-0500], Corey Minyard wrote:
> > > Corey, would it make any change which waiter is going to be woken up?
> > 
> > In the application that found this, the wake order probably isn't
> > relevant.
> 
> what I expected.
> 
> > For other applications, I really doubt that very many are using multiple
> > waiters.  If so, this bug would have been reported sooner, I think.
> 
> most other do either one waiter/waker pair or one waker and multiple
> waiter. And then reinit_completion() is used for the next round.
> 
> > As you mention, for RT you would want waiter woken by priority and FIFO
> > within priority.  I don't think POSIX says anything about FIFO within
> > priority, but that's probably a good idea.  That's no longer a simple
> > wait queue  The way it is now is probably closer to that than what Peter
> > suggested, but not really that close.
> > 
> > This is heavily used in drivers and fs code, where it probably doesn't
> > matter.  I looked through a few users in mm and kernel, and they had
> > one waiter or were init/shutdown type things where order is not important.
> > 
> > So I'm not sure it's important.
> 
> Why did you bring POSIX into this? This isn't an API exported to
> userland which would fall into that category.

My understanding is that POSIX.1b scheduling classes affect everything.
So if you have two processes blocked on the same things for any reason,
you need to wake up the higher priority one first.  In reality, it
probably doesn't matter unless something more critical uses completions. 

> 
> Peter's suggestion for FIFO is that we probably don't want to starve one
> thread/waiter if it is always enqueued at the end of the list. As you
> said, in your case it does not matter because (I assume) each waiter is
> equal and the outcome would be the same.

Yeah, my case is not relevant to this, I'm more concerned with the cases
that are.

-corey

> 
> > -corey
> 
> Sebastian
