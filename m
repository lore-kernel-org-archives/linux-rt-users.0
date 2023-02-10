Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691D7C636CD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Feb 2023 15:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjBJPcp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Feb 2023 10:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjBJPco (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Feb 2023 10:32:44 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4B5CBCE
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Feb 2023 07:32:37 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n2so3706665pfo.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Feb 2023 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPBNK2ej0BcprMRPxKQMTVYdpw2TzIpWU9/H8oT8YJo=;
        b=RaNa89YU3dnVZsXe8utP85ovLotCy8RlCIohNljxuulqSfgVmzgUPpgaPtRvq1eS9M
         hOe2ZyYcIzWlfeMLwSJN51TGErCqEqgm0m/VIpBQOJO9orMJE8pVxBaBnwVEfdNdHEJA
         7aLbz2ekAdOaHxfk6tDYi5qU/ziAVOxSp3wO86NnjEgwGKGDcecBH3uyNMTsNl9MQDVh
         aqqfa+MbSPyAoEmB/OXmmqjX6gDKy1IndCPsqpudaTxfned8c2wx28K3wCfnHq6aEvxb
         JclXUUcvrgnF7Wo0O63NWkjt4J2jtAhj8bieRBlvXtfy7/e3jlI+mrn/6szex1P36ynQ
         L5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPBNK2ej0BcprMRPxKQMTVYdpw2TzIpWU9/H8oT8YJo=;
        b=LvSN28aVODyUpBJ8c3PBY9txU8CpQPopMEdD7JlfeRbhfti3Kg/kt5FbUd/Wzgist0
         3XK47f+scNSL2uX1CTG7gfJ/HStDp6SSseMoidEeLjhEMDHt0SrvllFaaSeq2bNb48g0
         8SUdg/W2kcKXx4bJhDndlstHapZl3L2nInhLSSkJQQuyprfFjOgoYHQxBEWEEGRKAJP8
         BuHOV2SGu3SZf7Qn/c7tveIJPL7xiSn0pVBba/ZTGyMs7CHN9hCZHhGDHd6XqjDckxve
         /LYD2y9IBRj8/JhutcVNThnxVgUXnixmzZK6nQdh4vBXOGDEfuI4ExPpi8lFtgDuPQNO
         RLoQ==
X-Gm-Message-State: AO0yUKXiJqlRhNJokNAo3EqOmBo5WKbl9PHbEdJNPHEAwrBLJ9SpaVU8
        HgBVnu6JP0AlL0wW6L3B3gKD1MAKc4/YRBWCVF82uw==
X-Google-Smtp-Source: AK7set80aQ9xcQwY2+x8LZ6BGoeVxxb+rQE+8nMGr7c4kTumDEitmRxGlXj6kAWZbyV7yY1JYBLhO3Sf+Tjln94H3pQ=
X-Received: by 2002:a63:7f4d:0:b0:4fb:2d7e:998d with SMTP id
 p13-20020a637f4d000000b004fb2d7e998dmr2146063pgn.123.1676043157502; Fri, 10
 Feb 2023 07:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
 <Y6H4zqr8bObRFE1g@linutronix.de>
In-Reply-To: <Y6H4zqr8bObRFE1g@linutronix.de>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Fri, 10 Feb 2023 07:32:26 -0800
Message-ID: <CAFzL-7sL6HVDyVbafaxiq7-KN1aDTFUx8az4h0EvxJmuO6SPog@mail.gmail.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 20, 2022 at 10:03 AM bigeasy@linutronix.de
<bigeasy@linutronix.de> wrote:
>
> On 2022-12-20 10:44:07 [+0000], Chang, Junxiao wrote:
> > Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.19-rt kernel as well.
>
> Thanks for the ping. I did see the initial email and I didn't get to it
> yet. I need to re-test, confirm and then apply.
> The ktimer patch is not in v5.15 and this is currently the latest one
> maintained by the stable team. I don't know which one will be the
> following LTS kernel but this one needs to have this addressed. The
> v5.19 is not receiving any updates.
> Given the current timing, I will look into this in January.
>
> > Regards,
> > Junxiao
>
> Sebastian

Should users of ktimers adopt Junxiao Chang's patch

https://lore.kernel.org/linux-rt-users/BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com/

from 20 Dec?   It appears to be a bug fix.

Thanks,
Alison Chaiken
Aurora Innovation
