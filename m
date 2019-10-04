Return-Path: <SRS0=K3q3=X5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD3C4360C
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB21222C0
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 17:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSfJK+az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfJDREW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:04:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45047 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDREW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Oct 2019 13:04:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id q12so27271lfc.11;
        Fri, 04 Oct 2019 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sKmO7SSGs5Cj3Low4MPSsnNOVRF1CxTmZDKDuQzI3fM=;
        b=lSfJK+azzJRqFzTecF/yotk8HmWx/8su3AWMiN03qdPOl9to1345PPk0ASWd8IKFOD
         oPYoKgkESWbvzNMbHJzcxLGZ1Sgpi1psKEOPpjPQcW9qcOzh17P+UB84I53/b92Y2d7E
         VvonxTSEJ9yP8KkInJkGHpaaraEs5MIsqQXD/h08VFVokD5cKwqYlf0VFrKCpFlcjXqz
         g1x8noZF0SAqqHzHMaoG6c5iXUoafIe6nkoB1n/4EqMSz4aK1+3wSpehSWupPp7Iyzc5
         iXdaKjoAhXpdjhuwq8HTvVCoXnRVEgqBqHcuRPxCMI91SYM5apZIAqOP3e3TEnU2FSu5
         brlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sKmO7SSGs5Cj3Low4MPSsnNOVRF1CxTmZDKDuQzI3fM=;
        b=ONhYb325ZIJK8SuBEadmKXzuVNONC9RyUHq9Vx0sR0FXJSjgHRyq0Khay2hBIfTiwJ
         nOrngUejK0PRyKyKgjUpxbQw7yxC4lazODrrlGoK0dpZo9Gojqr3whEg74CY1uykLjpL
         qm9pBCX915/Z/4axp0kL1mTM8hPK6Yd0EuNpuVaD1QSCD2TB7OjnV6RhLf58kFGnm2Dh
         nASDnQ+7U6jwWqUzMrpcN/PklPEAdgSccCmfG4sDSTCigxGT+nQdFqMU87w9Dm+16Sy9
         V71Lagtu1wXbs4/faI72HGEGmO21347QpU70KizTZptdKZv3YujUeicq7K5/zed8yPTw
         j2SA==
X-Gm-Message-State: APjAAAU6Ow+fwKis7mLWkVrjdtRRm6nhyjbfwRJk/DYR1OnAu7J7QTj5
        56VL0Ia8UShKJ7urWKe/nAXUJf5p9Jk=
X-Google-Smtp-Source: APXvYqx7EtofMP0XWGkulzAk/7zhZa0zIkQhvEck8McSJ/pwIH5lI0GleoBMmt4sJQ2AsuBZiW3wtA==
X-Received: by 2002:ac2:5504:: with SMTP id j4mr1448951lfk.186.1570208660337;
        Fri, 04 Oct 2019 10:04:20 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id v22sm1373111ljh.56.2019.10.04.10.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:04:19 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 4 Oct 2019 19:04:11 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Daniel Wagner <dwagner@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191004170411.GA31114@pc636>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

>
> You could have been migrated to another CPU while
> memory has been allocated.
> 
That is true that we can migrate since we allow preemption
when allocate. But it does not really matter on which CPU an
allocation occurs and whether we migrate or not.

If we land on another CPU or still stay on the same, we will
check anyway one more time if it(another/same CPU) is preloaded
or not:

<snip>
    preempt_disable();
    if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)
<snip>

if another, we can free the object allocated on previous step if
it already has it. If another CPU does not have it, save it in 
ne_fit_preload_node for another current CPU to reuse later. Further
we can not migrate because of:

<snip>
    spin_lock(&vmap_area_lock);
    preempt_enable();
<snip>

--
Vlad Rezki
