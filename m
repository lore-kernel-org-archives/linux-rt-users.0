Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AA8C001B0
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Aug 2023 13:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjHJNPC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjHJNPC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Aug 2023 09:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B2810E7
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691673252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kmfam80QExqiuGt2xc2AE7vQsiC0sgXDnaRLeGbefY0=;
        b=DhoKavj1ZgubqXWUFtqQ786nLGd45gh7VH1i/ukyA1mEcmau5nUh2h0sQMczvPMqsfUFEG
        8umu5RdPr2zpOqk1N75R7GDP9HxTwDiijEHG5JIbiSPlgbEsGsFInvfTYFHrkk93vSS8Jh
        o7vkBvbhEyRHFU14rgtL9Wl8+sVLBAc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-VJ9Ei7s7NpaCKxznLK85CA-1; Thu, 10 Aug 2023 09:14:10 -0400
X-MC-Unique: VJ9Ei7s7NpaCKxznLK85CA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcf6ae8e1so70542066b.0
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 06:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673249; x=1692278049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kmfam80QExqiuGt2xc2AE7vQsiC0sgXDnaRLeGbefY0=;
        b=HfqllA9MAULtiePttGA6fLJwGJva8nxhIQf+9z4nG76kTbaQAcO/JYBeEnlyNeNVOh
         deJAakgdmfwnMKS2Yl7P5Q3pk96G9bWgthVlNAFbq5OSU2u6oh/U/gUW4mz1RMhgla58
         nZi+c//6PO4l/cSs4ZStSDEK+t/v+gl8gTpQDpO4xDiIPTjbpZXI/hJcm69K4hbhAtdF
         /VRdjPC7Skuzbjw+gWmUESqFCe5w3lbTZd4xmMlwJFpsQXKGNR1k0/xk6x2VDZ6bSNw/
         N0f8SBmBIEfoVUpQmZgOBy1jS0AxrQmPU5ybIqoOeupEprkNlEnBgGxVW16/87u4iAkb
         4sHA==
X-Gm-Message-State: AOJu0YzIph+u1N/neX/ljwpoV6MBpXv2e8qT9EcOUji649TJYQ15o1gy
        lZKs7HbJBb6zmcdF6OossbG8vhlqLAd8D/QR0dYmjS0YyGAFrembrerogmK4K2BiXgpPnZrHGCX
        9XgUtx2vgTIbE8GV+8FE1JD4juKWnll1lr6MWFiVVD0Ye3TKiI7d6s7iY
X-Received: by 2002:a17:906:73c2:b0:99c:10e8:52d6 with SMTP id n2-20020a17090673c200b0099c10e852d6mr2175237ejl.39.1691673249493;
        Thu, 10 Aug 2023 06:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWOy/M9kz567AYC+IO4h2vCRGwxQYZaAwtIq5uWnZN1RS3vUYN7n/lVh8Fykhx/wOcnbiSuMruNbOrdwNMCUM=
X-Received: by 2002:a17:906:73c2:b0:99c:10e8:52d6 with SMTP id
 n2-20020a17090673c200b0099c10e852d6mr2175207ejl.39.1691673249000; Thu, 10 Aug
 2023 06:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230810090123.151924-1-tglozar@redhat.com> <20230810090123.151924-3-tglozar@redhat.com>
In-Reply-To: <20230810090123.151924-3-tglozar@redhat.com>
From:   Tomas Glozar <tglozar@redhat.com>
Date:   Thu, 10 Aug 2023 15:13:57 +0200
Message-ID: <CAP4=nvRvD=upsPrbDRL2tOOhVi+9h88u5q++10XYfXmV8e_URQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rteval: Add run_on_isolcpus option to measurements
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

=C4=8Dt 10. 8. 2023 v 11:01 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
> @@ -146,7 +146,15 @@ measurement profiles, based on their characteristics=
"""
>
>      def SetupModuleOptions(self, parser):
>          "Sets up all the measurement modules' parameters for the option =
parser"
> -        self.__container.SetupModuleOptions(parser, self.__cfg)
> +        grparser =3D self.__container.SetupModuleOptions(parser, self.__=
cfg)
> +
> +        # Set up options specific for measurement module group
> +        grparser.add_argument("--measurement-run-on-isolcpus",
> +                              dest=3D"measurement___run_on_isolcpus",
> +                              action=3D"store_true",
> +                              default=3Dself.__cfg.GetSection("measureme=
nt").setdefault("run-on-isolcpus", False).lower()
> +                                      =3D=3D "true",
> +                              help=3D"Include isolated CPUs in default c=
pulist")
>
>

This code is broken, it does not work when rteval.conf has no
run-on-isolcpus field:

$ sudo ./rteval-cmd -D --measurement-cpulist=3D0-7 --loads-cpulist=3D1,3,5,=
7
got system topology: 1 node system (8 cores per node)
Traceback (most recent call last):
 File "/home/tglozar/dev/rteval/./rteval-cmd", line 297, in <module>
   measuremods.SetupModuleOptions(parser)
 File "/home/tglozar/dev/rteval/rteval/modules/measurement/__init__.py",
line 155, in SetupModuleOptions
   default=3Dself.__cfg.GetSection("measurement").setdefault("run-on-isolcp=
us",
False).lower()
AttributeError: 'bool' object has no attribute 'lower'

It's trying to lower the boolean value. I'll send a fixed v2 patch.

