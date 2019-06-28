Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77516C4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 09:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B7E208CB
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 09:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="PyIC2JMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF1J5m (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:57:42 -0400
Received: from mail74c50.megamailservers.eu ([91.136.10.84]:54648 "EHLO
        mail92c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbfF1J5m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 05:57:42 -0400
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1561715860;
        bh=2xgostV52W0rZhOaNUCYk6+YtYEMm+Vug8fdWn0+IpQ=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=PyIC2JMqtaWceekLrtkkzaQcTpEae8LKxoSlOvD6h3ntG5aElGPCqJ85kQ0CMbUoW
         HZzh5FrAGgIT8Xeioeqgi2TSwiIFfxJ+y7ICTz6VXg0EUrPMC7XYjlCqWKnhrVjwjp
         iypr/S62U6kqSVJhq21vugG5b7eIifnSndLGVv+o=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (x4e31604e.dyn.telefonica.de [78.49.96.78])
        (authenticated bits=0)
        by mail92c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id x5S9vcre009855
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2019 09:57:40 +0000
Date:   Fri, 28 Jun 2019 11:57:39 +0200
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.0.21-rt14
Message-ID: <20190628115739.7fec552c@archlinux>
In-Reply-To: <CAJjrzcUBU5PPSzwXwm6wD8vT_mAakE-mepN1+CQuCoPNMWwgzw@mail.gmail.com>
References: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de>
        <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com>
        <20190628103435.0d95ebe8@archlinux>
        <CAJjrzcUBU5PPSzwXwm6wD8vT_mAakE-mepN1+CQuCoPNMWwgzw@mail.gmail.com>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A0B0205.5D15E494.0033,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=RPid4bq+ c=1 sm=1 tr=0 a=Sdy8UPBtZ110XTA5kkZ23w==:117
        a=Sdy8UPBtZ110XTA5kkZ23w==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
        a=kj9zAlcOel0A:10 a=hR295M027W5TTqICUWYA:9 a=CjuIK1q_8ugA:10
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 28 Jun 2019 11:28:27 +0200, Arve Barsnes wrote:
>I don't have those other commands installed, but outside of my trouble
>with -rt14, it's interesting that my uname output does not mention
>PREEMPT RT.

Perhaps you accidentally used the wrong config to build the kernel?

What does

  zgrep PREE /proc/config.gz
  grep PREE /lib/modules/5.0.21-rt1*/build/.config

show?

You might have a config in /boot/ or somewhere else.
