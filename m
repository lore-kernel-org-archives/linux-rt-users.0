Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C1C54EAA
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Jan 2023 22:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjAZWHC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 17:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAZWHB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Jan 2023 17:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A525DC3C
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jan 2023 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674770778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJ/8nX4zvnH/ty2ST5KcgskeZg0+7IEmI7sIejuxW3M=;
        b=LoLnXOvooHzULZcI28LEonQXtoveew96/N0Ky5cVJaqNq/5Hhb1zdbNEKAa4Zhoq96Px5E
        HHuDjEeeFldUnacnh8K1KkSXRV6G6DqxsNih2EppJuYyZX2iN3L3uy88YpP9goDPwpuePH
        MVUn2dkTRd1BMdDOVGZ6TspqidSMYoQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-fOk0kKd4MjqCU3v1gWzskg-1; Thu, 26 Jan 2023 17:06:16 -0500
X-MC-Unique: fOk0kKd4MjqCU3v1gWzskg-1
Received: by mail-qt1-f199.google.com with SMTP id cn7-20020a05622a248700b003b7f2a89829so1399169qtb.6
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jan 2023 14:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ/8nX4zvnH/ty2ST5KcgskeZg0+7IEmI7sIejuxW3M=;
        b=MYnRSohLG3WIeGDgPsxxnWJO+O0pSprvOgJ79riVmCax0krQtDbNfgrYdZiELPKO4c
         /7by8hNeGyyiv/cYc+TfLaEVLtV763qaD7KUgLldqL75wGobjoF0jRhRT9IbcnCrhgZq
         Apcdp9PEfAl9Dgqwi2ucdsFAiKYCRnoSb4H5Puhta7UNYIe78httUo74qv7Nm7qsLSl+
         frKZCbqTq4c4al/cRCoSFqjiJXJdKLbG/0n/xysvYBPnu0ksakI2dSDX+UAQ4+LwwRrp
         M+p79nlqGJy2iI+Nyf0uIMCV1DcFyBuBYWBvpne7RlnyTsij6zsazF7LW4UYVMp6l59b
         gKww==
X-Gm-Message-State: AO0yUKUiIt7aIvV+b0mKPob6CaDrpnFjPdiNNg8nRhcb9UyOo6iKECMg
        8U3Pe3s6blugxjH0PohNYpGMO/AaCoZr3qnhjrGUSpVDo9TtM/I1zoWS+w8EIvRCJ1YK0gjcJ9v
        F2AejlwWvJTeE/D+bN+RZiITMxMk=
X-Received: by 2002:ac8:5c09:0:b0:3b6:377d:4330 with SMTP id i9-20020ac85c09000000b003b6377d4330mr14060709qti.29.1674770775836;
        Thu, 26 Jan 2023 14:06:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9yWYt2rhCoYu5m2yMmMGUlTPpm6onbgSgfZq2E5c1G86CongsU6U+8xg6KgYsC0Zolr+xW1g==
X-Received: by 2002:ac8:5c09:0:b0:3b6:377d:4330 with SMTP id i9-20020ac85c09000000b003b6377d4330mr14060673qti.29.1674770775515;
        Thu, 26 Jan 2023 14:06:15 -0800 (PST)
Received: from fedora (modemcable181.5-202-24.mc.videotron.ca. [24.202.5.181])
        by smtp.gmail.com with ESMTPSA id br9-20020a05622a1e0900b003b62e8b77e7sm1493538qtb.68.2023.01.26.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:06:14 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:06:12 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Message-ID: <Y9L5VFPdDnsiCluu@fedora>
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Krzysztof,

I tested your patch on the Qdrive3/sa8540p-ride on 6.2.0-rc3-rt1, and it
fixes the issue I encountered in [1].

Tested-by: Adrien Thierry <athierry@redhat.com>

Thank you,

Adrien

[1] https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/

