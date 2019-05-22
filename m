Return-Path: <SRS0=tVcw=TW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132CC072B5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 May 2019 01:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B7521479
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 May 2019 01:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN0z3YAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfEVBF2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 May 2019 21:05:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39806 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfEVBF2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 May 2019 21:05:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id y42so435007qtk.6
        for <linux-rt-users@vger.kernel.org>; Tue, 21 May 2019 18:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BYq0c4lDTU0FRqyZewCvAQK4h12B6Bcpp2cveGK2ZU=;
        b=jN0z3YADV/RJ7x30z6OOdJObjFcUMSMbTgLs+D52THhYAAMhekUwP8eAlzCuecsNV8
         qWh6ZmI5KFMDapP+VR0v8lyKtWCAVUXgNBstCtHE5GlqRbdBzrqyjcbshLvmoga1+xNv
         u1zcXfaVnCbXwFs+Qj6dci4R+ymG7biPClbLK/npqQQBU0zp0MWT1fyf6xceXOdjjrfz
         rTrieHsxNqzBCoqVB/q5tQm5kKgz+T2yuDqTywiIs/yQJ2RVQqrE69BRLw8EuoDzSRyB
         Q/YaYq7Ud49evW36Wp0AU9QpPOS2HBuMwQHftj2OzO54TCKk34sT1h5zV0OqZlwhRwSm
         4IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BYq0c4lDTU0FRqyZewCvAQK4h12B6Bcpp2cveGK2ZU=;
        b=hPjQTe9bOHI99YvmS8B25cQBjkStlAU/Zqh/eFI7ZGofG7F2MYy888bWX4ZzKnpQgj
         3PNqiI2qweR10Ny1MSV58DGxc8Aav0LrIN9RwxwTyDzqipJPrCUCDCPopgn/WVsumiXa
         UnQpGyObRP6hiFcypu28JrcD0LWqn4qLDkifuA6MTc53zPyRv8JgoLCgcI0tNzkaQ+am
         02RlWpA26R8gW1EZ7dSd0N+PQMbnGovEciqGlOGkI3x8WPINSebII+vRYLJAZZ7ZQ2dp
         U2iXFY39cyKprzfOB9tHamgw1/PCoqUmtVGRL/ou070lO89/KP7sIwL6TDK6Qawwvl0p
         XrNw==
X-Gm-Message-State: APjAAAWXyu1lFQOalwDH7+lpse5ltMosMfcGHK1aND+S1lzS9mHPbxd9
        9oUjK4hbDFfcV6jErzB+ZdDEvWfq
X-Google-Smtp-Source: APXvYqyu1vUPH+oj83Yd1QfMMYnkCACZ9CyEfhhyN6vxxrI3RuT1oy9pVmJRxrLC5+FrXza6gwfHtw==
X-Received: by 2002:ac8:198f:: with SMTP id u15mr72637243qtj.153.1558487127526;
        Tue, 21 May 2019 18:05:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 22sm10875532qkl.4.2019.05.21.18.05.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 18:05:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 695CC404A1; Tue, 21 May 2019 22:05:23 -0300 (-03)
Date:   Tue, 21 May 2019 22:05:23 -0300
To:     Daniel Bristot de Oliveira <daniel@bristot.me>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org, dhaval.giani@oracle.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Real-time micro-conference proposal for Linux Plumbers 2019
Message-ID: <20190522010523.GO8945@kernel.org>
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
 <d0d44fb3-ac4a-c0c4-a9ce-76736ca70e31@bristot.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d44fb3-ac4a-c0c4-a9ce-76736ca70e31@bristot.me>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Em Tue, May 21, 2019 at 03:07:54PM +0200, Daniel Bristot de Oliveira escreveu:
> 
> 
> On 5/3/19 8:53 AM, Daniel Bristot de Oliveira wrote:
> > Hi all!
> > 
> 
> Hi all!
> 
> Good news from OSPM!
> 
> I just talked to Frederic Weisbecker, and he is proposing talking about the
> softirq rework that we need - as a step to the -rt merge!
> 
> Dhaval Giani is also mentioning the possibility of talking about their needs
> w.r.t proxy execution!
> 
> Anyone else with a good idea? stable-rt people??? :-)

Has anyone thought about how BPF interacts with CONFIG_PREEMPT_RT_FULL?

- Arnaldo
