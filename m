Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2762CC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78E4208B8
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 19:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4RgevdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbgEZTym (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389038AbgEZTym (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 15:54:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548AC03E96D
        for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2020 12:54:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s8so21659053wrt.9
        for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2020 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=207p+O3z4/vNMiHn3dN+duJP8DRqoyKRCJOqI9HyC6o=;
        b=Q4RgevdYCqTfF2fq3n1tNEloQWx22+4MkWg9mcokGUri08oM2e0Ko8zkfNca0/QZAC
         hRc5Ts16yfzwrVpfOuN1qPgzgZnZvMIJAyoNdYqEsim3jbhYoBWdKfAE4v3tTKkjepmM
         F6D7q1evbDhMTBP597RjpxcWs2XFC6/yyfC7J/uwkEcYmzdhivqiAoEy9g0T4uVv/CwX
         7dkvbL6MKZVFMOigrCx5pooI617VX6nUQWz0nXKss9F/nUFxqhp5hZrOkSnoQsgEaLT8
         atg9e0cSfQbKwcYk+s8o2guCdN2HXPGbyC36JS4pL4Ei+epbkHPcjLNWdUNdFkVgGluP
         Z3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=207p+O3z4/vNMiHn3dN+duJP8DRqoyKRCJOqI9HyC6o=;
        b=alW5iKqEe7XK7NK1b2h1TCTLNIjwRsyr8iOyjRgfWaVJq+3IgPcGf9sThmOuF/8WnL
         iOwrocQ8LdfR1q35kA72l7LfQ/m+Et9B8SC5Iozw5e7KFUWAbwrEBySeiOgJgN78Zi68
         CXg2RZotXFSRESeYcKWMWlkk98ndunVHzeNQOQGxZrEu47AwE+VU1vmoGamO8k9bBTZM
         dGD08IUMLH9f2pUdrXYhPxALcaRxEJG7UVrYs85PGisljySSGA0nsYN/IdxW6Gs0/uwF
         BfjBbRkJYWGXZB5T7KizajIMMOSMKR860SbmzEGCiWQxSK+CTxlnpAat7PL2Vz5gbCkW
         6g+g==
X-Gm-Message-State: AOAM533oZ5yZcwm5rY6Nix4xYxw/mtHmcWCR3l8QHf6w1116CcPEUYYs
        xdP3C+8cr/HOtjKcEw333hekslT0
X-Google-Smtp-Source: ABdhPJz9wQkGvnJf+JFQi50z5uVxudz5b0z7cSX74NdrKql66NG+1qQK815Iy8CsqHzONoBGOJpXnQ==
X-Received: by 2002:adf:b34e:: with SMTP id k14mr21707717wrd.109.1590522880492;
        Tue, 26 May 2020 12:54:40 -0700 (PDT)
Received: from [192.168.0.2] (p5de561c1.dip0.t-ipconnect.de. [93.229.97.193])
        by smtp.gmail.com with ESMTPSA id h20sm517445wma.6.2020.05.26.12.54.39
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 12:54:39 -0700 (PDT)
To:     linux-rt-users@vger.kernel.org
From:   =?UTF-8?Q?Reiner_Pr=c3=b6ls?= <reiner.proels@gmail.com>
Subject: RT Patch and EFI
Message-ID: <0e6032b1-9cca-fbcb-5ea1-77575a69afa3@gmail.com>
Date:   Tue, 26 May 2020 21:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I tried the last RT patch against a 5.6.10 kernel.

After enabeling the FULL preemption model I'am no longer possible to use 
efibootmgr.

The kernel module efivarfs refuses to load - no device ...


Any idea

Reiner


