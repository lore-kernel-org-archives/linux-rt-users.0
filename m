Return-Path: <SRS0=fj9P=R3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073FEC43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Mar 2019 04:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57DD2171F
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Mar 2019 04:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl7RJeXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfCXEMp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:12:45 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34072 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCXEMo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 24 Mar 2019 00:12:44 -0400
Received: by mail-oi1-f169.google.com with SMTP id v10so221391oib.1
        for <linux-rt-users@vger.kernel.org>; Sat, 23 Mar 2019 21:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VE0RonCdfZe4NMGx/h5Df3aysCUDd0n7oXPAg0p4M40=;
        b=Rl7RJeXkXtiNtOz7dIgFnBr0Zh0Fa9LqlJb/3ZD03FE6D3R4jL6xAHKTNNAJb9kGnQ
         qPLamSviGJKwh8zW01RakgWamcL0FjFagIV8xifSr61LKWJNFsgxSBn7yKmM76JBWluw
         DluhvWWnSU7Ihfz4e87aNurdla1yVAkW0Unux90G+lOX0Ta3tt/FdwGGy7+STGz8u6Jk
         eTN5a5BrvQhKWCT1C4oQVC2ve1lAHNS4ITN39KJZEnErSFMY8dNA9TpCPrcjCLpnBE0e
         dGjmLzggjRsOzwDD6WLvw53QFh/MYKlVCCfVIIgLRIjOUrg3yLFlAW59u0wXR5QOXjL7
         3OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VE0RonCdfZe4NMGx/h5Df3aysCUDd0n7oXPAg0p4M40=;
        b=fYoXDMK6xiZ+erPJXTNUhRmwgKUVLj1hTX36D1jbxzm3AhWEr8xJr8x59eerccnhiG
         lVYabrWjVPZhEadrlNIvzQBmXbh5hJ5PP2ZZNkGxd7r5+izPEYv4z1iGmZj5/roBOjSX
         anlGMxKueMHmaQOIBnmjq4VKAsQNkOnLxqTNWdIYwUwZ50ke7zzYgMoPEHM5vvSzHV8r
         UT3QIazmg0z1QqRiNcld+hTnEhNx0by5NuXDM0psvL9AvkW0RgxUq8XKDkHjX1g5RZbs
         x+EaQ/MULhn5n19DpFKw0qssqzWuHEFj3rcAXyKq1nRet+DRYZnZ/go7lSpQkZWzObwV
         +0oQ==
X-Gm-Message-State: APjAAAWUbQnZaGpc37UomXOJXaeB8w6sRyaCvRQk7WWoVjm1fRQGANo+
        wklpT/dR4pbBLZfCsHXQTf2MFduJDP88JMP9f5P9gA==
X-Google-Smtp-Source: APXvYqwFg3WzMXNTyhQTTnJ67Bl+yW60iqGRFG0sGCfynEkBIW0QnDxRsJen2rdmRaqk3/LoVmLrSA6aANw9byXfnXE=
X-Received: by 2002:aca:fcd7:: with SMTP id a206mr7229058oii.21.1553400763881;
 Sat, 23 Mar 2019 21:12:43 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Ng <andreas2025@gmail.com>
Date:   Sun, 24 Mar 2019 04:12:33 +0000
Message-ID: <CAAVaN8yNc+sG7UP0J5SLDwVB=YMBUhC=sJZ3Gx72bkfWS5DQYQ@mail.gmail.com>
Subject: Latency issue to kick off a working queue
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello there.

I am using 4.9.11 with rt9 on ARM imx6  soc. I am writing a device
driver and I noticed that my first run of my driver gives big latency
- in the region on 10msec. When I get a gpio interrupt, I schedule
some work and the user waiting on a read() takes reply in about
10,30msec, on the second run it gets latency down to 140usec. I
changed the tick from 100Hz to 300Hz and 500Hz, I noticed that my
starting latency was dropped to 3400usec and 2320usec respectively.
Which indicate  some delays to kickoff for first time the scheduled
work related to the granularity of the timer tick.
Any ideas of what may be wrong?

Thanks
Andy
