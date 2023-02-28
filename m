Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04169C64EC7
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Feb 2023 23:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjB1XBe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1XBd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2023 18:01:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D037739
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Feb 2023 15:00:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c10so6164041pfv.13
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Feb 2023 15:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SFaMye/JWCScCwRqF8X9de4bUvOsGh8nKj83uk6VhQ=;
        b=Djh/Yuwra46PPpnLrvUZjK1md2FxaIrJba8DO1qn90yXkq3zoJC5XLE4CSeXdJtbn5
         xBTW5hraldp8IswrKYpSV4Sv/DbczoQob5lzBug+VicJepbhY/0yP2Sv7z5uhulcjAWp
         Q9RvMvqoJpu2CnUbV3ASFj5SrS7xsNbTOAGJsjjanqPv+WjXeC9oSebi6uiGqfW2xeHv
         0rGAV3Nqw+7rBssRS5arxV2UZSZDYA80yoAb3RUX9SMgIVu/aa18xyHSBf2e2OQCwvpT
         2LdbGVGqYzzQVDDr0lwJ9d+uPQfcjFoKdGwHwE7bs5pAxXgCfPfakNh/M6uioU6NVZo3
         b+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SFaMye/JWCScCwRqF8X9de4bUvOsGh8nKj83uk6VhQ=;
        b=2/Ab4GFPR8sVZ1ppFq0TnOqh9xP5fjwiZtZz9poqz6FAYYe3qKs1yf4ZY022gt9csu
         d6f73zULZo01vOXWJFpzbN2QrBfg1UP40V5pdZhInZ2UrTCthpKdmnyGProCGaRp66jG
         pJ8+MgwmPnNbIboIdmFG1KvmWnDmG0fIQwp9ltjnzkSSOqBMa+sKbx6WacKfNeJKC1pF
         ywcH7/ow848o5xviTc7EUR6rtDwbofU8GtR6pQAezbmNWLRpSUEREfFLklUN/El7tD72
         2gMoj0wQSbvmB6ifCckWefpta/gZjlCluUZW1nGPyo66r3c1wuQTGcYvP4SAnqY62kWE
         mmcA==
X-Gm-Message-State: AO0yUKX+027S7SFpwfeTldtLedsGFQg7XezkbVBnpeaLQlo9d1w45v5N
        W+0pJH5PymcGBt4oXGpSTP8=
X-Google-Smtp-Source: AK7set9Z23q7ykP8mSP9mcYDouWUXXfghixahsi3EAwVUujEj0iHEuxmJvRyXeQzqsoq+BmyDHaJyQ==
X-Received: by 2002:aa7:96d0:0:b0:5e5:682:deb7 with SMTP id h16-20020aa796d0000000b005e50682deb7mr3872007pfq.34.1677625235473;
        Tue, 28 Feb 2023 15:00:35 -0800 (PST)
Received: from blamoreauxMMD6M.vmware.com.com ([2601:600:8380:7f70:5855:8603:f7c2:a87f])
        by smtp.gmail.com with ESMTPSA id e16-20020aa78c50000000b005a817f72c21sm6578052pfd.131.2023.02.28.15.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:00:35 -0800 (PST)
From:   "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>
To:     bigeasy@linutronix.de
Cc:     frederic.martinsons@gmail.com, linux-rt-users@vger.kernel.org
Subject: Re: Kernel lock during cryptsetup luksClose
Date:   Tue, 28 Feb 2023 15:00:09 -0800
Message-Id: <20230228230009.89787-1-brennanlamoreaux@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <Y/yrHe4OIYcWFbNO@linutronix.de>
References: <Y/yrHe4OIYcWFbNO@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I just posted a fix for a workqueue related deadlock in put_unbound_pool in the 4.19-rt kernel here:
https://lore.kernel.org/linux-rt-users/20230228224938.88035-1-brennanlamoreaux@gmail.com

Can you give this a shot and see if it fixes your problem?
