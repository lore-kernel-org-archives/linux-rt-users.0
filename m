Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D5EC4332B
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 15:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463AB60230
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 15:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbhCDPtm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhCDPtd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Mar 2021 10:49:33 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF15AC061760
        for <linux-rt-users@vger.kernel.org>; Thu,  4 Mar 2021 07:48:52 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d20so27223505qkc.2
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Mar 2021 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4ZGEAjOAynqUKM0BY8AhhziUTRbrwYg3kFODoyA8e38=;
        b=TNpr+jirPdoGG48KBijZXB6WAaY/Z7vcgjSh5UGBXHCrF52wdhh0+75IbUpxgSsqgP
         zLQod63benjqofooF9syTEMcYiZb1HzvUGZOWMJ7Ak1hecmnbrPC5wkV53owSVunVqCx
         d6gvHngea0htM/73BQWa45U26i6dGPN/sZxf4yEQNAF9aRIJujxOOjy2WQdZbH8kMybz
         4xl1Upo+2kEYIIF0OkEwl7Jo1JRzp5DAmAPVe8VofV1k0c+JVyx+GEtuaMJMe1lHdEz0
         GELJQ5zJTP2AMj/mwQNXPsi/BpK0Bpf935Mw1u0/8iDeWSyiJUk09rUmk8nS5nQ/Wp3I
         LJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=4ZGEAjOAynqUKM0BY8AhhziUTRbrwYg3kFODoyA8e38=;
        b=n3wbZMicwCCNWAVPApMq/aV92KDmL2pWe/0TuKW0WBRoEcn1MirOHxuKMUMLeiPSFW
         GmDD9y0iI4GElgVcTDQMZOJEsoockYbYt3i1zie4dJ7Gi6q132/4aKJ7ahkGWY4u/Akq
         YPUpdBhwjMLjG3vnqW0EgZdYnGy1aMsznBo7irjh2Z8MG63WpxZxio39xXVRgBUj8PZE
         jdnT6MY0Yi7V8ffyCXN1F/5KHbaGS0jWskbDlTx/g2/U1mU17B51zM/iu6eQ0DueahPi
         yly/08agJ0eJZDY9e0IfiO7PjGseJR5NGTeIc9rKIpSxezFrjoEHS7F++h39xCaQ1xjN
         08Lg==
X-Gm-Message-State: AOAM531084AGxaK5TnsI0JlU5hmPHIwmjkOkrjIr4/1dYkKjgB8uB4ry
        Bg5HJ45anyAW25m71y6F2hg=
X-Google-Smtp-Source: ABdhPJx8FXVVBTJSwq7FNLhYAiuOap0151ADE0ImHJAIq82cxihd5dmuQuPvJmfkqHWPFAU6ouwI7w==
X-Received: by 2002:ae9:f719:: with SMTP id s25mr4613958qkg.42.1614872931961;
        Thu, 04 Mar 2021 07:48:51 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id j20sm20352915qtl.36.2021.03.04.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:48:51 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Thu, 4 Mar 2021 10:48:44 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
cc:     dwagner@suse.de, "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [rteval PATCH v2 2/3] rteval: cyclictest.py: Make build targets
 architecture independent
In-Reply-To: <87im67tno4.fsf@kokedama.swc.toshiba.co.jp>
Message-ID: <3d6cee93-577b-d06e-b440-d8c97615a544@redhat.com>
References: <20210224021603.446274-1-punit1.agrawal@toshiba.co.jp> <20210224021603.446274-3-punit1.agrawal@toshiba.co.jp> <43eaa8bb-26a-112c-8c13-38fe882dbbb@redhat.com> <87im67tno4.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Mar 2021, Punit Agrawal wrote:

> John Kacur <jkacur@redhat.com> writes:
> 
> > On Wed, 24 Feb 2021, Punit Agrawal wrote:
> >
> >> Not all kernel archiectures provide the "bzImage" target, e.g., arm64
> >> provides "Image" which generates an uncompressed kernel binary.
> >> 
> >> Instead of going down the path of customizing build targets
> >> per-architecture, let's drop them altogether. The default kernel
> >> target should build the kernel and modules on all architectures
> >> anyways.
> >> 
> >> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> ---
> >>  rteval/modules/loads/kcompile.py | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> >> index 326f1ae..e747b9f 100644
> >> --- a/rteval/modules/loads/kcompile.py
> >> +++ b/rteval/modules/loads/kcompile.py
> >> @@ -58,7 +58,7 @@ class KBuildJob:
> >>          else:
> >>              self.jobs = self.calc_jobs_per_cpu() * len(self.node)
> >>          self.log(Log.DEBUG, "node %d: jobs == %d" % (int(node), self.jobs))
> >> -        self.runcmd = "%s make O=%s -C %s -j%d bzImage modules" \
> >> +        self.runcmd = "%s make O=%s -C %s -j%d" \
> >>                  % (self.binder, self.objdir, self.kdir, self.jobs)
> >>          self.cleancmd = "%s make O=%s -C %s clean allmodconfig" \
> >>                  % (self.binder, self.objdir, self.kdir)
> >> -- 
> >> 2.30.0
> >> 
> >> 
> >
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Hi John,
> 
> Thanks for picking up this patch.
> 
> Just wanted to make sure about the status of the other 2 patches in the
> set - 1/3 and 3/3, I am assuming they're on your TODO but haven't had a
> chance to confirm yet.
> 
> Let me know if that's not the case for some reason.
> 
> Thanks,
> Punit
> 

Yes, they are on my TODO list, I will get to them.
I will probably take the patch that deal with the model name, after I 
convince myself that it won't break anything else.

I don't really like the idea of a fake NUMA node to deal with rteval
on non-NUMA machines, but I am open to ideas to get rteval working
on such machines. On my list to give you feedback.

Thanks

John
