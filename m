Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763D6C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 10:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578B861A56
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 10:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353219AbhJAKw3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:52:29 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:60284 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353212AbhJAKwN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Oct 2021 06:52:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F209C5E368;
        Fri,  1 Oct 2021 12:50:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1633085416; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=FDfzp9LOOb9JVoa9kOAu0GSjBzbTxiybXsypOlrOw6c=;
        b=eJEsxbTI9NkqOUVvKH5M5w2rfvfH17D5arP00nL5zXjft4O3OW4y5IhX8Hhl9xF8/ac+zk
        KUh72u1dr13+GxiETnJSdMjUIOj/6hac91PuHICTdtDaBV54qF2A4PVQiXD08fQNtAl7AO
        VdPCo/eI4sX80vqee6BG0gnCeUUTipWDj8sUhcd5iRJhhzLBODexjUZSV95lijSTwNbw06
        daBl7OB6oeA10HgpmOuy8KvjDt3ciHdRVx/8c63wA8s2if8qD77KkZCmTm3fk39MICEQ/o
        0A2yUVS9g2wI+s2ZsJHLymrkzPj7ffOPWgWSNCKjUVQYtuqa2s6BXn32LJXc3g==
Message-ID: <d799b41b-1ed8-75c2-6b4e-bb6f0f06eef2@monom.org>
Date:   Fri, 1 Oct 2021 12:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [ANNOUNCE] 4.4.285-rt226
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
References: <163307726840.24858.2277036113555626320@beryllium.lan>
 <20211001093927.d4q26bqyeh4s2iik@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
In-Reply-To: <20211001093927.d4q26bqyeh4s2iik@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 01.10.21 11:39, Sebastian Andrzej Siewior wrote:
> Did you update keyring on korg's side?
>     https://korg.docs.kernel.org/pgpkeys.html

D'oh! No, I didn't. Thanks for the tip.
