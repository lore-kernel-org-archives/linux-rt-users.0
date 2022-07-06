Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FCC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Jul 2022 21:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiGFVq5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Jul 2022 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiGFVqz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jul 2022 17:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 228AA220D1
        for <linux-rt-users@vger.kernel.org>; Wed,  6 Jul 2022 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657144014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joyJJVyoLUPkLztwODUG+QDGkiaxx0uWHH+mUGdONfc=;
        b=JemIvKPdBQqSp1RPskPvQHqNwSI1FUdLTvJUFh/vA86kLlo4LkVWdcvhkHEM6Y4A30DjyJ
        u75X23nYCeRxWcY9h24gjx6AVU3yJfrQIyPepOZcpRVicDblKXmei23p7t/4C9X3t/6Oik
        tfEKNh4WYZkW4iyFLzHc4eenqG/piKU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-riVpyEM9M8G3g3DovdIJIw-1; Wed, 06 Jul 2022 17:46:47 -0400
X-MC-Unique: riVpyEM9M8G3g3DovdIJIw-1
Received: by mail-pg1-f197.google.com with SMTP id e4-20020a631e04000000b004128f83af17so1459108pge.16
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Jul 2022 14:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=joyJJVyoLUPkLztwODUG+QDGkiaxx0uWHH+mUGdONfc=;
        b=Kh/h8qWNlq9Ab+enMeif8J6WOoOERL/h7dzgquHD3gmhvuu9MfF0seXSZdiPPt5/ba
         nhuN84X8mX2/dXlzR9sgQgd5koUMq9jkXBEy65d5SDSljHEsccMswU+6tyydNszh+OUq
         ATfo1A1Q9y8u+bKYZZLMcUFFcwI1/wj3w6/EzRuxl+++3KQBV2yjnDuqLigTcUm3eR6X
         Qrs8zxXE7k9oJCILX7kRvv1Z73cGH5gypX4hR9IyhWE1h1mrHoFTkUhyHADYxhzPn6fz
         dzhwlXclYkW7pGEb810MClfNUQbfUJJRSrZ+CcNDNjTMbWKNPCJhwqRwnvr9fKpOVqbi
         SyHQ==
X-Gm-Message-State: AJIora/1Q8Ncy7/rsu37NiOkgdjPNXdbvDDaR06l7ilsx8IFdWLShElj
        /hSXf8DMZJLlHcOyRo3h3F53bnZrmyAGEqXFPLsaYFr5PmYRHSuD2M4792D5U8uK7b5PCR8GaE9
        ybBeAvhcaRKVCiPYZSyEBYHXKi8SHZ45SpdV6x+76iwQ=
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr50337559pfj.83.1657144006171;
        Wed, 06 Jul 2022 14:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t3rDeyvlzIKIiND/pKdF1DKr00yTaK6v+7NDvVjs9hSy5tvpxFzJ6B+obpQ9PqRwXYjG21NthPatj30k33Gg8=
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id
 t8-20020a056a0021c800b004fdf89fec0emr50337540pfj.83.1657144005886; Wed, 06
 Jul 2022 14:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <45632dfb-5671-b6d6-3c84-e047d1257dbb@canonical.com>
In-Reply-To: <45632dfb-5671-b6d6-3c84-e047d1257dbb@canonical.com>
From:   Clark Williams <williams@redhat.com>
Date:   Wed, 6 Jul 2022 21:46:34 +0000
Message-ID: <CAMLffL8pUzD+=FAnJoTuqpGi3x9LjeA=Kyui7Z5xv=DOQW=ZzQ@mail.gmail.com>
Subject: Re: Question Regarding [PATCH 098/167] in the 5.15 real-time patchset
To:     Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     "Gleixner, Thomas" <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I know we've had latency issues in the past with memory cgroups.

If there is a change in behavior in 5.16rt+ we can consider
backporting down to 5.15-rt

Clark

On Wed, Jul 6, 2022 at 8:25 PM Joseph Salisbury
<joseph.salisbury@canonical.com> wrote:
>
> Hello,
>
> An end user reported a bug[1] when attempting to use an Ubuntu kernel wit=
h the 5.15 real-time patches applied.  The user reports an issue with missi=
ng cg memory when Kubernetes is used with the 5.15 patchset.
>
> After an investigation, it was found the issue is happens if the CONFIG_M=
EMCG config is not enabled.  That config is usually enabled for the generic=
 Ubuntu kernel.  However, the config is disabled by the following patch in =
the 5.15 real-time patch set:
>
> [PATCH 098/167] mm/memcontrol: Disable on PREEMPT_RT
>
> I don't see this patch in the 5.16 and newer patch sets.  Is there a fix =
in mainline or in the newer 5.16 patches that allows the 'mm/memcontrol: Di=
sable on PREEMPT_RT' patch to be dropped?  If so, I could assist with backp=
orting the fix to 5.15 and older.
>
> Thanks in advance!
>
> Joe
>
>
>
> [0] https://bugs.launchpad.net/ubuntu-realtime/+bug/1978814
>
>
>

