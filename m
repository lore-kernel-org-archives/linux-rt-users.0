Return-Path: <SRS0=wDRI=3Y=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43906C2D0B1
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Feb 2020 09:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A8721775
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Feb 2020 09:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="AVtW3lSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgBDJfX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:35:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36370 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgBDJfX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Feb 2020 04:35:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so22090934wru.3
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Feb 2020 01:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7kTVBmHrwGM0NElcpISl+YJZQ1DONwHCAJte4Zu6Os=;
        b=AVtW3lSPffJ5HJzaPb3qxKrE0csfbLNr3SQVT3LpOo3OjQ1tN5Uza25E3Hy0lLcBMc
         J5zJT/Pd4xvj932Q4lj2jWn75FGWJVjhQXsOacSJ9QuoWl9TRhk7jkWIRHrMDR9foCvA
         bUnQCw5uUYDfUKcAnbLsI5FD5aEG1XsqreTcRSHJj9KnC0dBOMT4OUMWmlHf8+3hLBej
         XGx6vxaWZpkOiJf4rEz7VuzqAE6FveN1M1zrHDFbmgVUKPMvRJ4DJh+KT/eUambTiFgO
         E7Xm7V31lnhlkjJ9AwODkA+9onpEb+eX83ssUQk1zMtjOZGQ27LSS3xw/Lr1fWC48BB8
         XHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7kTVBmHrwGM0NElcpISl+YJZQ1DONwHCAJte4Zu6Os=;
        b=AJqWY59UDfVhAzr+IifKOrleMWR+wiaekpAsCiNsFqK25BnBAtb0j/yJf2MigXZgRp
         sqahKv2nlHyFSd9PpRN3NY5+KdTAZOvPxU/1cUPkMRejC+Lwa2g65lkK5jQUMcbGB/9H
         of+YkZQeTm4j4ehatm82VZSIO+YyPR3/yz128bO2SQYlSfWkfa3Lnbr0uJxh7le+CvSE
         fsYOCKD1kLyNZaqrZM6xwETpV5HLDccAnAcj0f9rtZMmc4S8yXgqRU05lGz9Xe36yXdl
         d1x57qNXIR7PqVYvnULuTvtMyX/SZ6UrvLI+lEVBD2ni809jqB5o3sKlufGXhXUlt1wm
         oq6A==
X-Gm-Message-State: APjAAAViwnUUtAbcsizS7x0Vjo4u5EyIJgHj1EQXHZh4hsO2Hq1xvSCu
        FbTeYc7UJZK2wa0cqEGvsA7aKw==
X-Google-Smtp-Source: APXvYqwaSWCBxxIlUu1pKSydkZEi3If//sJeKkWi99F6xaSIbTGIUgJ6Lk3Hm55botUst16MU17VJA==
X-Received: by 2002:adf:9b87:: with SMTP id d7mr21984842wrc.64.1580808920919;
        Tue, 04 Feb 2020 01:35:20 -0800 (PST)
Received: from localhost (5ec10d2e.skybroadband.com. [94.193.13.46])
        by smtp.gmail.com with ESMTPSA id r15sm2925508wmh.21.2020.02.04.01.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 01:35:20 -0800 (PST)
Date:   Tue, 4 Feb 2020 09:35:19 +0000
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT] mm/memcontrol: Move misplaced
 local_unlock_irqrestore()
Message-ID: <20200204093519.GC4303@codeblueprint.co.uk>
References: <20200126211945.28116-1-matt@codeblueprint.co.uk>
 <20200203181746.htlca2aynoqidm3o@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203181746.htlca2aynoqidm3o@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 03 Feb, at 07:17:46PM, Sebastian Andrzej Siewior wrote:
> On 2020-01-26 21:19:45 [+0000], Matt Fleming wrote:
> > There's no need to leave interrupts disabled when calling css_put_many().
> 
> For RT the interrupts are never actually disabled and for !RT they are
> disabled with or without the change.
> The comment about the disable function mentions just the counters and
> css_put_many()'s callback just invokes a worker so it is probably save
> to move the function as suggested.
> 
> May I ask how on earth you managed to open that file on a Sunday
> evening?

We're carrying it in some of our older SUSE RT kernels and I'd really
like to get it upstream or sent to /dev/null ;)
