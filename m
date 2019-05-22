Return-Path: <SRS0=tVcw=TW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA63C282CE
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 May 2019 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B82820863
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 May 2019 13:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfEVNmb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 May 2019 09:42:31 -0400
Received: from smtpi-sp-247.kinghost.net ([177.185.201.247]:56933 "EHLO
        smtpi-sp-247.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfEVNmb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 May 2019 09:42:31 -0400
Received: from t460s.bristot.redhat.com (unknown [193.205.81.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-247.kinghost.net (Postfix) with ESMTPSA id 0C3216001FAA;
        Wed, 22 May 2019 10:42:24 -0300 (-03)
Subject: Re: Real-time micro-conference proposal for Linux Plumbers 2019
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <e768f352-6831-8427-3d66-92dfbfd28c3c@bristot.me>
Date:   Wed, 22 May 2019 15:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zt3ssnX7rTamrKHGXZyUMpK7H3tNxExK/LGF
        vZAzlxneJ4qNywA+5sUkem+xvNYsm0b1LsFK7XulEpFNYZM+96vkG4CLWXmz
        w91O3wG7/+ioLRRTLtfqZAbhkmFybbe7YchQYCcrnE8TN/jW50qxIEQQkJVD
        JGKhlb1w07Oiv4e6ctgnMdAEG2WD8sZZxVmhlpngfvJgGmZD1Wjs8D+DZA1j
        e6THrZr9Z5yYuf/5Jg7Tj708ZTSXdwgkxuQDOwxBxXjRsYJoN5HE2Kbvsrhk
        exeeVrxaLbXuPA0PU+Q9XxG20OW+cNXHUMpw6mpwRoUmet7EFVPaI7B6UPH4
        DZ8/sVc7uqwMcmpDqKZCta5lezWHNf1KyGYGflBjg6jfqVEz/Q==
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 5/3/19 8:53 AM, Daniel Bristot de Oliveira wrote:
> Hi all!

More good news! Peter will do one slide about RT and core-sched! I updated the
proposal with all the suggestions!

Thanks
-- Daniel
