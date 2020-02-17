Return-Path: <SRS0=Nlir=4F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F1AC34022
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7770D24689
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 18:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgBQSdJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:33:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34237 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgBQSdJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Feb 2020 13:33:09 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j3lCd-00050B-Uc; Mon, 17 Feb 2020 19:33:08 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 686131039FD; Mon, 17 Feb 2020 19:33:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: kernel panic in SPI rt driver interrupt
In-Reply-To: <CAPm8-H5uS-1TFPj_OZZe=tFuFya-RaW2_a_Ehfu4eFsd0D4xYw@mail.gmail.com>
References: <CAPm8-H5n0f3dAEa=vM++aUZTxu4H_zvNp-4bjzriByJDGSefnA@mail.gmail.com> <87pnednl5b.fsf@nanos.tec.linutronix.de> <CAPm8-H5uS-1TFPj_OZZe=tFuFya-RaW2_a_Ehfu4eFsd0D4xYw@mail.gmail.com>
Date:   Mon, 17 Feb 2020 19:33:07 +0100
Message-ID: <87mu9hnjx8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Laurentiu-Cristian Duca <laurentiu.duca@gmail.com> writes:

>   Please tell me
> what alternatives exists to replace wake_up/wait_event ?

Look at swait and please do not top post and trim your replies (see below).

Thanks,

        tglx
---
https://people.kernel.org/tglx/notes-about-netiquette
