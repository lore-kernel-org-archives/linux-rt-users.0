Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7A9C433E9
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0382B64EAF
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBSQko (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBSQkj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:40:39 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740E2C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:39:59 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z6so3794877qts.0
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=sht7JQee7p8IAhhZyx41Qdaglmcmlo7v9coc/wZ3pXI=;
        b=svQTl9kfPrTUTkm9+3jU/k7F/F+4+RNnoQ0YYKQN1aEXR++wLRARCU8doDLvjFEekQ
         Yzv1/TcOm8VDkhhVX0+MiW/i11GOlfcyh9B/FdhqiCfvEDKSIJ6VvdqZ8A0CIM/xVF/P
         LJC224W2fz82I1Udr3xZVEbzD3Hk3nkr+DBPbqFOz5CApqG+dDbnGWhMqARbXOP92I9+
         UMELofmiUQH0Pt61HT9bVGHZ24nyGNYmkbFIWheA/eoUxydZz9sqdiIOcion4GJ0lzG0
         5MWZhfs/Fu8l80Crse0IbmKT1vT/e9wApodued8ZzGv4a/Escr83p3uODFtO5aEEK3Yj
         DPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=sht7JQee7p8IAhhZyx41Qdaglmcmlo7v9coc/wZ3pXI=;
        b=YLoPyDiVWgjpsYidCsDSDiWbhxTKfztGZLk0kWDUCNA4jKK8cKE/n2a5IxYrraH3qI
         s5uJ7ALcEVUCjb1TVcj2i7JSeluODTDVUND9KSp4CK4EJmzpYJtnxHNy9m6GzXb3/d2E
         cEROsCgDan2UP00DQJmczIjbHHGwdVPEYMHjWUOIq/Iq0nvF0zUgTz63y+KPy3RmgajU
         R/KPTkjDIsMlt79AWvEHR9Sd5klT6LCoFUm/yOw52YSAxsTsfRriXMaZEWV4iHBscP5a
         DoRRtPiXsCipanp+Pp+k51WF2/XTcSpgexRsuauzQH5eW557UUwIDlmCrzic9078ENqC
         TJdw==
X-Gm-Message-State: AOAM5301ACUUNn/KiInS3M1UBRmU5nUQaOKxALGlwyhwBNAzpbri6K7v
        LqrNs1K8I6oxre2dZW7wA6sglC6ABHa6MoWD
X-Google-Smtp-Source: ABdhPJzaHzVwNFWBo0yC/ttXe1Je0ehgJOT+OR7MNyXwxxjDfv52h25VkaJU6y9aXxzvbR/EiN62gg==
X-Received: by 2002:a05:622a:42:: with SMTP id y2mr9478086qtw.186.1613752798709;
        Fri, 19 Feb 2021 08:39:58 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id k8sm6602095qkk.81.2021.02.19.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:39:58 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 11:39:57 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Christian Eggers <ceggers@arri.de>
cc:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
In-Reply-To: <4628381.31r3eYUQgx@n95hx1g2>
Message-ID: <5c58b78a-7f63-88f3-2c3e-1c99e4b15890@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20210219161602.j7w6gwk7rao5u3ek@beryllium.lan> <f06c535-f340-4b51-2c0-369d88d39236@redhat.com> <4628381.31r3eYUQgx@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 19 Feb 2021, Christian Eggers wrote:

> On Friday, 19 February 2021, 17:21:21 CET, John Kacur wrote:
> > 
> > On Fri, 19 Feb 2021, Daniel Wagner wrote:
> > 
> > > On Fri, Feb 19, 2021 at 04:21:46PM +0100, Christian Eggers wrote:
> > > > CONFIG_NUMA is not available on ARM32:
> > > 
> > > libnuma is not happy if the kernel doesn't have the config
> > > option. Well, in this case we just revert the patch I suppose.
> > > 
> > 
> > Yeah, I'm not happy with this.
> > To be sure Daniel did a lot of good work cleaning-up some of the numa 
> > calls and cleaning up the somewhat artificial smp / numa divide.
> > 
> > That work needs to continue, but I want the ability to build cyclictest
> > without NUMA, and that also means we need the small helpers.
> 
> Just for clarification: Does this mean that cyclictest shall link against
> libnuma (libnuma can be built on ARM without problems), but not call it
> functions at runtime?
> 
> From the numa.h:
> 
> /* NUMA support available. If this returns a negative value all other function
>    in this library are undefined. */
> int numa_available(void);
> 
> regards,
> Christian

We used to be able to build cyclictest without libnuma.
The small helpers that wrapped the calls to numa contained versions
without numa calls. Most people did have libnuma, so we were requiring 
libnuma say on x86_64.

I think at some point before Daniel starting removing the wrappers this
support was broken.

So, I mean the ability to build cyclitest without libnuma at least
on some architectures.

John
