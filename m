Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E121EC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jun 2022 02:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiF0CCN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 26 Jun 2022 22:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF0CCM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 26 Jun 2022 22:02:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F8EB5
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Jun 2022 19:02:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q6so15953016eji.13
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Jun 2022 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlgvqWdmgYv+0M+HzifUY5eF9Vr9scrku5BQMEXrWBE=;
        b=EECf1XlILSxHh6AHfqmyQR1Ng1IH2RJA+jug04VcFSZwopEtbjgzkrGO0O3ozP++4x
         06jb4Rorp4jIo8TtyK0RxU+Kec3or/Z5HIRoK9XNQ9pPNgwoww+bf31yKVFXNAuTFsTW
         MmXcB/ooLoQLMUKTJ8IFI0zn3q2H4meAzdC8pgGsnuP5946351bwxXvzq7yExVzK6zzX
         0YbTTeLbr6Citt0CwfsIj514+PFq7+cSqptndO56gi6gGNUVTV8K/ww71ROsW312ZJBk
         493xlXPWcrTIAWMgwR1W7Oqq/OHA8TTXLzDOX/jqI1cCzbbI8MbAscfnyG3hMRCqxLbo
         KGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlgvqWdmgYv+0M+HzifUY5eF9Vr9scrku5BQMEXrWBE=;
        b=5IskLsnTYfo0I0ztztpdXZSUv1uwxuatdPvCjfq1nJgdR+ghpTDIXCblHKNnRIHBK1
         OOmfTPzK1ypxyaQ7KTvjGyLr891Q7oQ13hE3GIBxTM9iGW3oZTFMGa8cAYlzCwHSVYtw
         kit4k6kQyAtn819i8XbgrqPTtq2oGbg1J/wyAccKp5niwwkF17xUMgxM+WXirFmXhWZ9
         +uf+yJDRX6+x0Ec68tltfQqalCYR8IiYl1rkuX3bdtdRlj4aNTKpv/9wu+Txbs4P+dyW
         KqMaIyPj1P0wbYjzUH2YskvgQ0PIKefRd8/rFR9KL1F41y+OdYbwIf/nFuv3K9ICRLy2
         d7BA==
X-Gm-Message-State: AJIora8uifT3HIueFpn+C6e8KrQvS6POJdVHnc2lR4QKC86bJeMeKSH8
        ulv6w6X9GHNAWhhcDynYJ2a17igkU46MySGofzs2GmDT
X-Google-Smtp-Source: AGRyM1tbOiE3fBt8pl9cipffTsvaTVtVGtvXhyUtdkO3FQtVqrzfIl4Br9Ep8wOCuEVSmui1mkBt3w==
X-Received: by 2002:a17:907:2d08:b0:726:35bd:b3c1 with SMTP id gs8-20020a1709072d0800b0072635bdb3c1mr10313732ejc.281.1656295328484;
        Sun, 26 Jun 2022 19:02:08 -0700 (PDT)
Received: from t123yh-mbp.lan ([185.217.109.52])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709067c8300b00722fc0779e3sm4424271ejo.85.2022.06.26.19.02.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jun 2022 19:02:08 -0700 (PDT)
From:   andreadaoud6@gmail.com
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
Date:   Mon, 27 Jun 2022 10:02:04 +0800
Message-Id: <20220627020204.29132-1-andreadaoud6@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <87h7a66uow.mognet@arm.com>
References: <87h7a66uow.mognet@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

I'm encountering this problem today with linux 5.15.5 rt22 kernel.
This bug leads to an unstable system. Having read all your discussions, I know
there is a workaround, but it doesn't seem that everybody agrees this.
I'd like to know if this problem is solved in later rt patch series.
If yes, could someone be more specific which patch solves it?
If not, is applying the above mentioned workaround patch the best solution?

Regards,
Andrea
