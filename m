Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAA6C4167B
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 11:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DD72310B
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 11:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgLGL2U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgLGL2T (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Dec 2020 06:28:19 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D2CC0613D0
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Dec 2020 03:27:39 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id p5so8088407ilm.12
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Dec 2020 03:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cgjl04Fn23qcFGVo64WMVHqmQCXk028jqfCNf6NHlm0=;
        b=as3TDbuE8z9/XXxR9SwSfYV/dOdReV7PiTvs9ksR5vaNpCqh7o7DVj9yTuH37AmD3m
         0ce7o8zmRX436rb5G7Ppv/3NaiwJYRfLatHh4DZbRcnh24u4UhqvWj1K2d3T5TpXTUIL
         lpKZtSItE/J3xR96JMGib2bosXtvOn854E8fdra275ct+fgFo0k8N4wx8VDYbHVn3pnc
         fUJelEwNtGksYNqYsDygPFd7yEN6UcS3tnthCmQKuublkaKvQGv8Twt5voGUVcSE1iLt
         wmb/qXeKWHEv+qwzqY7ySGmcljs2HteVFkCXqKFE9A/0so3QEtM8qQHNz5kz9oM3CGzG
         oEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cgjl04Fn23qcFGVo64WMVHqmQCXk028jqfCNf6NHlm0=;
        b=FDKYvt+boQUlaLBJNaWLClxZY/4sj5c0TRVi9VHZ8gg9hQ1qPUvJHDqONM+ppEnUW3
         8djgJswuSIjQh7SiqTkyumR3Tf/Yhl09BmUfgzX+GpWDM04ql9OW9IQhRyaKZgGjzNLN
         ZFYqIDWBtoVR/DNEv0t2ly6v8zEQlpwyaSf7qmYOnfdiWYXQ8uB1ZKBnwN3B57VbvGKs
         EP8D7682TIZN0Ek23qjHIAimbrPSihqg9uvjQhHQlawibGfOAkaEU/YEP+vagimskTjp
         L6VZNnkA//frijWONlFaYtaJIwe/QP7trNjNQB2NnvI3TeDN6/Hx1RHA/NyctRE2GgeZ
         SZkg==
X-Gm-Message-State: AOAM5320MCQonHJsKH9AfgGClw5ePmGGoZm70h8l3bHOQNqutdf+pkd0
        ydew3sPXKSyrl9+5OtR/70WeftzzNg58fMs4WZYDMTp88E2ZDw==
X-Google-Smtp-Source: ABdhPJxJgkbe3dJXnB81W45MmOVRsYVA2PiBi6sFx1KXrMAzAjD9bPxek860k7O7J2TdArkHO5YWGdudEl7IdcOmXgY=
X-Received: by 2002:a92:d8cc:: with SMTP id l12mr19587094ilo.64.1607340458226;
 Mon, 07 Dec 2020 03:27:38 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 7 Dec 2020 12:27:27 +0100
Message-ID: <CAKXUXMxJ3vruzABBPGcgbXMoNEa9S7VLXPjWJAPisg+=M4gu0A@mail.gmail.com>
Subject: Another short update to real-time linux blog
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear all,

I finally caught up reading on LWN.net all the work (at least all
those topics that Jonathan reports on) [that as far as I understand]
is related to the ongoing real-time endgame activities; or at least,
motivated to clean something up to make yet another real-time piece
fit nicely.

I summarized what I understood and posted links to those articles and
John Ogness's presentation in a short blog post "The real-time endgame
is moving quickly now", on the real-time wiki:

https://wiki.linuxfoundation.org/realtime/rtl/blog#the_real-time_endgame_is_moving_quickly_now

I hope I understood that this all related to the real-time endgame
correctly; if not, please let me know.

Thanks,

Lukas
