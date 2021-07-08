Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7BAC07E96
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BD76142C
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhGHP2D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:28:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52362 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhGHP2C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 11:28:02 -0400
Date:   Thu, 8 Jul 2021 17:25:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625757919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yu4gJQSQJPCnB2mWr7Pg8B/HUqEFyTThj9cTjNcobio=;
        b=VApslWOoN6tLc3BrciLX0PBZhiNOo5wwXrt2rnKT/5WVCTM0w/uvXQSDW9JDXJc85j9HvZ
        MWnppilXOsxed+bmre8iIoky3SaBqhJv9s0ot3HhVU6l2VhbR3p6nWF+rTrm/lK68MSpTX
        w92oZsHolI7xitdKmqpoy+jpbRrJ0e3JLrRlIiV02tcbwY9u7/eqTpD5wFf2nw+kr7JYDW
        BT5pO2AG94mWqE68/T7xW8isEMout3byl/W1lO6zh0JoeIQEonSDpw/LPcfiCjcT+yqpNd
        Yi78JxKovTFUEo3wUyPsjXpHgymwk0kys5QyJE0M4wk0X1i6DxvweUJt4wiaVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625757919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yu4gJQSQJPCnB2mWr7Pg8B/HUqEFyTThj9cTjNcobio=;
        b=9Ta20Itl9/3MGag0DhS8m5eIP22zarmoDCMiTHQdecvmNF13NE6WpxKpiBA3P2m76a0zVC
        u86AeO8uSpl9/wDw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Matthias Klein <matthias.klein@optimeas.de>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Working sample 5.10 kernel configuration for an IMX6 board?
Message-ID: <YOcY3rH7Q0DjyOyj@lx-t490>
References: <AM0PR10MB3107F4D6E0F50ECB027C06A199199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR10MB3107F4D6E0F50ECB027C06A199199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jul 08, 2021, Matthias Klein wrote:
>
> What should be the maximum latency with kernel 5.10?
>

Assuming that it's an official -rt release and the defconfig is properly
sanitized, for imx6 SoCs you should get worst-case latencies in the
100->120 microseconds range.

--
Ahmed S. Darwish
Linutronix GmbH
