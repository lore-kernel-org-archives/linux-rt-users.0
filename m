Return-Path: <SRS0=P/cI=5Y=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370FBC2D0EA
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Apr 2020 07:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5242074F
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Apr 2020 07:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+ZHquUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDHHAT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:00:19 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35344 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgDHHAS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Apr 2020 03:00:18 -0400
Received: by mail-wm1-f46.google.com with SMTP id r26so4247918wmh.0;
        Wed, 08 Apr 2020 00:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Av/FXNaBuB1VS6RYdqa7OAt6R+J1OLa09arDuXhFBB8=;
        b=T+ZHquUfU6j0EIHDZXzr/jEwiClinPUpe/O5RXSWTGEjQGeROqiGAewlEmu7BexGDe
         NYPEU3W6towTqp+RtaaPpEez5xCrP1IRxAt31rqqEoKTzxzR2wX17rVf0C+VoSTBK/W8
         z5BVv4I+dDZ7TCRXPdR57DezZPf8gW01qwnQPGx/lx7o0xWwYz1pbAmX1nIeWf+5WjE0
         DGx6AmwupguJmrAj+HFkho/7Kf1xs6L85G80lygTe7SbsJQyUXgZXGdGrqtGHVnorW+f
         QLMVIMgWhQxboYw/genCflQGWY0s/tu6kv33PmPzgBtiB0VA1EHE+9XERZLqKbuKm6Vs
         Xyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Av/FXNaBuB1VS6RYdqa7OAt6R+J1OLa09arDuXhFBB8=;
        b=a3/7DLY3eLKsyQ0zCPtvF7mMf6U2ZBlAC/tnhNvLSTQUiKFV1BbHX4E1NVriRwIJiU
         0h4yVlLPuJ6y3c8zkahsHAKxAXMENmpuQhLfA13Wl6eLSee4LUJxTI9jxTlS3ZbSc8xd
         8zEb3/W0QAOXsJEqiNqiQMlT6NXE4CVX4my7YK5E0lNUz2nN51MXCSFglSIizMJeBux7
         fFmdqoo/RbF36LW9NJKjiGDLznNzoPn49i1jRCMwOOi5kI8wfqxsI2AGcFyTnDF0tfUo
         2zlDyX+wWGrCd7Ns59gXCaOwSnktZHGdD5/2xlNMw9y0i2Yt8IAt/XuidQrBmLMCm0gw
         Kglg==
X-Gm-Message-State: AGi0PuYXiG0JVcS5iVIzdjlwKatgLVb7xwgFpHTfUZ8j1VYXZvBUPTJ2
        mWQ/2BxhU7GTP/CUfS66b2/O5AY+Vyw=
X-Google-Smtp-Source: APiQypJixPuXrjaptS5y9Po9WQMW1X5Hl+YH3AEDcqGn5f02ogSjxVH+HJ7NB+KCHKSrMUgr7AzotA==
X-Received: by 2002:a1c:6783:: with SMTP id b125mr2635114wmc.69.1586329217465;
        Wed, 08 Apr 2020 00:00:17 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id o9sm29583595wru.29.2020.04.08.00.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:00:16 -0700 (PDT)
Date:   Wed, 8 Apr 2020 09:00:13 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.2-rt1
Message-ID: <20200408070013.GB14300@localhost.localdomain>
References: <20200403170443.pzm24672qo4hufcm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403170443.pzm24672qo4hufcm@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 03/04/20 19:04, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.6.2-rt1 patch set. 
> 
> Changes since v5.4.28-rt19:
> 
>   - Rebase to v5.6.2

I was reviewing the new set and I couldn't find v5.4.28-rt19
6dbbc833c99f ("mm: perform lru_add_drain_all() remotely"). Don't think
it has been squashed either.

Am I wrong? If not, why was that left out?

Thanks!

Juri
