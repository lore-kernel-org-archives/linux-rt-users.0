Return-Path: <SRS0=psFn=7X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBBC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Jun 2020 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECB82078C
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Jun 2020 14:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDlXI6Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgFJOhg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJOhf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Jun 2020 10:37:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D6C03E96B;
        Wed, 10 Jun 2020 07:37:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w7so1571519edt.1;
        Wed, 10 Jun 2020 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUf3QskTFwB9PuhQ8mdnsuuTXT9kmTqcpgC1QSf0Lcs=;
        b=LDlXI6PngjEpCkUin3G8CZ5MuhaUL1XiUQW9Mv5DlIIQLxAflev2N8NgSLBTyX6XJc
         sKhq9N8Ivi69Rv09E1fQXMv5aJa+GhNzoaEfm8gt9A0qqEkZdVKsQSFj4RieObwbEYQr
         OWurn6PVJVSRDyJiW2Nr04x4ibg0LmaSgDxAGELFoByNT73eudiTV5GCILDv032XZ/za
         Ex1gOCV5EFIJbKxeGM1QkSNh2hTaawepCCS72l9dWoBZG1n+bc7UjVar3ikOh/5pxnyX
         uX0erLBYsGNNwgAOCJm0aAAgv4Cn/zZfQ2aXfLEVU9wLofHUmYdBTYufdMqWCw1gX1oT
         +uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUf3QskTFwB9PuhQ8mdnsuuTXT9kmTqcpgC1QSf0Lcs=;
        b=FbJaxm+mEbu3Jis0qnMIyDDiOvfGOyXzFEz+5doCyp9oDfMuzgQnM8QgN54kzBFtJZ
         IkF1sTNwDuSNmnaDpgufbkK7ZmIJRTfnM1KI/MJ8Nmsv9ZevSuUdOILAMzGHCMbIA560
         AXryqGFfEAQXOFqlEzEaCO9jJJ0FzvGTx+dsWitBOeIHNuQdWlAWnmY9xAnQ/mUyQei4
         zh0mZngEWdBHhZooASq+rTKWWeDdT72WTPJJGti1hbXfeezuVfrwejJeZFB9n5AFHe60
         m/dbVlqWuUvKCzD2A/sRztlNdwjIGABEZTpKEu+BCpsHMaM/XUwKPuy6PytCOZ3fUXJx
         C91g==
X-Gm-Message-State: AOAM531ByMml8zcn56yCygtubX24l+JlLmt6NlRFL4vJeY086jOjb4Ts
        l1h8I46s5A6mKPG8pQcaMDxszXzke+5PuQQFSDWK2zqN
X-Google-Smtp-Source: ABdhPJxgM7QGFsG4CZmajEbZZJopQp/CazjGptpk6H1X/sqFz1RSNP1Z3SX96W2rwOI4N6OetPGDvFraweu4+jwA7/g=
X-Received: by 2002:aa7:dc50:: with SMTP id g16mr2847889edu.318.1591799853032;
 Wed, 10 Jun 2020 07:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com>
 <87wo4lekm5.fsf@kurt> <CA+h21hqbKasMAuHL+B-2Gb-YQ3QGF+_pWGCxr8LTcusjvuqFeg@mail.gmail.com>
 <CA+h21hp+UsW+Uc-xHyQAMrRVLX9CXZu8B2Svq+9npLtxs0_DWw@mail.gmail.com> <87y2ovzcmd.fsf@kurt>
In-Reply-To: <87y2ovzcmd.fsf@kurt>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Wed, 10 Jun 2020 17:37:22 +0300
Message-ID: <CA+h21hp8ANbZw63UAy5cDx389j6pSOHUG7t1mR+rbQcrFLROyw@mail.gmail.com>
Subject: Re: stress-ng --hrtimers hangs system
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Colin King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Kurt,

On Wed, 10 Jun 2020 at 08:58, Kurt Kanzenbach
<kurt.kanzenbach@linutronix.de> wrote:
>
> Hi Vladimir,
>
> On Tue Jun 09 2020, Vladimir Oltean wrote:
> > Just out of curiosity, what and how many CPU cores does your ARM64 box
> > have, and what frequency are you running them at?
> > Mine is a dual-core A72 machine running at 1500 MHz.
>
> That particular machine has a dual core Cortex A53 running at 1GHz.
>
> Thanks,
> Kurt

Ok, I just noticed that you said "v5.6*-rt*".
So I re-tested that 5.4 downstream kernel again that hanged before,
just applied the -rt1 patchset on top. And it's actually working fine
now, no hangs, no RCU stalls, no need to reduce sched_rt_runtime_us.
So maybe it's something related to the config?

Thanks,
-Vladimir
