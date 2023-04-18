Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92259C77B71
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Apr 2023 03:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDRDX2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Apr 2023 23:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRDX1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Apr 2023 23:23:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A51996
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Apr 2023 20:23:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so663863a12.2
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Apr 2023 20:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmn-com-au.20221208.gappssmtp.com; s=20221208; t=1681788204; x=1684380204;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/O0ywaHNM2L+fze9eJoQ+O4a4k7b1EgMxTM8ShjvNyY=;
        b=3yKQTJVZIZzrT9z2t/OzQ3/kB902rV0r5KnF5f3etVTtiHEZ6Z6liwHKx5rbCJKoU2
         RnW1vkS5MTpD7hlP36H7jdwQGz74eK/zLDaYzVJPxgYguGuRFNBbDh8Z8idtTUMY5lxS
         tjC6gJYe07MCcS+2F3AYS5h/whzyxcErqtH7cZngVS3PDiTJJkwJempvdrSowPO/RrNt
         ng83TPsoL71Wa3VEZq/AckzIHKsfqEgARbIqi9u+6VfD1L116Tk3bcBxHcKX432R0tXr
         N88wlXB1x2064K4XdVKZ7+76YPEbUmEBkDwHlIMRbEJ2pU5l6M2L0f4WlIS8NokEuzVF
         OoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681788204; x=1684380204;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/O0ywaHNM2L+fze9eJoQ+O4a4k7b1EgMxTM8ShjvNyY=;
        b=hiZNA59bTVEDMOxxFjIA1ym/18Yxdkx+1UOCfW9v2sHvJQYbuzJcMxpQ2j8QCpxMvE
         Bl2gOFpb9us/5QCCVfHIEHDyaPdh75azX5kuVheMIpARw1b4rDB0SXDyqbuE5316TMmr
         vWHt4vM8/l5CKRI9WizdlJKFoDmvVjvk75S9goDZ4926PlRmq82ymsnrvURsO0nhKLJ4
         KT+5DHpjaIdEL2MpkRclYiw/l/CJFQPZyY+9XA6xX30lT7bSbr94k8bjScTrk1BCB3qO
         oB2OEqP9ifQqc5H2rVqlm5PAXZ7b6K1aHz4+nEvvwXOGJGnD8iHWqrJ2d4isBNyQJ/HL
         aIHg==
X-Gm-Message-State: AAQBX9cZ//YVLVOVNkJHdnLu6XIOr6OT06gNxXG0qAxtkrmYGWquuzIN
        u+Sj0F9v48SkkZz7AIUtvQalUgvkAUIVKxPlkOe7S7rf8iSyldLG7Ts=
X-Google-Smtp-Source: AKy350aejZo9bVuPbqnoN6kcFwFISH69nTub5h8M1F9dNftvmoEMeELck9DOFWNTfwgiK+MhHKTz5mIFhzd6mzCMqSU=
X-Received: by 2002:aa7:d844:0:b0:506:8d8f:4715 with SMTP id
 f4-20020aa7d844000000b005068d8f4715mr839304eds.7.1681788203549; Mon, 17 Apr
 2023 20:23:23 -0700 (PDT)
MIME-Version: 1.0
From:   Rod Webster <rod@vmn.com.au>
Date:   Tue, 18 Apr 2023 13:23:12 +1000
Message-ID: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
Subject: Excessive network latency when using Realtek R8168/R8111 et al NIC
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi guys,
I hope this is the right place to report an issue

We are linuxcnc users and as such we are long term users of PREEMPT_RT
on x86 (and some other platforms)

A number of PC's in use by our members have recently been experiencing
excessive Real Time network latency since the 5.10 kernel and above.

We are excited to see this seems to have been mostly resolved with the
6.3 kernel compiled from patched kernel.org source.

But we are also experiencing excessive Real time network latency on
some NIC hardware, mostly with  Realtek NIC's in this list.

https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software
Many modern industrial PC's are using Realtek NIC drivers that cannot
be changed out so this is a problem for us.

It's our understanding that the R8169 kernel driver module should
provide support for this hardware. It does indeed do this but real
time network latency is unacceptable. Debian offers  a R8168-dkms
driver.  I understand it is being deprecated in favor of the R8169
kernel module driver.

Installing the R8168-dkms driver on the 6.3 kernel improves RT network
latency/jitter by 400% over the R8169 driver.

We are users not kernel developers. How can we escalate this issue so
acceptable RT performance is restored?

end
-Regards
-Rod Webster
