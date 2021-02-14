Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4A1C433DB
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Feb 2021 10:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE29064DCF
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Feb 2021 10:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhBNKzM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhBNKzL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 14 Feb 2021 05:55:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3ECC061574
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Feb 2021 02:54:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v9so482396edw.8
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Feb 2021 02:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Kn95G9AuSOwdZHAPSyMf3TGTT2qULheHnyNZZezePeE=;
        b=fi+rFHiQVWRu4jFPGRE2oE0fde0rxh9PszJxVY2Qe76vasWOXP3ysBatuGy3zhcNE/
         vtIXrJTMecj/JVAdD/wFsUj+j4O7z31h6Tnpwnk5lFU2bi5vBNs0pTaGQbU7U4zuNH+x
         eHretZ3fzq2J6JBV2Izl7BdGwkEqALiz0Gk9+sXF/DT76lX+BoLw53fgAXXZgQtqprKz
         f2xvU+mNjsTijQ2lMsJYgGDCmXdLWMXcW4fAj3rkb3ghPM5iqgk1PBjSg2T1eVoJI5Ub
         +MgKWEadGz+S9qMEe7qxJ+lMY69B1YYDygDh82sWgurm24d86mYwtXB9zm2KX+d1PeCl
         AKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Kn95G9AuSOwdZHAPSyMf3TGTT2qULheHnyNZZezePeE=;
        b=pvl/W0eKGooWsSludVUK6lpxWDnkIZoxS/tXS5CKI2ImPvAbtFBtEF0xlXmFtXIN7V
         NLfrqSjWTR6cwrfoxoE0BrGi/OgJHLpD1kRGCAKkV8dGHPalYbIrTo3Al0mt5cuC+JSs
         zuBxyXdApReJ5AbNbmlL/Es6104Aqp/QoSz0F+/uZVADDOSnIKR0KBs40OQQMri4pdJQ
         +vUG8HrwuWwFEk5HSQv/u5VXUulXThO4NkVNHC8dcc63Zpr3rPdrj3WUG+SIXSgwovsJ
         gtcJbb/+S2ZFF5lAhj2jS8KEiKbevgw4xVY7Yqnkh0Rir9AV9ZfDJY9dqmRrq5ljWsJf
         DLhg==
X-Gm-Message-State: AOAM532esOOeqK+tZ4z76rfuUWoNUQmTQPymW5XAG0lgtOX99wIPbwpo
        pvsoaTliHDxhFmcjR7o6TnA/+aajH+c0GA==
X-Google-Smtp-Source: ABdhPJy16THYDD5wICeGbequHwzNK+wZwJN6O5CnB3puSgRgaTJ/p5E+odPULs4XRZ10RwvqvlupFw==
X-Received: by 2002:a05:6402:1c0f:: with SMTP id ck15mr10655779edb.16.1613300068860;
        Sun, 14 Feb 2021 02:54:28 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c7f-b900-0e3a-d793-89f9-ec3f.c23.pool.telefonica.de. [2a01:c23:6c7f:b900:e3a:d793:89f9:ec3f])
        by smtp.gmail.com with ESMTPSA id k2sm8879763ejp.6.2021.02.14.02.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 02:54:28 -0800 (PST)
Subject: v5.10.14-rt28 fails to build without CONFIG_SMP
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <20210209180601.hbjpgfcntgsjirbk@linutronix.de>
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Message-ID: <ae545d99-66ec-ef32-604e-ee5caee8ece5@gmail.com>
Date:   Sun, 14 Feb 2021 11:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209180601.hbjpgfcntgsjirbk@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

It seems that commit 17cfc9697f5574e4b523c21fca160aac5a3ac6dc "softirq: 
Update the WIP"
breaks builds without CONFIG_SMP, due to unresolved references to 
tasklet_unlock and tasklet_unlock_wait in softirq.c

In include/linux/interrupt.h the functions are declared if either 
CONFIG_SMP or CONFIG_PREEMPT_RT are defined.

However, in softirq.c the functions are now only in an #ifdef CONFIG_SMP 
block.


Regards

Jonathan Schwender



