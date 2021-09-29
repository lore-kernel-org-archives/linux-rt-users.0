Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E5C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 00:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673A3613C8
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 00:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbhI2AMG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbhI2AMG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Sep 2021 20:12:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DA4C06161C
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 17:10:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k24so792191pgh.8
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 17:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gpao0Q1WCGMxvM1d6E7xygO8ivVWvfb+Ht2f2JCRYmA=;
        b=dmjgLCRee0FXHS96cvJnvnZGnwhLHXIom97ZHkBiCP2YQzzXpVqU/zaZey+FiRUN+6
         HG/X09nwD5dAjO4/YOuPgC/5HTnjDTAEFk8kZHzjQdGBvwWym98HPqOKu1WoSdyCgMBA
         y5KAwDzXw2Kpp+NG8lIqmE80/VOzvcja7lH06nNr3/4Cce+rqbjAFyouu5ymL5Exah6o
         nNR1EaPf1I458y+fbxG0nOUD89uRnd0kCJy8eeKUflKroYGgd9Q8BUqhyowjzoLV3idN
         U2BEQ4Quy3XrPCI5VkbavZIwSa7XzWpmoZ8rFpZzl/VhaPdqZ1pXlQqrdtJkqXXsGoPY
         mo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=gpao0Q1WCGMxvM1d6E7xygO8ivVWvfb+Ht2f2JCRYmA=;
        b=Fi4D97aG/LEFZar62hBIP7dYgiCaywss9mA2fsq9OftmMFfqf/o3ZCIcdXvIiJpurd
         Ws7Zo1rpWgJ0NNlYzkHL0SbvBuiN6qGKtN5NyDa4mx7WUrUuvOEUjcSOR+/Dc77IVLMe
         +ZVNbBV8Sw8lGKA8t9fM/yuysQqKaVIvow8SY97jYKSOrQ2iLEA7m6buq0jc3S4NQzXe
         bSUnGyBlxs/BXCpk8Lgld6bpWpqhCSifrfPD4yBkpRwYV+CIl4dHDWjNs8J1gHfmISNO
         YvswLrxWMNyR4u16bHo6rsuZsXptMHjgyIdeL9An5dhjtwwbucMkhOJTb72SPjwL+A/9
         kioA==
X-Gm-Message-State: AOAM532ssnmDXej3upWsDkcmve4SuKyczP2UBeDwI+aoP8M2Iptlb7pC
        NCSVmDeQT7pMRRsVX5p34S4=
X-Google-Smtp-Source: ABdhPJyPo2Tmn8R5+DtrXzBjwLtG4h0KN0ixipAvWuW6WAGYx5xp2l5Tiq/f1tZfLXrou5MgkpKiBA==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr6990923pgh.7.1632874225682;
        Tue, 28 Sep 2021 17:10:25 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id l11sm3373925pjg.22.2021.09.28.17.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:10:24 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh.c11@toshiba-tsip.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Gracefully handle lack of
 /dev/cpu_dma_latency
References: <20210928081716.3421463-1-punitagrawal@gmail.com>
        <20210928085900.3422085-1-punitagrawal@gmail.com>
        <748d14f-a32e-961-8581-f58be77ca419@redhat.com>
        <87fsto5nbm.fsf@stealth>
        <d150ec8a-73ba-53e7-4854-36eb82404c7@redhat.com>
Date:   Wed, 29 Sep 2021 09:10:21 +0900
In-Reply-To: <d150ec8a-73ba-53e7-4854-36eb82404c7@redhat.com> (John Kacur's
        message of "Tue, 28 Sep 2021 19:25:50 -0400 (EDT)")
Message-ID: <87bl4c5jiq.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Wed, 29 Sep 2021, Punit Agrawal wrote:
>

[...]

>> > Thanks! I have a couple of nit-picky suggestions.
>> >
>> > If you initialize self.dma_latency_handle = None in the init method of 
>> > class Detector, then you can drop the else part of your check to see if 
>> > the file exists.
>> 
>> I can do that - but then I wonder if there is any harm in initialising
>> the file handle in the init method itself too. That way
>> c_states_[off|on]() can focus on doing their thing after checking the
>> handle is not null.
>
> I mean I suppose it would work, but I wouldn't consider it great style, 
> I think of the init as a place for basic declarations and
> initializations.

I don't have a strong preference here - so I'll go with your suggestion.

Thanks.

> Anyway, I'll have a look at whatever way you decide to go.
>

[...]

