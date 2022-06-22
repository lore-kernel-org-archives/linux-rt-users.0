Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DEBC43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jun 2022 15:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358174AbiFVP0Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358064AbiFVP0Y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Jun 2022 11:26:24 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E97039162
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jun 2022 08:26:23 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id j39so17531622vsv.11
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jun 2022 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=0aDQ/+hY9AXqBOPxBQG1WenQLjc7IjTfIqDdS02HvQw=;
        b=G9jsLGhMTIkG7gHWT8j2thu7lc9u6uTMbc57UuVCyBmWCloRjxIWbPgFR6Vp/Z6Enl
         /koe4NreMHIgIYtu1vW7E3e1MyodxicwXgY0KOiVFZGDW2ECJlpGllHsGeyeExKbz4QR
         XSYEX32IkMd5mox2k8ZDE47+36nHo+fCo1nZAdmbVBBTjL5UyitiN6VHCEi3VRomucbr
         p2gyz8vlMpMzWOeHErqz4q4XuVPJ9n6v475jR8js/gb65B3MVOIAJA5OssMrz3/cmXaA
         sCV5Xfs1XjJymOqYPJZC0/Xx1LuLgJG+Ejt8A9VmZPnMPO5Sz/ZYLfvv6T3LfIwLuNsV
         mvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0aDQ/+hY9AXqBOPxBQG1WenQLjc7IjTfIqDdS02HvQw=;
        b=xDeJcNPXSANhQ0jiepwCDzM4t5dxmV7mZ2e0YrnqfYS2dXkzooptiR56Qr5iXaR0gU
         d0GFEHvr0qVTWzWSMMSEIiArI/q4sTbMLKnDUoPrdM5oJIDH2SteN4PVkTQFzr5asK4l
         rfQbCEfYZ7qhjDb3rvHMjL29a8FInJVZb8FJBcNjmZQ7z58/+hHqD3y0Q+ZAGfP5JXeU
         V8k0pQ6AavmRVB2nYOQXwGFT3utLbdCxxekwWFLfLMiCqPMMHqoDkeGkWsZmQJYNW8nD
         hAXlQqG3MdrySr21f12TePlePpi+dk4Dh79Kc2Y4hki65uzFSdlF6GthPA8ialiv+88e
         dc2g==
X-Gm-Message-State: AJIora9sLSF4CodBs0hvVNj06jzEDuA99zROl2pkMBpnBD2FuQIUTJFU
        SXM3FSV4MblGmi8jxSc7VvTjj6duFcUKeLxIotQeKY/GtcM=
X-Google-Smtp-Source: AGRyM1umfZ784cERL7/9FeCvIjXY1NM3LcenNgbc0FpJWoyPYoua0wsq7Ik9ZP1ROawgffaNbZwE1DRJCkOF3ZE4tUI=
X-Received: by 2002:a05:6102:15a4:b0:354:6370:333b with SMTP id
 g36-20020a05610215a400b003546370333bmr1543106vsv.29.1655911582346; Wed, 22
 Jun 2022 08:26:22 -0700 (PDT)
MIME-Version: 1.0
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Wed, 22 Jun 2022 11:26:11 -0400
Message-ID: <CA+1+E3XngtGKoc72x5okmFmv0nt3omU=RUFXbH0C0X3yKMfH+A@mail.gmail.com>
Subject: cyclictest count value seems incorrect...
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I ran the following 3 hour test using cyclictest. The count for T:0
that I saw when I returned to my screen in the morning seemed
puzzling. Because I use the '-M' option it display updates when there
is a new maximum on any CPU. Does the output as shown mean on CPU 0
the maximum value of 26 happened on count 168704 and as it never
increased after that the C: xxx is simply not updated?

I wish even with -M option at end of the display would do a final
update. Because of -M the only things that will update on the last
screen update would be count values, but this would be useful.


node-0> date; sudo ./cyclictest  -d  0 -p 90  -S -D 3h  -m -M; date
Tue Jun 21 21:37:22 MDT 2022
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.00 0.03 0.04 2/166 5380
policy: fifo: loadavg: 0.16 0.03 0.01 2/170 5702
T: 0 ( 5368) P:90 I:1000 C: 168704 Min:      3 Act:    5 Avg:    5 Max:      26
T: 0 ( 5368) P:90 I:1000 C:9742264 Min:      3 Act:    6 Avg:    5 Max:      61
T: 1 ( 5369) P:90 I:1000 C:9742261 Min:      3 Act:  132 Avg:    5 Max:     132
T: 2 ( 5370) P:90 I:1000 C:9742257 Min:      3 Act:   13 Avg:    5 Max:      67
T: 3 ( 5371) P:90 I:1000 C:9742254 Min:      3 Act:    6 Avg:    5 Max:      91
T: 4 ( 5372) P:90 I:1000 C:9742245 Min:      3 Act:    6 Avg:    5 Max:      59
T: 5 ( 5373) P:90 I:1000 C:9742247 Min:      3 Act:   10 Avg:    5 Max:      41
T: 6 ( 5374) P:90 I:1000 C:9742244 Min:      3 Act:    7 Avg:    5 Max:      67
T: 7 ( 5375) P:90 I:1000 C:9742241 Min:      3 Act:    7 Avg:    5 Max:      29
Wed Jun 22 00:37:22 MDT 2022
