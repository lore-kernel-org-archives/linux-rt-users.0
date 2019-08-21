Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C0C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 06:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EE82089E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 06:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfHUGo2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfHUGo2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 02:44:28 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 957197FDFA
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Aug 2019 06:44:27 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k8so749334wrx.19
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Aug 2019 23:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omPliZLuCRMscEE4W+freOK1QfBBdUKTD5kYd/YUcdg=;
        b=I/ZFIEWHvcA0Z2Aoiq4PJ7x7awnFxfQ6m7Fq/n2EGsY1+2GAGkwvupNS+TijIdnygk
         RlRXAEBwIaq6pcdj6FajS6SWvDTnZyAlYGHNa37rKSwB0deJeTAomtEwT1dntPda/R5F
         +x2NQ6swUcI5inmnOiFuG2B2VhwJcF9QUWEjUpbyw//SYtxRPOgrl+twn5kRyAf8QO+A
         PJrGND9ZMt4emnqFp4+yskMmNWqloPJKHdGLRPnXcauNwUzlr+31JmO4Oj9RsNPa6E37
         aGqWA1p0WQ2F0GjAXs+fIHROcoMryMAWp01P9FZkHz6j847zDfcKfxhK2wAdwoa8R4N6
         u59w==
X-Gm-Message-State: APjAAAX0x0DHfkngftyfKeUef/ftL8JmIHqRn58l4twQABoBzBP97lGH
        szbONwBnxcURo79QyqyTUBNUNLLcSwLb57nl8aDPtrMAOJsirZBWIPX/LyHmzfaEZ+EBU8rUvsR
        MtF9or4th1qAGRIHw7/iczRwjOWU=
X-Received: by 2002:a5d:554a:: with SMTP id g10mr20274028wrw.9.1566369866147;
        Tue, 20 Aug 2019 23:44:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYqR03pNTRAp+wDsR4GmDB89PRwmEWDmx3q4AiDqcJEbHN7AHpfZNwFSEws0FiTi+FZMY2nQ==
X-Received: by 2002:a5d:554a:: with SMTP id g10mr20273980wrw.9.1566369865792;
        Tue, 20 Aug 2019 23:44:25 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id h8sm12733900wrq.49.2019.08.20.23.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 23:44:24 -0700 (PDT)
Date:   Wed, 21 Aug 2019 08:44:22 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     "Li, Philip" <philip.li@intel.com>
Cc:     Juri Lelli <juri.lelli@gmail.com>, lkp <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190821064422.GE6860@localhost.localdomain>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
 <201908201356.Pffozrxv%lkp@intel.com>
 <20190820064203.GB6860@localhost.localdomain>
 <831EE4E5E37DCC428EB295A351E66249520CA35E@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831EE4E5E37DCC428EB295A351E66249520CA35E@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 21/08/19 01:43, Li, Philip wrote:
> > Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
> > local_lock
> > 
> > Hi,
> > 
> > On 20/08/19 13:35, kbuild test robot wrote:
> > > Hi Juri,
> > >
> > > Thank you for the patch! Yet something to improve:
> > >
> > > [auto build test ERROR on linus/master]
> > > [cannot apply to v5.3-rc5 next-20190819]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system]
> > 
> > This seems to be indeed the case, as this patch is for RT v4.19-rt
> > stable tree:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v4.19-rt
> > 
> > I was under the impression that putting "RT" on the subject line (before
> > PATCH) would prevent build bot to pick this up, but maybe something
> > else/different is needed?
> Hi Juri, currently if the mail subject has RFC, we will test it but send report
> privately to author only.

OK. But, my email had "RT" and not "RFC" in the subject (since it is
meant for one of the PREEMPT_RT stable trees [1]).

Best,

Juri

1 - git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v4.19-rt
