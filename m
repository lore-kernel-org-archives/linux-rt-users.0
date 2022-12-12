Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB57FC4167B
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Dec 2022 10:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiLLKmP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Dec 2022 05:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiLLKk6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Dec 2022 05:40:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E411A22
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Dec 2022 02:35:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gt4so9894547pjb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Dec 2022 02:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0xaWoW6JDlR+88t9m04EXynCTQRT5q4T7uT/UEYCbI=;
        b=KCPFIEgU/xccX0DayZWxhAme704aHRXQ5Z86Z0Vl8sLVnQOhN1JEFZdPBRBt3aCKPy
         jGgT5aMU6AoOHmXo1NbtSBxhLKHTpfDKbT7Lvz76EsgU3D2iIQT6gBjAZSv73NpE3IcN
         pQ1+WWppjCLrHAtuTV8C4XPL1RNidBoH4x/mj7bBAVfY/VIbwK1K/zt6XDu6KKxPwPPj
         vDWklXnIif7PClOPu45Kwy8Fmhb51Gf6VYClDLQh6E2KunTK7qpqz5S/hUIoIzDTopAF
         n5coBj5HWrLkJ4IsKkn1Ns6sGcl4hVNcXpkpoxUyRqeTjt1JZ3YJ/Esw3ED0picASp2S
         TkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0xaWoW6JDlR+88t9m04EXynCTQRT5q4T7uT/UEYCbI=;
        b=c0zMSqxqxQEHdh/AxOZ/qrWOgUH6OQsWrersHo/898tPXKaqMytZyKAhvlaDs9Qmjf
         hw86xf+UPdprlfCQDoSH6Ool9xZbI/CQVtIrnEw4vT6+CAI1sGz3CQsjoYW5zJRbz+X+
         8iL8o2syyXuKpkry9BoV68x97IvIGbZrw2opkqZF9Vi97HWrcXJtyIZzkAOAPUpokdr+
         HyxdHIsO5gotxdBupHGbhMJlkCyfraE49tE3bq3nWEqAGlrVs8bZE9S5ADXE515YFcHw
         lW99xG1eFWuWhtS/PwFIMw+2gmGA1jB1LJYFiCqXO0hASYgKIJYzCaYg6oSt/3rd5SMj
         4qcQ==
X-Gm-Message-State: ANoB5pkOWPCqdkRSHf8waKrO6zKG0LMsjVYy5vD6VcQ6ADXtQvT8QyXf
        bQnROOTKQ3uhXZP/Qku7P/yIGT1PUxVTDgGAE9+Z3UJr01ckrTp1
X-Google-Smtp-Source: AA0mqf4fJNvG0UxIOZc6e3MdXz2AcXAYTeKGu0YueB0y5qZDUbPu7zNW7siM4zmBdQylwPQkb79hhACPHNNr82kmYds=
X-Received: by 2002:a17:903:2791:b0:18e:ade3:a523 with SMTP id
 jw17-20020a170903279100b0018eade3a523mr282016plb.35.1670841325868; Mon, 12
 Dec 2022 02:35:25 -0800 (PST)
MIME-Version: 1.0
From:   Danilo Cezar Zanella <danilo.zanella@iag.usp.br>
Date:   Mon, 12 Dec 2022 07:35:14 -0300
Message-ID: <CAAxUTH4L-eRTdnOE6cPaa6wZUawJ2sU_aToKygR98xmXJvu+QA@mail.gmail.com>
Subject: pci_alloc_irq_vectors problem further investigation
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

There is a driver developed by EmbeddedTS (the board is Marvell
armada-385, dual core processor) that tries to allocate 32 MSI
interrupts, using pci_alloc_irq_vectors(..,32,32,...). When I ran the
Kernel (4.14 NON RT) provided by them, it worked fine, but when I
recompiled the kernel (4.19.249 using the RT_FULL options), it didn't,
returning -ENOSPC.
In RT_FULL Kernel:
- First fact, when I ran pci_msi_vec_count, it returned 32.
- Second, if I changed to 16, calling
pci_alloc_irq_vectors(..,16,16,...), it  worked.
I traced this kernel and I found that:
pci_alloc_irq_vectors_affinity
  __pci_enable_msi_range
    msi_capability_init
      pci_msi_setup_msi_irqs
        msi_domain_alloc_irqs
          __irq_domain_alloc_irqs
            irq_domain_alloc_descs
              Then I stopped here...

I searched on the Internet, but I couldn't find anything.
Has someone had a similar problem?
Is there something that I missed? Some configuration??

Thanks

--=20
Danilo C. Zanella
Radio Astronomy Group  / IAG
University of Sao Paulo
Rua do Mat=C3=A3o, 1226 - Cidade Universit=C3=A1ria S=C3=A3o Paulo - SP - B=
rasil - 05508-090
Tel.: +55 11 3091-2743
