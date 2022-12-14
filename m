Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842BEC4332F
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Dec 2022 14:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbiLNOHY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Dec 2022 09:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLNOHW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Dec 2022 09:07:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D926AD7
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Dec 2022 06:07:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d7so3410070pll.9
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Dec 2022 06:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/IO3s37IroUFnu5LKQJnYhFF7q22Tjolh/EqkJIk0Q=;
        b=oO+ImTCNjud+JLEu0pm7oMquolM8F6+PNCt2gqfZOeV63PVPuqRLavxPKAAG8xmYg2
         KPrGV99/I4570iMWxKbNl69IKTdEiX+CtmeOoQ+xI5qKGA24P+e3mHlXYJGoj1DmYXMS
         mntuopzletU5owB+0AlQGHLxHbexgLCiAoLRdgaUvjx8H5sFug0W4E4TrcPMrpdjbySH
         +pXB8/y1lQAaxD3nhmklQz4kBYsF8CEOc6veK/voXigXPXFg686zUoV/X2YxncHcRG53
         DztzWnK0h6QdxP61CzJjTtS9qfuNBkosQTVFrJ+wACgXJZjuno7QYNLR3aXBt7rAWioM
         2Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/IO3s37IroUFnu5LKQJnYhFF7q22Tjolh/EqkJIk0Q=;
        b=Z2o26VLu06Eg7Zcf+yHoawjQm7zRBDJSM/E8N6nmII3ZPWDPW5xZI2UW0gfwTLKOFE
         Vh+tbqX7TkFFurQQwv/o4FV7RrBbArK7j2WW/klqVlwXC5h/g1QqfY4qwvNn6nfWi4p0
         rw+Ct6PPI+IdDHUZJ32KDO+95FJLLtx9cjrdKZQDCaU86Im86KXy5f7K6hzuq5G1bL9R
         M1ZaOmhc3VfstmSSvOxVrP6Ao1fbwzUxpnbTkS8IGc8zKyOpcwgiA847BmT2ab/mXXMF
         fHuVjmb2/ATDfiNV1RIXitdMTt76OI2iY5y6fG18by92UMHPAtc4iI/XNSlNPZLNMCyU
         S5DQ==
X-Gm-Message-State: ANoB5pmwsbyE6iRrGTsBCHYtL7myD4HpKme6fHeb3ygn3OQXnlluMbmI
        RDwhTfP4tvNzQ2pCGeavx6ZqShvuvn3pQyxWBbiTi3TOKpU=
X-Google-Smtp-Source: AA0mqf4tO3QMzTKfsqwxYorrzEvDIgB+zJEWAY3PYvkBJ3kLxPJSzt5TKv0odeF9U4eILnVy4Vsv3tSjxNRyDjW2KCU=
X-Received: by 2002:a17:902:6b89:b0:188:bb79:4892 with SMTP id
 p9-20020a1709026b8900b00188bb794892mr79867681plk.60.1671026841276; Wed, 14
 Dec 2022 06:07:21 -0800 (PST)
MIME-Version: 1.0
From:   Brian Wrenn <dcbrianw@gmail.com>
Date:   Wed, 14 Dec 2022 09:07:10 -0500
Message-ID: <CAEYdEeS4T33R48EQ6016rdSmVNN4ii5YBN3DKL_RRCDznGpJGA@mail.gmail.com>
Subject: Version Magic Mismatch for Kernel Module
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi, I've patched the Linux Kernel v5.15.7 with rt23 and used
menuconfig to select the fully preemptable kernel.  The boot process
for two modules reports an unexpected version magic.  It reads the
following:

<module name>: version magic '<kernel version> SMP preempt mode_unload
<arch>' should be '<kernel version> SMP preemp_rt mod_unload <arch>

This only happens for two modules, and I've built all the modules
under the same source tree with the same make command.  This warning
makes sense since I have indeed built and imaged my SOM with the
preempt kernel.  The command 'uname -v' returns, "SMP PREEMPT_RT
<date>".

Even though I've never built this source tree without the PREEMPT_RT
patch, I've done a clean build to remove any doubt about obsolete
object files.  Can offer a hint as to what I need to change to get
those modules to build with the correct version magic?

Thank you for any help,
Brian
