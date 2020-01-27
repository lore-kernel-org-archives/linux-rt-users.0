Return-Path: <SRS0=nqJC=3Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7FCC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jan 2020 17:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35CE21739
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jan 2020 17:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTRyDHPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0Rk0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:40:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36415 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0Rk0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jan 2020 12:40:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id w25so4755080qki.3
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jan 2020 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bfF13+JBHgYhrj3oIYKgE8F0oBJo3fmTueGn8T4wObY=;
        b=eTRyDHPVglqnWStLr8NlsY03/ywdLuVvWGqXseYsnlD7bKlIa7lQMAIZKcYvcNZ52S
         hIXRvcrtb8RdQdG9guxXRCg1KZWTWM8kt8oCCkDxqh9G8unWp/HIou2HK7Q5NIxtQ1qK
         meHAUAISQUPICYMDxttV2AFjOgCK1nzuwi4+5q5rEh2ll9XmN84CIzt5kcMYG+Uh2B30
         zRh4eLNTN1hO0QT+wrzy1kx6b9lb4bxwhrpsHqu6DtH0ydQxlvMkHkmjNR+fVHGrwSKf
         b6nVR/IIR3x0lt+w6UDvpkkO2Nw3i+gTZbJ2kKPu4FjP3YW/YFJeEt/cwXRkI7WOUg2C
         xmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=bfF13+JBHgYhrj3oIYKgE8F0oBJo3fmTueGn8T4wObY=;
        b=Zi5MOTIqhzA6jxMlfyt+c2MMyEmdgOjUQeFK6OFli85dmgbww0j6IQh03WtNRPalc1
         Y7xC8uZuVv+ndIuD0vsspqvGDfLhqxe3JTeC/s1KlT19iOIkmNnfWlBSN+GDPOsO4YSa
         Tc0MvFiR+tw3LuXBpbcjm3V8lYJ2kbrKprsPGCdAW7Ke9JEUpzu2HrmwNALJXv5LybEC
         8g9DVdUZybTVw0lOSAzrNjyDjvX9Q4LiNDuoTTzyhQIUyIykw1btH1aYjbIUtrKIjC5G
         N5x+EgQwTL2HCstkh7QpPq/Y2VmFHxFeAHmofv8SyKcVIpPZLz6d6n1YJtlNqcBYTi/5
         sYJQ==
X-Gm-Message-State: APjAAAW064d7Pyr/OLgOxRTdM9nK7XZbWw9yzUfeVYU/HHmWkZqNuLOB
        e/gHD8nPTOfZhezLgTY5fMI=
X-Google-Smtp-Source: APXvYqy4N6sOeX8YBl6sj9QZ04tQZ8t4re5irenMH2NoxUNbpGStmyrDd5/+7jZKqbFikI/RAaUfGg==
X-Received: by 2002:a05:620a:1327:: with SMTP id p7mr17649274qkj.148.1580146825330;
        Mon, 27 Jan 2020 09:40:25 -0800 (PST)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id u24sm10268541qkm.40.2020.01.27.09.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 09:40:23 -0800 (PST)
Date:   Mon, 27 Jan 2020 12:40:15 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/9] rt-tests: cyclicdeadline: Add a simple manpage for
 cyclicdeadline
In-Reply-To: <877e1dxjo4.fsf@kurt>
Message-ID: <alpine.LFD.2.21.2001271213260.7301@planxty>
References: <20200123205029.20176-1-jkacur@redhat.com> <20200123205029.20176-3-jkacur@redhat.com> <877e1dxjo4.fsf@kurt>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 27 Jan 2020, Kurt Kanzenbach wrote:

> Hi John,
> 
> On Thu Jan 23 2020, John Kacur wrote:
> > - Add a simple manpage for cyclicdeadline
> > - Install it from the Makefile
> >
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  Makefile                            |  1 +
> >  src/sched_deadline/cyclicdeadline.8 | 53 +++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 src/sched_deadline/cyclicdeadline.8
> >
> > diff --git a/Makefile b/Makefile
> > index 552b3fe885cc..e2142ba3f4e9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -193,6 +193,7 @@ install: all install_hwlatdetect
> >  	gzip -c src/queuelat/queuelat.8 >"$(DESTDIR)$(mandir)/man8/queuelat.8.gz"
> >  	gzip -c src/sched_deadline/deadline_test.8 >"$(DESTDIR)$(mandir)/man8/deadline_test.8.gz"
> >  	gzip -c src/ssdd/ssdd.8 >"$(DESTDIR)$(mandir)/man8/ssdd.8.gz"
> > +	gzip -c src/sched_deadline/cyclicdeadline.8 >"$(DESTDIR)$(mandir)/man8/cyclicdeadline.8.gz"
> 
> I'm just wondering about this. Why are the man pages compressed in the
> Makefile? Actually most package management systems compress the man
> pages themselves. Users may want to use bz2 or something else.
> 
> In fact, I have a patch on top of rt-tests v1.6 in Gentoo which removes
> the compression, because portage complains about it.
> 
> Thanks,
> Kurt
> 

I think it's because man pages are generally installed as .gz files on 
most distros. Although the Makefile is designed to work well with package 
management systems, it should also work correctly stand alone.

If you want to submit a patch that would optionally use a different kind 
of compression or otherwise handle things without breaking the current 
defaults, I would likely accept it.

John
