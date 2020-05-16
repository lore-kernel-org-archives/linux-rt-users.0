Return-Path: <SRS0=3PEr=66=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7EBC433DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 May 2020 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A5320671
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 May 2020 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+uDCpkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEPQfU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 16 May 2020 12:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgEPQfT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 16 May 2020 12:35:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54175C061A0C
        for <linux-rt-users@vger.kernel.org>; Sat, 16 May 2020 09:35:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z5so5017749ejb.3
        for <linux-rt-users@vger.kernel.org>; Sat, 16 May 2020 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tLMSMYYDuyVv+WaF+2QNTbGzAlaAIfSljTTrYEYFOMI=;
        b=S+uDCpkwA/d16DbvZc4MS2WeI6rkf7TrQxqqh3j5VIpp7bfIJk/qPdpw0GhWJVgP/R
         uJ75/vcsU66wMqImV6+vUfwhKAiIqyW8JMCvnO68uFjiK0xZhV8U0G0GHDtREwvjluWz
         tPbVzGHLSJn4/haijFZ+tblyqMYhO9ctqPa2YNzHDzhIUa4KxrGxxEd/CmkmCA3G6xyO
         FF0Jx10ErweJbNdGQ+vZsCzH9ZKpoNBlwKc3f2aHSy3iWknRKtJnjrJTmrDViId3MTJ5
         N5ddem9WEJIUSoLEVVbfrhhaEJHfX5fD5VHyiO+5dwyHNRH4L5/OmoIABxYulP/nopsW
         XV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tLMSMYYDuyVv+WaF+2QNTbGzAlaAIfSljTTrYEYFOMI=;
        b=OE4kZQqJjnpTz8fCKTGeZb+Lz7rKjH/0r/WsptBkj1GHfMpGQVm9UQtyH5zRKk43Jr
         rFKu191PymNrCYr4ijOlZT8nK8hkBEpf6oVNW0iw1LqnmnHZ2JJcJp/syGT01rSyE7Xl
         33sFt2FKL3jA+WykgL4cbDXEi3J0S+VzqS9gk2HlpOBtg+Eq/cihsYB5kmJg//iah/hZ
         ih9JGsmtdIFPedgzKD8g80eydNRPXymLRmqNUIcN3/ik1xXd1XQuzByqdbe7F1S7w+af
         IoslutwdI7BkeGp6EzTno5pRursQ746WC9Jl2MoauHrIpJPom7SCsrpKeRm3F5fE165V
         vJKQ==
X-Gm-Message-State: AOAM530B3Ug7W1GOmhc0e2UNNFN6irGv/4NzvPZnxWYlK6sYJby+25k3
        v1bz8QCbqyTQCerGmRm97x+tYIVa1LHEaBtcVWkjZoTcURZE+899Boc=
X-Google-Smtp-Source: ABdhPJylNw8kQkUkwfFC60gnu3Q2SmzacStVYGMZ5tnvVkefjfFjFjNYfjKrJ7vlSVyd9rUKfAw2dRg14V0z/c+z7s4=
X-Received: by 2002:a17:907:40f1:: with SMTP id no1mr8469631ejb.178.1589646917403;
 Sat, 16 May 2020 09:35:17 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5byg5oms?= <andyzheung@gmail.com>
Date:   Sun, 17 May 2020 00:35:07 +0800
Message-ID: <CAN-npu9MViEKYCNmTnGSAxngWhzevOH=T5rg+t+wVMShKagMCg@mail.gmail.com>
Subject: About RT patch can run kvm virtual machine?
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all:
      I'm trying to run RT system with kvm on ARM architecture,based
on the kernel of version 4.19.98. But I found that as soon as I start
a guest OS(within around 1min), the host get restarted(maybe crashed,
I'm not quite sure), no useful message found in/var/log/. So, I'm
wondering whether it supports running KVM with RT patch on ARM?(It
seems works well on x86)=EF=BC=8Cany suggestion?
     Thanks!
     BTW,   the patches  I'm applied are downloaded from:
     https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/
     https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.19/olde=
r/

yours
Andy
