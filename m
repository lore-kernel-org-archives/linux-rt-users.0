Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32A5C636D6
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Feb 2023 13:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjBGNs1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Feb 2023 08:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjBGNs0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Feb 2023 08:48:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE86193
        for <linux-rt-users@vger.kernel.org>; Tue,  7 Feb 2023 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675777660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XA/I3fzzNYZ//8/vwERAn+P62R3VluePPy0fivL+Wr8=;
        b=FISClwm9n2lK3nXC1EJXUFPtyGgEYcjLqBDtj/ZfPDxoAT3GJXU4bIqo59efpvohntqtSq
        wt1zmCfFG4hBABcgPqadv97DTpBcq4Bcq/tF2X50u2Z2u9m8ZOjApoWXDtZ1O21HzRBV0j
        Q6NDaeBk2jRkpGBpF5wD4k3YIo7tBAo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-EImMJAZcP3CtMX5BtgtSXg-1; Tue, 07 Feb 2023 08:47:39 -0500
X-MC-Unique: EImMJAZcP3CtMX5BtgtSXg-1
Received: by mail-qv1-f72.google.com with SMTP id dy3-20020ad44e83000000b0056bf716c68bso3079436qvb.10
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Feb 2023 05:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA/I3fzzNYZ//8/vwERAn+P62R3VluePPy0fivL+Wr8=;
        b=5N1UxcfEoJ226Vfti1StDCs9LKgSs93tiCvzIQTch7K59rolQaLcaBMERSV3VzAYXe
         akM6kItb8i2Iv0ChIjtvMqK3yx5sf+Ys/jLZDvAuv7YR0FmsZSXb1zX3qM5bCRkYW8/n
         qj17zKEInhWCw2T/YVVgSK9PZOkT+Rp/yZxYhOiSxdwL7dESC8CFjP74qbvp3prNpcqy
         v47MOjjXqvKssm6Vc8NE0w71qpyVYoi4Gig31qRN7YbEIidhVOoFm7KLxPqVEtBIT12u
         tlvz/6vVCn7y3XvMtbHa2bZ4QASEBXjlgGNZ/FiVEqjbdL6MfyCuATYAp7VDtgljzo7V
         krQQ==
X-Gm-Message-State: AO0yUKWc3jnazG8omuXANcRfC4QdOdtf3WSHKeut3OnbSchlWgLrNrGO
        dWpf/dDL9wVJFxOZn3oyl8WYEipbQ0pBtJjLZzVXMXL/RBKABHvumboM684Gc5Y0/1eP+OXJ3vK
        GQoFEWcPi7OLzjwXOq+ajrM6YqK4=
X-Received: by 2002:a05:622a:508:b0:3b8:6075:5d16 with SMTP id l8-20020a05622a050800b003b860755d16mr5879071qtx.56.1675777658674;
        Tue, 07 Feb 2023 05:47:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/ejwgCvHaxLr87VY1OqTrLmCn+q6U4BxbYz736hZ4+blH4zqNep1u4j55SpjNPGPQlVa5mTQ==
X-Received: by 2002:a05:622a:508:b0:3b8:6075:5d16 with SMTP id l8-20020a05622a050800b003b860755d16mr5879035qtx.56.1675777658395;
        Tue, 07 Feb 2023 05:47:38 -0800 (PST)
Received: from fedora (modemcable181.5-202-24.mc.videotron.ca. [24.202.5.181])
        by smtp.gmail.com with ESMTPSA id pe4-20020a05620a850400b0071ada51ab48sm9503353qkn.37.2023.02.07.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:47:37 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:47:35 -0500
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
Message-ID: <Y+JWd6NfhH0sAlim@fedora>
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
 <Y9L5VFPdDnsiCluu@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9L5VFPdDnsiCluu@fedora>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Is there still something preventing this patch from being picked up?

Best,

Adrien

