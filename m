Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9743C6FA99
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Mar 2023 08:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCLIFY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Mar 2023 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCLIFV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Mar 2023 04:05:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D94DE2E
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Mar 2023 00:05:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f11so8637245wrv.8
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Mar 2023 00:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678608301;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcB43cYqxyhDKqH7p6fPMaot5PBbdqX2C8QBy/3PdQk=;
        b=BrGUhWSMTwMz8hDvlqU3RHk5UXP6rL/uez4RIkcATrouLQrpyrvAnHpklWF8KDCCEY
         x8SoaYV1IqeU45T45kG0uvF8KzO69atn8gCDqZ7a/jDt9ln+JHNQLu6MIbwjFissRZgB
         wpgzHleiaHqLPn7yGc5mXc3DpaPCq+X51nTgBLjOVUSxuYAdYHkx94+K7LisI5YbEpQa
         /z85OomPABnS3kYWSQapRt2Rgpgilmk2dP1/ipTOYRiNb3ESywVRJl8rrLLaHZZDpT6b
         Au57s2tUX1PDQh8Z2xUFbGFtAzJHPdSz750G5DHEgo/U+GEJcZpXIonOpZ6Lt/ykP+a/
         7wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678608301;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QcB43cYqxyhDKqH7p6fPMaot5PBbdqX2C8QBy/3PdQk=;
        b=OnhEkPruKj46hFtJ5JF3g9MsHe5EvFC20GZ2LNX3aaANKwHinJ8wQMuKPXQBKHfF4v
         /8XdjYbTdxFVw5VOe6hHmGysV9m9PL6yUHrTyenWkeqOwPKNwVh4GflNyvCeCVSYHUvm
         aGZyKegzbhQZeWEZ+4YES4eU3cf8ng/ckTz8diyUekTGsQsHMBxFuzuh74ijxdQY2wIO
         MXXN1syAX6OAs1bNbwTfkSZdZ+bFRz/4kqLEO6L5q9uNcR+yLvfTdSoWY7W5+vKOPcui
         0h0lANw1WpJpV5uck9ZmMrWaaYplfugRrl4qQKQadHNWcmhktLAmnu7GgWsEpPO5+nW+
         qFtA==
X-Gm-Message-State: AO0yUKUzwFEndHOhJja/DWIYjOMU8BOwN9Qa+JN6m7Jl/FJU6bufqZjP
        XPkR6876XFsGFSOaY7PNZFHJM8/lDOc=
X-Google-Smtp-Source: AK7set+zB36GGhqE74OV/wYZRdsAAZLheFncESFwpl3VTt1et/ny7VGc19vuLfMDlrojNBRloZDv7g==
X-Received: by 2002:a5d:550b:0:b0:2ce:aa2d:c625 with SMTP id b11-20020a5d550b000000b002ceaa2dc625mr916461wrv.22.1678608301179;
        Sun, 12 Mar 2023 00:05:01 -0800 (PST)
Received: from [192.168.1.6] ([5.28.145.70])
        by smtp.googlemail.com with ESMTPSA id d8-20020adfe888000000b002c3f81c51b6sm4437835wrm.90.2023.03.12.00.05.00
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 00:05:00 -0800 (PST)
Message-ID: <c2b42dfa-8d41-d981-18e1-539d70e1d54d@gmail.com>
Date:   Sun, 12 Mar 2023 10:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
From:   yosi yarchi <yosi.yarchi@gmail.com>
Subject: hard irq + threaded irq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi


If using 'request_irq' API with IRQF_NO_THREAD, then the provided 
handler is invoked as hard irq, and no threaded irq is launched.

If using 'request_threaded_irq' API with 2 handlers, then two threaded 
irq are launched.

Is there a way to configure irq so that one handler is invoked as hard 
irq, and the second handler is launched as threaded irq?


With best regards

Yosi Yarchi

