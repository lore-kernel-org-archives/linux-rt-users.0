Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B668BC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8546115B
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 14:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348439AbhIHOUX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbhIHOUQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 10:20:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6193C061575
        for <linux-rt-users@vger.kernel.org>; Wed,  8 Sep 2021 07:19:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k24so2751307pgh.8
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gI2iMzDEEVMelh1i5+VYRmyPAXYakzN7+DEY6weetzY=;
        b=eUUmRM8IKB9c8k2XB8wPgXxX2Vi4dWlzqVONlfiYmPZnhpmhTd2YQALB84fgcazBpC
         bvm8fN9VbClelS++9hKZteqEobZJPlDjn9v3tynYLWWivhI/OHirqMjqCI6NnI3Dsrb9
         fsR7bcBOjCCvr8o9TCnl3fnzkT3uYH5EE0RhOy1d+mFDUJ7gtGxYq3CX/XRMVA6VmEdD
         6lFqo0fVfcDge4idFnKRIHUV1QpV/fhiCIVQTpOmI9VmoDmcKAMaTcr82QUb2TPyqiKd
         2orS59jFerOhR5qGcbn76xszmTwa9h/cP0s5e2zj2v00B8Ye1lPrzPwTO1OKpsRPLLSo
         bVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=gI2iMzDEEVMelh1i5+VYRmyPAXYakzN7+DEY6weetzY=;
        b=59B6mmI+g02noVwLnKsQOwUxYsaRmn8vJzp9Q3IGelxnP0EinLZ+LgqJS0gZ+WeoJ+
         RLk0kgt5ytDPj8iDO5QMkJkMPmS4X+ruMTLD8N/LyzaPOomDwNEGqoDaNar0dUPSzzqk
         MS2XHKqUrAPOipDgL/whQo+bbyDe0hRuYoaWqtNpLUfuo2VM8rUvOpC5XRYXmbY3ecWy
         GbwolaTN0xYBDYiFijMJnrhpzLKd3o739S25EXNCuGZ+hZjbeNJ7tRhLBvk7ERJX3H2l
         gnWEx7R07jJzDKOkedGM/jBNqXqJMDtvi2BsM0GiC7Ve+RYkQeY28RcCfopEQHgXM7a4
         EQ3g==
X-Gm-Message-State: AOAM530AyAZZdHUK11WiU0zRmQqtLyG+6kFEFy9mPRflGtFFgN4ZIrRd
        GXlRF0T4JOFaIJm7KM+nR84=
X-Google-Smtp-Source: ABdhPJynLHwkQenKK9TurmB3C1hpUNpRExQZbpNZfhX+NtmovDDeMdcPNX1LhGl/osEhyP0EBGx6Cw==
X-Received: by 2002:a62:ab04:0:b0:405:c1c0:543c with SMTP id p4-20020a62ab04000000b00405c1c0543cmr3904322pff.36.1631110748215;
        Wed, 08 Sep 2021 07:19:08 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id q9sm2694872pfs.40.2021.09.08.07.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 07:19:07 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        Venkata.Pyla@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com
Subject: Re: [PATCH 0/3] rteval: Fix issues with cyclictest.py module
References: <20210902092452.726905-1-punitagrawal@gmail.com>
Date:   Wed, 08 Sep 2021 23:19:04 +0900
In-Reply-To: <20210902092452.726905-1-punitagrawal@gmail.com> (Punit Agrawal's
        message of "Thu, 2 Sep 2021 18:24:49 +0900")
Message-ID: <87fsufb15z.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Punit Agrawal <punitagrawal@gmail.com> writes:

[...]

> The second patch uses the max latencies reported by cyclictest vs only
> relying on the histogram latencies.
>
> The third patch fixes the ordering of reported latencies.

Just realised that the "From" and "Signed-off-by" in patches 2 and 3 are
messed up. I've fixed it up locally - will wait to see if there is any
other feedback before resending.

Thanks,
Punit

[...]

