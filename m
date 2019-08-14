Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A09C32753
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 12:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C86205F4
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 12:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8n+tE6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfHNMHb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:07:31 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37425 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNMHb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 08:07:31 -0400
Received: by mail-wm1-f50.google.com with SMTP id z23so4244229wmf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Aug 2019 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Jfbx970D7mipiGobxJjjUlsh1DTBCb0zJFSnn6aYg5g=;
        b=P8n+tE6g+iG56eobcJTHqCV9lWCmy3a/4xBnk4J/zLu7zc2KaztBuKZertmASk8UIs
         wnryF0j4Wn2lpP7g7FYBdI856ia1FGYkQuz8Q6mKjjX+/tk/bxpJrTpA+VY2VI8q4ZfP
         TyNmDlPUp0XiEkuYvce1GMKpekqh088+ELjGSXj0hCs9axV5CwveedFEyEYt9uCEVqAl
         9GjKO6NLJ1cVlEl/0sWMq+FjtaVbpZP+8gVPgHKvVn8TBXtmNurVs6yeGILldZJe0HfL
         i4eMyMoeyIjUSbO22bMWnsCfEN66xLKIJpumwGeiKlke5rxcc5/z5uELpjwakeIqGKtj
         AdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Jfbx970D7mipiGobxJjjUlsh1DTBCb0zJFSnn6aYg5g=;
        b=BvM8yE6aqFxaZRHuceHvAmmIvxYy2m+F2Zss6gyrb3emDulRVRC5LmRWK5FFEk1Lm+
         /GBZjmIY3PBFmm9VTOJqutKXOd4AklOOuQY3gM57cWFirgTrBx1mnJ5zRmUAsZSZ/zoV
         UYExFkA0CuQ6To4ewQJ0ONfS4YWG4MebaKz+5jhuSwYbGkz3JFhwrvpwP7zCo7u3gRRI
         dtMxIVsQyzZiVwHPhxBvHxsNTF2XXvtpK/lbIqVolcvxsycWrrHSyGRlfkomhTgByaIh
         BbS03wCkJHtnqbtFGzUxhsWCSs/oYPUXphDzLPZvEZZ/pPss0kih7Fm8BbXECaKs/esJ
         W8MA==
X-Gm-Message-State: APjAAAUeXyMUHw1+c6PxmE5pI3vWUCjBveAQbrXgW3jEQCRGiFqEz0gf
        pTyAnyQEaPGUCbv+/M8eVmoCiGeO
X-Google-Smtp-Source: APXvYqykUsr1qU0B4bFVqwym+S05acuAIZc6OlRVNiIQLKWoDS7/LCPQ81SPPQjsqvB9twA0tAnjqA==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr7825839wmc.35.1565784448700;
        Wed, 14 Aug 2019 05:07:28 -0700 (PDT)
Received: from [192.168.0.19] (10.221.223.213.rev.sfr.net. [213.223.221.10])
        by smtp.gmail.com with ESMTPSA id r16sm39677446wrc.81.2019.08.14.05.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 05:07:27 -0700 (PDT)
From:   Rachid Koucha <rachid.koucha@gmail.com>
Subject: Little bug in cyclictest
To:     williams@redhat.com, jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Message-ID: <5d169fe2-b545-ae68-a946-4e36a613cbda@gmail.com>
Date:   Wed, 14 Aug 2019 14:07:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

First of all, many thanks for such useful tools.

In the source code of cyclictest, I can see a mistake concerning the
error checking of pthread_setaffinity_np():

Upon error, pthread functions return an error ant not -1. So, the
following code:

    if (par->cpu != -1) {
        CPU_ZERO(&mask);
        CPU_SET(par->cpu, &mask);
        thread = pthread_self();
        if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
            warn("Could not set CPU affinity to CPU #%d\n",
                 par->cpu);
    }

should be fixed as follow:

int status;

    if (par->cpu != -1) {
        CPU_ZERO(&mask);
        CPU_SET(par->cpu, &mask);
        thread = pthread_self();
        if ((status = pthread_setaffinity_np(thread, sizeof(mask), &mask)) != 0)
            warn("Could not set CPU affinity to CPU #%d: %s (%d)\n",                  par->cpu, strerror(status), status);
    }


Regards,

-- 
Rachid Koucha
 

