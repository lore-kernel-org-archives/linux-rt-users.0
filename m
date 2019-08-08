Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B5C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 06:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6582187F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 06:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfHHGrP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:47:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43650 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfHHGrO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 02:47:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so19138973wru.10
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Aug 2019 23:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NKKMOIVQqV9iFYKB9HtV58xs+QTSWgospSlaS/nYDk=;
        b=IEi/KW8ifkZKi9RqgemCWeUo9g1yQJTit1cN8+N/uMV5duA7pUJZ1QIeC5BBEMMRTu
         wM4Dxj5epHhyff6DNLVcjpCwXa1Cmju4QXt/zEC5rMLXgoOVwfXNy2YiYcZXo0Zo3ow4
         HSMNNC+mRPa/DIpqDf8prebce6dqzb28bH6jKvkbBtcm+EvuNZKM8810lFE+V3zDaWKp
         YbRGnOK1V8IGKYE3diPnARW/6Q/quyjRqw5FlJaBxj4FYYOXdHsDepiCbI+ptppvNY2a
         OS6AZ8mxew1WS2kEubcHpi6vhQyCtH0TN2bFzCLQz2eziBCRvhfCemmr7iiAf6o8BTr7
         rAjQ==
X-Gm-Message-State: APjAAAV98LLQhy0DCgfk4JKb2cXBtCvsMfxyfXXynZzo8dMrKqi5Mrvo
        1zbhDhf1qjgULdgwO377VG6Gdg==
X-Google-Smtp-Source: APXvYqwrRU3U8o/LmbRoCWTemjxrlrzgZ05EW/7Ci8indvYGKipc47Etf+6Ab3OenswtztbVM/orgw==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr14562442wrx.175.1565246832444;
        Wed, 07 Aug 2019 23:47:12 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id b15sm111856859wrt.77.2019.08.07.23.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 23:47:11 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:47:09 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RT BUG] isolcpus causes sleeping function called from invalid
 context (4.19.59-rt24)
Message-ID: <20190808064709.GC29310@localhost.localdomain>
References: <20190805100646.GH14724@localhost.localdomain>
 <20190807160725.10a554e7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807160725.10a554e7@gandalf.local.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 07/08/19 16:07, Steven Rostedt wrote:
> On Mon, 5 Aug 2019 12:06:46 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > This only happens if isolcpus are configured at boot.
> > 
> > AFAIU, RT is reworking workqueues and 5.x-rt shouldn't suffer from this.
> > As a matter of fact, I could verify that backporting the workqueue
> > rework all-in change from 5.0-rt [1] fixes this problem.
> 
> So you have backported this and it fixed the bug?

Yeah. I did backport it to a downstream kernel and the splat is gone
(plus I couldn't spot any other problems my backport might have
introduced :).

> > I'm thus wondering if there is any plan on backporting the rework to
> > 4.19-rt stable, and if that patch has dependencies, or if any alternative
> > fix might be found for this problem.
> 
> I could do it after I fix the bug with 4.19.63 merge :-/ (which may be
> related. Who knows).

Ok, thanks!

Best,

Juri
