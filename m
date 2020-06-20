Return-Path: <SRS0=Kj7U=AB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3786BC433DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Jun 2020 12:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B0522DA7
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Jun 2020 12:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgFTMf5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Jun 2020 08:35:57 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:43190 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgFTMf5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Jun 2020 08:35:57 -0400
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
        by smtp4-g21.free.fr (Postfix) with ESMTP id D7CC519F5A1
        for <linux-rt-users@vger.kernel.org>; Sat, 20 Jun 2020 14:35:25 +0200 (CEST)
Date:   Sat, 20 Jun 2020 14:35:25 +0200 (CEST)
From:   ycollette.nospam@free.fr
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Message-ID: <827480934.496190376.1592656525756.JavaMail.root@zimbra35-e6.priv.proxad.net>
In-Reply-To: <238119586.495839939.1592647783365.JavaMail.root@zimbra35-e6.priv.proxad.net>
Subject: Re: v5.4.17-rt10 does not boot on intel
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [79.83.134.110]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I manage to build a pure vanilla RT kernel (without the fedora options) and it works.
An option in the set of fedora options makes the kernel-rt unbootable.

----- Mail original -----
De: "ycollette nospam" <ycollette.nospam@free.fr>
Cc: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Envoyé: Samedi 20 Juin 2020 12:09:43
Objet: v5.4.17-rt10 does not boot on intel

Hello,

I am trying to build the last RT kernel on Fedora.

So, I've downloaded linux-5.6.17 and the last rt patch from kernel.org
I apply the RT patch to the linux sources.
I clone https://src.fedoraproject.org/rpms/kernel.git and checked out to f32 branch
I run $ ./build_configs.sh linux-5.6.17
I copy linux-5.6.17.x86_64-fedora.config as .config in the linux-5.6.17 directory.
Then, I do a make xconfig
I check "General Setup -> Configure standard kernel features (expert users)" to be able to check "Fully preemptible kernel".
I save the conf and copy the .config file to be able to build the kernel via a spec file.

I used to build regularly the RT kernel via this procedure (the check "General Setup -> Configure standard kernel features (expert users) is new to 5.6) and it was working fine with 5.4 kernels. Now, the installed kernel doesn't boot.

Is there something new I am missing to be able to boot the kernel ?

Maybe it's the options selected by the fedora script which have a problem.
I doesn't apply any patches to the RT kernel. I just wanted a "vanilla RT kernel" with fedora options but without fedora patches.

Best regards,

YC
