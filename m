Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF01AC07E95
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Jul 2021 05:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60F061002
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Jul 2021 05:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhGMFoE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 01:44:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGMFoD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jul 2021 01:44:03 -0400
Date:   Tue, 13 Jul 2021 07:41:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626154873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sRNn/WOr7SYMuB0AJwZaTur5eVpfHXOr0MqTJe3rxDY=;
        b=SmwSnoKYWm1oYYhlDjzN/r7T07tMNnjQOzI1hmm8PfBFyueaQkTu/HB3xO8qrwhkJ9Rh0x
        PQb57g/hMCwrb83JJShbBxtWr+lR+sVO6HVb5KmY3jXrGslqUKo/9gX27jM8T97K6/YYdS
        vvriBH6YMMlQOLMM8MMXYysAkJNOdEP+uBuyOqihaJXJGMKNC4T7j7wAwWeq3KsdXPnLuw
        phnqRoRf0umBr1nfFUkqfFeuGwLyPVylhF1MDjob4rz7X4hU+HKIFRO1jO7kUGD0mHV0JO
        4g0g9WKhRDWrz2ZAx/G73JzZpapevDEOo/euTOPNOyAtbNR/Wm3flmNgmBbCJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626154873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sRNn/WOr7SYMuB0AJwZaTur5eVpfHXOr0MqTJe3rxDY=;
        b=fjNmqVRdcavNrYOYTCkmnIb/bT9WBtla9hfjcGe7MefTMcyOlV/GKpOoLFfaOYoM7EB3bO
        swh+TjSerDbbBPAA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Matthias Klein <matthias.klein@optimeas.de>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Working sample 5.10 kernel configuration for an IMX6 board?
Message-ID: <YO0neOgin5C3Xyh4@lx-t490>
References: <AM0PR10MB3107F4D6E0F50ECB027C06A199199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
 <YOcY3rH7Q0DjyOyj@lx-t490>
 <AM0PR10MB31078807FE14B686B727CA2A99199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
 <YOgikyyE7WhOP799@lx-t490>
 <AM0PR10MB3107D311CEBC0AD92D7CAA6099159@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR10MB3107D311CEBC0AD92D7CAA6099159@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jul 12, 2021, Matthias Klein wrote:
>
> Thank you very much for the valuable suggestions!
>
> The maximum latency is now in the range of 120 microseconds with
> version 5.10.47-rt45.
>

Perfect, just as projected :)

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
