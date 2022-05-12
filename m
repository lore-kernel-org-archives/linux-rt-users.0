Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1512CC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 May 2022 03:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbiELDj3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 May 2022 23:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiELDj2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 May 2022 23:39:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F096A06E
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 20:39:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a5so1610728wrp.7
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Ryf/wp9YLlSIBtisquynJ+a8dPy2fUuThClLTwGccH8=;
        b=EXZDMNVZY8/arrbKhzQeO5bEsobyD1fCGlgTyqvSRwQHEkv7tdRlMyi8JqJeU5NDA2
         yjWQ9sIPoLEKxGwJoFD0aLgyyIcf3LWrx+sRqaaxQYiZuPO7a9GeoW0/j42qMDqF1yCD
         0wvawWoxrjiZafEls2eJKGlrJCcMKvF+z8D+fZlyEmxqD8QSNYLvUnyfK701PVuexoq8
         EMtdid3EJTXVwJDAETcfxG8d8aQQGh1pn8+Ndcc28LgtXXGR93OC4ST/GdP592gyRW3S
         xYYI+MJt73JX+xhnipCZRwBbWWRnC3VG9fWzh6+97/wiHjoleMehF6DW0WR71YlzO3/d
         s3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Ryf/wp9YLlSIBtisquynJ+a8dPy2fUuThClLTwGccH8=;
        b=Smr0EKn36kCC51oz+Z+Scb+cA3vnyxC12Hn2bWNuqogvOzdHR7PWxexVoMGc2yu3P9
         A5DNwdbBiHOVYtvQrR5AEZX0HiKKutCxpmEIcCMHgBJnqliEPQs783cI/0mZEYl1Gp1z
         IyLGGg+uKou38xohYGkG1USq3xpXd/EDNtszqZ6T9n2kIUHUf0VEG56sTdKA+S6Em1pc
         Zf0cvcnqdoQvievkKN7J5JBfhvZCfeU4KN2gaJTMu2HKEwmWlLC6NkTC+atIrvHLc0n7
         tpdYEaRzqkRNsTw0x4lQ1E8gNt8qeKRw0Ygd530YlGi3SaM4bSWYkPPJOmTPBDiXUvd+
         ArNQ==
X-Gm-Message-State: AOAM5302tIPsQCbpupL5P8/O2VYXFQJ2FphzLryyc7xIup4KDeqKTxeT
        McBu2MvV3SaUnaL1ycZ5CfEdEsBzcx0=
X-Google-Smtp-Source: ABdhPJwjAKuzqAM58vWpq0bow8IM4w5fN2HAkS0yai2XSiBmFpikyr6elPBe0xVzVkf0hU8JXhSVOg==
X-Received: by 2002:a5d:5085:0:b0:20a:e090:85ad with SMTP id a5-20020a5d5085000000b0020ae09085admr25125156wrt.235.1652326765354;
        Wed, 11 May 2022 20:39:25 -0700 (PDT)
Received: from [192.168.1.6] ([5.28.133.54])
        by smtp.googlemail.com with ESMTPSA id m12-20020a5d56cc000000b0020c635ca28bsm2867332wrw.87.2022.05.11.20.39.24
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 20:39:24 -0700 (PDT)
Message-ID: <7f336ac2-b664-452e-12e7-d29ccc53fbf6@gmail.com>
Date:   Thu, 12 May 2022 06:39:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
References: <CAB6A5-C=YsVca4OQJZ=tOg9mjzEjobD9b94Mkvc0Ora_uQ-GCA@mail.gmail.com>
 <87czrtorwp.ffs@nanos.tec.linutronix.de>
From:   yosi yarchi <yosi.yarchi@gmail.com>
Subject: high latency introduced by hrtimer_interrupt
In-Reply-To: <87czrtorwp.ffs@nanos.tec.linutronix.de>
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

