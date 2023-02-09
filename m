Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0903C636D6
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Feb 2023 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBIRJA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Feb 2023 12:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBIRI7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Feb 2023 12:08:59 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D2D402C3;
        Thu,  9 Feb 2023 09:08:58 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id lu11so8407694ejb.3;
        Thu, 09 Feb 2023 09:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Owt9Al2JKMcLBRahZV16ZouLzKUdWpbgwSwtF7vCXvI=;
        b=oZI8yzaHpcM5ilNGK4kch3SguqwxU4E74U7Mi8j7qrX7wjJTB1+KkTBDN1osJyjVhJ
         A7fHAFDmAj5Titgjep3UUNv+XBMgD15wZ0eKe55nhhnUJbYthcIAzyANfy85wXVn6Bkz
         d8AkKUUV9TyVSlYhVVkOH10PKqNoLu+vqtyGTXXNlosdM/bpvsr2hd7W0JbHtriQ+nb0
         1NdfTaiUVR3LreRg/Z8INPhjCW2eqUNFQySjy8mv/rTNWaeneT32L5nh5yY3L0tGTj1w
         MDna/q0y41tKJn4cRQIMB0UjlUkjjSO6xwSLIHnjoWq7QzJ7leFvIfnvNIwC1EqzhO0O
         t9UA==
X-Gm-Message-State: AO0yUKXBMkUqo7QnmC+44b9J8q9k1e+XlL5sudBrQoCsDLyn7xV+OWRQ
        MY+FNHliwu8i8Z9wIqzrlER6Ty4+DcKZVDqkclA=
X-Google-Smtp-Source: AK7set9gZbWI6II9D4xaxZdYUlRhWbVaqKGE2V6CVyIht3ryZhOwgUG5QwhJLxxoisFAxN2xOjadw4RoMjDDmzb5fpU=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2848167ejb.274.1675962537124; Thu, 09
 Feb 2023 09:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
 <Y9L5VFPdDnsiCluu@fedora> <Y+JWd6NfhH0sAlim@fedora>
In-Reply-To: <Y+JWd6NfhH0sAlim@fedora>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 18:08:46 +0100
Message-ID: <CAJZ5v0i4t=z2nSP5TraKNcqrSgFT7TgxNJnF0JT6CsrCVOS2_Q@mail.gmail.com>
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
To:     Adrien Thierry <athierry@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Feb 7, 2023 at 2:47 PM Adrien Thierry <athierry@redhat.com> wrote:
>
> Is there still something preventing this patch from being picked up?

Well, I've been waiting for Daniel to do that.  Or should I pick it up
directly?  Daniel?
