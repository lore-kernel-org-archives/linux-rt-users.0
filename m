Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC0C61DA3
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Mar 2023 22:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjCCWpO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Mar 2023 17:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCCWpK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Mar 2023 17:45:10 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AE8BB99
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Mar 2023 14:44:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ay14so12521252edb.11
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Mar 2023 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677883402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k/8YZDa/xNj9vIwpykxaywnQ+ZKYSa6yE7wfu06WSR0=;
        b=nNi27jG/CVYWapPkmTXVYDatJGGuWJTmag+92DGnvm/Xkfrqtdj9+zgmSxxNxZpX8t
         am+gkLdjKgrW/fvWpT0Tx1bHV9XOJc3CAvgV+ILEBK7gdlosnybPz6ejPBzMJpwXEsa6
         Ac/Oa1Mz5bNZbstrqvb1fZGwNQ9fV4/HYqDjaQzQlu11ItmCFroUJEpHuDnsBl6qPvzz
         Db6yzZ0lgeLujK7Ede9b6GPzSRwtK/yNJmuIDV1zQziBKcY6ER0XlBwTXBPnnwuIO7pR
         diYPPO2PeQrtlu8Uhdk23/IOisrchwp3x53ez6ZzZpwekd7Tsi+OhWoAG5ci+aFEZfnV
         yEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677883402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/8YZDa/xNj9vIwpykxaywnQ+ZKYSa6yE7wfu06WSR0=;
        b=zx6yP44X2Gb+dEX/ybe8MFPsG7ZpTxkUbLvJ7RKy5YCtA1UXBKnfyF+SsNjuoJiXSf
         WWIspr4P+X/7DTCrnaz5KFi72atv6kviuPlIhPO7qKrAJcLsLw4XUVK8msrft5Z1cIp8
         ut0jyhTXqVLrO/8APepew8bAne7H0TKPlnAjrVmuuKcYZpnUGHj7nPBn5rIb+PoIM0bq
         QxnUuKL3UuZfCK4ACGNeew/fOeYOUpuL5bBj/23cpO6GgVSfHhcY1ePjnYPGZPtkEGN6
         HMwupFDGpK1vfI9qW6N8PgVUoHdVjYMsZiZiqmv6pR+Owbre1hSFldiDjJ5K47W/h7am
         KaCQ==
X-Gm-Message-State: AO0yUKVJHl7I1voLvMtORjvxJVfql5+vgUAzDZ6moFXplR9/3DwDyrHF
        6HSDs67bkdCyIzBwH3/uD1YIHTJC6aEr9RvBe35z7tAkh3g=
X-Google-Smtp-Source: AK7set+ZtWF+LfLezwDIhBzzSDkK12lYIuAXAtF4/utAhwAsy+79zJxdcPoUeSwjBiopxsGr6g1Pm11YpkLhnKtWiMI=
X-Received: by 2002:a50:9f26:0:b0:4c0:1cfa:bfe1 with SMTP id
 b35-20020a509f26000000b004c01cfabfe1mr1935817edf.6.1677881085717; Fri, 03 Mar
 2023 14:04:45 -0800 (PST)
MIME-Version: 1.0
References: <CAAajkiYTEvxpV_Vg6rj6es=rJEidNEpEgWciY2TNqRqzVmb1MQ@mail.gmail.com>
 <ZAJh7aqeAY3NjR5x@uudg.org>
In-Reply-To: <ZAJh7aqeAY3NjR5x@uudg.org>
From:   Aaron Simmons <paleozogt@gmail.com>
Date:   Fri, 3 Mar 2023 15:04:36 -0700
Message-ID: <CAAajkib1U8RWFRWFb9LiGqXxtGr2JOU6_FOV5gm40xE0sSNPZA@mail.gmail.com>
Subject: Re: preempt-rt + live patching + arm64
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> If the new bit youa re adding is used in _TIF_WORK_MASK amke sure it is
> contiguous with the other bits in the mask. For reference:
>
>     https://lore.kernel.org/all/Y8lCspFtQ0wg6uCy@uudg.org/
>

Ah, this is good info.  Fortunately, TIF_PATCH_PENDING isn't used in
_TIF_WORK_MASK.  Since TIF_NEED_RESCHED_LAZY *is* used in
_TIF_WORK_MASK, I'm going to resolve the conflict like this:
    #define TIF_NOTIFY_SIGNAL      6       /* signal notifications exist */
    -#define TIF_PATCH_PENDING      7       /* pending live patching update */
    +#define TIF_NEED_RESCHED_LAZY  7
    #define TIF_SYSCALL_TRACE      8       /* syscall trace active */
    #define TIF_SYSCALL_AUDIT      9       /* syscall auditing */
    #define TIF_SYSCALL_TRACEPOINT 10      /* syscall tracepoint for ftrace */
    #define TIF_SECCOMP            11      /* syscall secure computing */
    #define TIF_SYSCALL_EMU                12      /* syscall
emulation active */
    +#define TIF_PATCH_PENDING      13      /* pending live patching update */
    #define TIF_MEMDIE             18      /* is terminating due to
OOM killer */
