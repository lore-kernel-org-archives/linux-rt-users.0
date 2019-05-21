Return-Path: <SRS0=3Yn1=TV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393CFC04AAF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 May 2019 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7343217D4
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 May 2019 13:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dkim.kinghost.net header.i=@dkim.kinghost.net header.b="h2eClPu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfEUNIM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 May 2019 09:08:12 -0400
Received: from smtpi-sp-240.kinghost.net ([177.185.201.240]:53834 "EHLO
        smtpi-sp-240.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUNIM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 May 2019 09:08:12 -0400
Received: from t460s.bristot.redhat.com (unknown [193.205.81.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-240.kinghost.net (Postfix) with ESMTPSA id F18B26000EA3;
        Tue, 21 May 2019 10:07:58 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; 
 d=dkim.kinghost.net; i=@dkim.kinghost.net; q=dns/txt; 
 s=king1; t=1558444086; h=subject : to : references : cc : 
 from : message-id : date : mime-version : in-reply-to : 
 content-type : content-transfer-encoding : subject : from 
 : date; bh=5Cu5/3qsQ4RtkVchBi9KjLMdZH4IfQU5/VHI24zODFY=; 
 b=h2eClPu2gPvFZBTR2wUa5PJk6nmlNlBmYo4AxaqFYb2zab4OlKJrT2tN
 sGWdcwLtcO9LzM1D9rtVxewetRU58/P8A/gYD0WC0DorcZGzWQ5cCN3WMG
 Vg5M3N4I7P/xDkC9sn8YOX5AtXtrHuWLz6IjmiF2xfpN8os/aDi6p2CzI=
Subject: Re: Real-time micro-conference proposal for Linux Plumbers 2019
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
Cc:     dhaval.giani@oracle.com, Frederic Weisbecker <fweisbec@gmail.com>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <d0d44fb3-ac4a-c0c4-a9ce-76736ca70e31@bristot.me>
Date:   Tue, 21 May 2019 15:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zkN1fvCQFye4Vp0qZLm01pjwTyxMh+7iR1os
        bUmon5Iq4Bn97dzkH6PssLEnJBk7i+cqOWLxBbj82TbOaxVnqLLQ263RGC0I
        wd3g16ajOT4F/AGOBPqw3dfH7Yg2vLnnATSLk/tm+FbkxOcRIu4VTWUmiKdw
        uCg6J8n7gfWcmeBkAjBEDZS8JVuQwoNwQRE1M6oKnLgLicKNJ0RGDm9rFJKj
        I1UuG4ZfPPYywdPtCAJNUDFLrbzo7/EXN4FD0wtUGqfmwPXfOLEVi35ob47q
        vmnOiIOVq7r76RHBjri/GKsrpTiAwyh2pkMoHOF8tyU7wj2yar4csCLa3j2o
        Ps4RKBVnno2b5GmZCY5NxH2fry5tSP4YnnuKNJENOnwEaiSfE5aiShDAfGzk
        vxl7hXkPbxpWN1Va1/2G3hlg5NsCrfJ0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 5/3/19 8:53 AM, Daniel Bristot de Oliveira wrote:
> Hi all!
> 

Hi all!

Good news from OSPM!

I just talked to Frederic Weisbecker, and he is proposing talking about the
softirq rework that we need - as a step to the -rt merge!

Dhaval Giani is also mentioning the possibility of talking about their needs
w.r.t proxy execution!

Anyone else with a good idea? stable-rt people??? :-)

-- Daniel
