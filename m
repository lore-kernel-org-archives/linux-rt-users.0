Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B4C4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9CC21881
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5mfFobQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfIQOUY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:20:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44765 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIQOUY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 10:20:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id i78so4116462qke.11
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Sep 2019 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CKsos+SVsdRFYhHaAEGOrJmisnhcAr+qNMtqjH5zvx0=;
        b=F5mfFobQXDr12xux94S5VB/zCpROovuIk9sr7kURY26wypswiRcrMILitaSr5oVw2u
         RUh0IAxAoWBu+vJtC5oJD52qLIwrefxXTTc/MQFNf012++NqeFHF8P+wQflqcwprob3Z
         EBhm/qavqSNy4+BAtGP8O12DU8fnz258oiFPa4/uRxvSBm2PgGZNWh6PiLV0yP3SLJXQ
         U1u0KOEcREgB/0QnFuYLrCkHiq7Z8JL+ezBo01syigkv1sfX1NZ4q56Ckm+4qckHW33k
         K989CwoaYyY+/t6ezL6DktRxGr1K21LlDuqhSOWOS/tzizzVIV0amrEuHHhx5wdVIHZp
         uGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=CKsos+SVsdRFYhHaAEGOrJmisnhcAr+qNMtqjH5zvx0=;
        b=tUicdUTzQoaMWCnaVAGYNtdJc83CRqTzHjJirZ3Ve4zPS9FjtrfxsjvKVtrje2+wi2
         +wWv/xIj1loYAQ/Nm1eFYU6wYyozFf1zldF/VmR4T1pypSEZQA96xxvasxYpsxR0CSG2
         ygfI6Om9Hk8pnsw5PMmP9mQRl8vipG9wyo5CLFbAeDX2ClDsWCCl4Awow/s40EUnZ0S6
         lvoQLOoiBu+DLtP+rqnod6EeHx9E2Ne0eVIl5arabPFjraTrolAIIJvMiQk49FKIt6iI
         Kay7sVfzahlzON3yGjsRNQQxKR874etz0h/Vgfn6md3uBFtnlZLYSqTH3rTXGluXSRaP
         Ytfg==
X-Gm-Message-State: APjAAAUD/ze6SgJvmyNYdzGYzQFIFUQj7N6NQIqtCvQH38WOAL3uO1qD
        a0Gg6Jj64sJENYVpew6wS+M=
X-Google-Smtp-Source: APXvYqxmHQKpDsXpNtuwXnFR3f1zJx5ERUCkMjnm9/Y90VbVGA6BGK9E8Oyz0O+iMz7bBtJQxfFxDA==
X-Received: by 2002:a05:620a:1252:: with SMTP id a18mr4136521qkl.88.1568730023217;
        Tue, 17 Sep 2019 07:20:23 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id q5sm1548858qte.38.2019.09.17.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:20:22 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:20:21 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 2/4] rt-tests: cyclictest: Make tracemark work correctly
 again
In-Reply-To: <20190917072125.GA2613@linutronix.de>
Message-ID: <alpine.LFD.2.21.1909171619460.3853@planxty>
References: <20190916215111.10193-1-jkacur@redhat.com> <20190916215111.10193-2-jkacur@redhat.com> <20190917072125.GA2613@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 17 Sep 2019, Kurt Kanzenbach wrote:

> Hi John,
> 
> On Mon, Sep 16, 2019 at 11:51:09PM +0200, John Kacur wrote:
> > commit f5ccfbe4d6641e48f56152be135d901dd31cba7e
> > was a little too aggressive removing ftrace code.
> >
> > We were able to remove ftrace code because this functionality is
> > available using trace-cmd, in conjunction with the tracemark option in
> > cyclictest. Put back the parts of tracemark needed to make this work
> > correctly.
> >
> > After this patch you can get tracing info like this as an example.
> >
> > trace-cmd record -p function ./cyclictest -t -b100 --tracemark
> >
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 52f93da7d074..45b6041ec1c9 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -184,6 +184,7 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts);
> >
> >  static int shutdown;
> >  static int tracelimit = 0;
> > +static int trace_marker = 9;
> 
> Shouldn't this be 'static int trace_marker = 0'? Otherwise it's always set.
> 
> Thanks,
> Kurt
> 

I left my computer glasses in Germany - no seriously I did!
Thanks for spotting that, respinning the patch

John
