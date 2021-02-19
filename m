Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD99BC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9525C64E60
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 17:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBSRIP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhBSRIN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 12:08:13 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC1C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 09:07:33 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t21so956966qtr.10
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=r5pHHLSTCGu+OUQvfRqYcMTIbusItlUGqimP6OzNcxs=;
        b=B2MZqBZxrwaZfyRITXLV+6Q82ZsXOgZ+fwJoMZPtyqKXNaJwzG1E5ZVh2fCy+NG0FH
         wTsZqPVvhRL6pcwrwpdFNM2V29Dt3+2/xAcj5WisV5nBeoC9Hpk5RzRyhTJ8j1q52mJ5
         0UAMysKXHcNgLIGsanEzLnmUVm5i7gJ3ESjXW3l1lgvIIL8pdFuy92lWfwc5J8bxQTm1
         H4OQ+s6aPhRIHAV4d6t3UM5AQRyFLHVo2B9AltVGEbi0cIczKk5YLM3cSnd7k50d/6LJ
         exV1sQidCSMhPxveSOyks5bMPDd1PdpeLG/bDFKmAr/fv0Ouogz37xJB2F28ajCWrNjZ
         6QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=r5pHHLSTCGu+OUQvfRqYcMTIbusItlUGqimP6OzNcxs=;
        b=lXAsFJYYyd3pikxDkVdBbm3/QV5o3ubFlJ4szorZmhBUM0gC0QTuhzZHEoleBpW+vx
         CEFMQQdYrwNqRCXN4QCikzZNiThNPVByLSWjDTUAyE5KamSWC6Sw/kbzZ2eH5df4/Lp8
         Z5waK3nRSPjcmnBW01fe5v6KPP+RVzl7KxLaArnN6eJOAQZ+a+NogPl96hFm0i3HeP4S
         7Y5r7a96sSGsZ8sjgyFjZ8hWoBKGiaCLtXK4jCvQQU/m2/7eBJMeO1FBUxXomTcIMwrv
         akxcTdZc3s93mnC63nZDEq2qCUhFsTogY4wVj72JOi+AyLSlwRsMEYuvsQ3k2cpgDAil
         6oIQ==
X-Gm-Message-State: AOAM533rygCQi+28yzLf2jxI8IONGJwhSaF5GDN0nWSMnAcQ/peZc7T2
        bgkCRXHfOJQxUoqBFOmC8fM=
X-Google-Smtp-Source: ABdhPJwmCrk5lDYzUon990VFkdeVKeEHD7+925qwjOJe7uPceP4GxcORE4+6+A5xe/YcR4tgWYh5GQ==
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr4308248qtu.183.1613754452893;
        Fri, 19 Feb 2021 09:07:32 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id r18sm5744679qtm.54.2021.02.19.09.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 09:07:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 12:07:31 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Christian Eggers <ceggers@arri.de>
cc:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
In-Reply-To: <4628381.31r3eYUQgx@n95hx1g2>
Message-ID: <b46e5efb-d1b5-53de-7be2-c3ec0dcb22@redhat.com>
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

On the other hand, this is what was working for you before the changes 
right? We required libnuma for building but not for runtime?

That would be easier to maintain.

> 
> regards,
> Christian
> 
> 
> 
> 


