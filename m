Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CBDC47404
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 16:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA65221479
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 16:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJP2mZem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfJGQ4W (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:56:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36411 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJGQ4V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 12:56:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so14478500ljj.3;
        Mon, 07 Oct 2019 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vaELxiihZwVaZ9gCBpTdWv4gOGKgzjm/uuHxaUYwC04=;
        b=LJP2mZemdY9KOK7GDAGq7h/1q6uXrS1J9FjX8DxKpkfE+tJNhxM5n+wqv6jrBTOTYu
         jVDI4JPqvlX00yLU81adipouy20UvHlY5WfBGu8BGMTWPJ+BGyFDqNAHz9tqMDQatQPJ
         a3EKde0mosh2zcIZ1XrSeUl73d7/6qP1G0V2ndYzvC/C54jHbadWbX3U1Gn8LG/tT0xF
         7pUiHnnW1tKFHkdEvi66Tt6ChuhdvIhjKO38on1cobJH+HnyxRGwuCILwybgzIALMKgX
         YQfJSts08MtS2eTLiHLEAY4/jyiRR/48MAkGTiGvd1l5Kux3Gi/RnreYF7Q8a6v0LRox
         XsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vaELxiihZwVaZ9gCBpTdWv4gOGKgzjm/uuHxaUYwC04=;
        b=tu5Zr62tnPGOFelni26vcwwlxBySjOlZ46KDqE/qRN/nJa0T21KEjz3hGyRBRtwXKi
         XrjaxhfvLWMYjrdTkhsfR/5VgPl+PLgUMuyy+EyuhaoU2Ibe0f+Iv95ZInr5MLfRDyWv
         MgU0anohpHwbVwctBKGJLXwH/2DSzvOuliGZ9iLwhk9egYK7vZAVgF7c7tTLj/IXsQIC
         FXjSPUS9/4XZCbfQYDsRtT6RyQf2BLCoDS7dbYWhgRIOoLnwdJV3FJxPrNQUPO+rWnq5
         +gQLor2eNmdG7By92ygAbCxbZYqdwAFfxJLctPuNrc09l45tc6favrBwwa/SGQPxWUSN
         4/XA==
X-Gm-Message-State: APjAAAU337HZeBbXq+fGHYjHNSPns1zdscpDpMm0fB+hdIoXhMTzBYKZ
        HcWt4H6IWJ3n/hcRpMdXdbk=
X-Google-Smtp-Source: APXvYqxMEPQq+dtQC7I9n4r07StalazVfzisHmXEuezRiLDIap5Zhaui0KO4d5OHCF2QtwFwV6Z5RQ==
X-Received: by 2002:a2e:9556:: with SMTP id t22mr18895981ljh.97.1570467379478;
        Mon, 07 Oct 2019 09:56:19 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id o13sm3178055ljh.35.2019.10.07.09.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:56:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 7 Oct 2019 18:56:11 +0200
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191007165611.GA26964@pc636>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
 <20191007162330.GA26503@pc636>
 <20191007163443.6owts5jp2frum7cy@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007163443.6owts5jp2frum7cy@beryllium.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 07, 2019 at 06:34:43PM +0200, Daniel Wagner wrote:
> On Mon, Oct 07, 2019 at 06:23:30PM +0200, Uladzislau Rezki wrote:
> > Hello, Daniel, Sebastian.
> > 
> > > > On Fri, Oct 04, 2019 at 06:30:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > On 2019-10-04 18:20:41 [+0200], Uladzislau Rezki wrote:
> > > > > > If we have migrate_disable/enable, then, i think preempt_enable/disable
> > > > > > should be replaced by it and not the way how it has been proposed
> > > > > > in the patch.
> > > > > 
> > > > > I don't think this patch is appropriate for upstream.
> > > > 
> > > > Yes, I agree. The discussion made this clear, this is only for -rt
> > > > trees. Initially I though this should be in mainline too.
> > > 
> > > Sorry, this was _before_ Uladzislau pointed out that you *just* moved
> > > the lock that was there from the beginning. I missed that while looking
> > > over the patch. Based on that I don't think that this patch is not
> > > appropriate for upstream.
> > > 
> > Yes that is a bit messy :) Then i do not see what that patch fixes in
> > mainline? Instead it will just add an extra blocking, i did not want that
> > therefore used preempt_enable/disable. But, when i saw this patch i got it
> > as a preparation of PREEMPT_RT merging work.
> 
> Maybe I should add some background info here as well. Currently, I am
> creating an -rt tree on v5.3 for which I need this patch (or a
> migrate_disable() version of it). So this is slightly independent of
> the work Sebiastian is doing. Though the mainline effort of PREEMPT_RT
> will hit this problem as well.
> 
> I understood Sebiastian wrong above. I thought he suggest to use the
> migrate_disable() approach even for mainline. 
> 
> I supppose, one thing which would help in this discussion, is what do
> you gain by using preempt_disable() instead of moving the lock up?
> Do you have performance numbers which could justify the code?
>
Actually there is a high lock contention on vmap_area_lock, because it
is still global. You can have a look at last slide:

https://linuxplumbersconf.org/event/4/contributions/547/attachments/287/479/Reworking_of_KVA_allocator_in_Linux_kernel.pdf

so this change will make it a bit higher. From the other hand i agree
that for rt it should be fixed, probably it could be done like:

ifdef PREEMPT_RT
    migrate_disable()
#else
    preempt_disable()
...

but i am not sure it is good either.

--
Vlad Rezki

