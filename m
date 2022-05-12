Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BFAC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 May 2022 05:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbiELFOE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 May 2022 01:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbiELFOD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 May 2022 01:14:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020A5A09F
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 22:14:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4402803wme.5
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 22:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=m6H/LC7IZZgYVXf0trB/fr4cD4nQ8uYq2Xc1Hyr6tsk=;
        b=UaNfSXKq4cJGtQm+q4l73aHcGONgeORza7o8GOo0MzkQwQcCl7QYoF/9Vt4kM5dPvp
         8PhIWzbc7Z4VWGz3fDCsMmjZpLOZE52mFfAnfk/gghoPQgdlEalJHgP2zMjQL8RfPwHb
         8ETriSoJ8TA7qmEew/fZiP/Nhbn0NWAb5rRRsu6B7ljdZ5Y7uNqQspxMX3eH2ay9vbjx
         +RpUi2BjOnVCIeI0qXkJwh/o8a+q0LE+jStOOkrIDyxSI5bv3JZYibO6pN/XR3Uy8ecR
         DZ+S35PtErEZempaeYd7uYDl3/gzfKfVOH8oOPkzY5NKvO29R1WPcMSyUaoX+BxhhHpA
         Wjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=m6H/LC7IZZgYVXf0trB/fr4cD4nQ8uYq2Xc1Hyr6tsk=;
        b=xFLnWStQOf35iumppyzSh9iHmbniXs8RZzZUd4ziAppeFV7XaDX64OAIgdxomYAGET
         hqifAk1jR85yl3e5BHEEfM5CJ0hwqEQE0HJqniAIW1pZ4infHQGPg8huc8KecP0NY7xP
         0qqyTt7rO9TH9H0rFyx5vzLAmEdsOpa8ffKmH5mOfLhNIsczyb97a2XQIBYr4VwlymPU
         hlWa7XdYQQ1UmyhRY7ZwbqtK22PdIT4VOuH40bQaNNdiX0hsIhJABLvrrrgr/njJdVVX
         q+kJ6T7Ve1S/P/kfP78CPp3HFmIa68STedZuwag/8AndshLHwNSlRo/aVDDMhAG1n/GM
         /haw==
X-Gm-Message-State: AOAM532Clrc/1uSXn4Segh6Osu/dIV45rCDfOXtgN2Hu9IiroAdx+eAy
        v5cbzMmOKA8qKShXZPH5E+kk+3f3XlY=
X-Google-Smtp-Source: ABdhPJyzdHcBnveijC88MPE2ulahLlNPuG/NTpnp7l/cOFXTNEjuG7nrF9f8/fwF8nWzXA8qWPVicg==
X-Received: by 2002:a05:600c:3041:b0:394:8835:2223 with SMTP id n1-20020a05600c304100b0039488352223mr8566126wmh.160.1652332440375;
        Wed, 11 May 2022 22:14:00 -0700 (PDT)
Received: from [192.168.1.6] ([5.28.133.54])
        by smtp.googlemail.com with ESMTPSA id t13-20020adff04d000000b0020ce015ed48sm2457576wro.103.2022.05.11.22.13.59
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 22:13:59 -0700 (PDT)
Message-ID: <70b2548e-4f45-cb4f-d893-0a4d59ee4faf@gmail.com>
Date:   Thu, 12 May 2022 08:13:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
From:   yosi yarchi <yosi.yarchi@gmail.com>
Subject: high latency introduced by hrtimer_interrupt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

hi

I'm using linux-rt, 5.4.41, at91 sam9x35 (single core).

AFAIK, the hrtimer_interrupt must run at HW context, and could not be 
threaded.
On my system, hrtimer_interrupt processing takes ~100us in average, 
~40us in best case and ~200us in worst case. when adding the overhead of 
the re-scheduling that follow each interrupt, we get to worst case 
overhead of ~250us for the hrtimer_interrupt.
This worst case and the huge variance are too high for some of my 
threaded interrupts, which have to record timestamps of HW events with 
precision < 100us.

Digging in documentation and mailing lists, I didn't find any solution...

Any idea on how to overcome this problem?

With best regards
Yosi Yarchi

