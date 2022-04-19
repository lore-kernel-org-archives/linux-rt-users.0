Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA470C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Apr 2022 16:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354481AbiDSQRn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354480AbiDSQRm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Apr 2022 12:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09E94B7F9
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650384897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ImivU+eZ1kkDq7YpAynPu/aAkgTsWjXOOVMzcFqbs2s=;
        b=AfacohsM/aFatFA6Rr+KF6lBz4CAVQoiHnBauhYFLmuu1TrgRMBq31kuunkqdfJWo7fe1D
        h0qNEzefnTrVjW8gkYk3a53A2FN2989NrkaAnoksjOtBzG+OvK+4+uNT/QLP48zzAwpPYO
        hV0pD9I8TmLU/EZ5esUxDqvWVR8fEOw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-XiDYe2oPNR2_YoHsT-jsng-1; Tue, 19 Apr 2022 12:14:56 -0400
X-MC-Unique: XiDYe2oPNR2_YoHsT-jsng-1
Received: by mail-wr1-f70.google.com with SMTP id e13-20020adf9bcd000000b0020aa78ef365so447099wrc.13
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImivU+eZ1kkDq7YpAynPu/aAkgTsWjXOOVMzcFqbs2s=;
        b=hzc/lyCTWw96DFSQr3oQ8QPWfddYkzlC2ypN+OIXjt+/ppmJnltQgtTUx9ieNTug1a
         YK4aqtnrz+4czAeOi0UEa7PFALP5nkuZpPRd1yZfG9mJBOHyABLD1L5soP47GpZPT56I
         VR065CMxliXbS+ctRLsmeadGBmdgvhIYgf9spGdisPazrQKfv+uvT4Vm1A5Tcml3ibhD
         wEymVwyE+tRAXuQNOIqJLHfLYVV2BDb2WdZda6vrbPTICJnJ4XgWUQDssHXEYagZTIgB
         nkJsxoZn3MpcPrF7K16voNJWAa9MFKJvzGu3y77VtgRfh6hoL/0WFHbGOGuJSYtNm+rX
         v1UA==
X-Gm-Message-State: AOAM532Fm8H9cLZSAukr5arDMCdMlzldDp++sZb516ZntZIfrcNzY0yb
        SQ5+OzfoFcW8z7as6eYFgXB7ye0ez/x9ZeagbvegNo5OQ2uc1aCFX/g0bf2F8M9hafDeSlA8Rg7
        ztrb6CpECLq/T5pYR83hsDKVBOlDvCKWfRKY9HSwKiFH+5xBoTpXLEmHV8bGBS4JBxa03y9l748
        hg+I4=
X-Received: by 2002:a05:600c:5020:b0:38f:f83b:e773 with SMTP id n32-20020a05600c502000b0038ff83be773mr16515819wmr.57.1650384895442;
        Tue, 19 Apr 2022 09:14:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMOMlBdLONfqcA1X7ZnFuslGu9nOZ5zeY8H+tSSdx1ogIg5WyFmw9lEkC28ZQHfeeDxzkVtA==
X-Received: by 2002:a05:600c:5020:b0:38f:f83b:e773 with SMTP id n32-20020a05600c502000b0038ff83be773mr16515796wmr.57.1650384895188;
        Tue, 19 Apr 2022 09:14:55 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600018ad00b0020a87feadfcsm8682381wri.84.2022.04.19.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:14:54 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 0/3] rteval: Offline NUMA node bugfix
Date:   Tue, 19 Apr 2022 17:14:40 +0100
Message-Id: <20220419161443.89674-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi folks,

I wanted to try out rteval on a NUMA system with one node offlined and
got a few exceptions, here's my take on them. There's also a small
cleanup as an added bonus.

Cheers,
Valentin

Valentin Schneider (3):
  rteval: systopology: Fix offline NUMA node parsing
  rteval: kcompile: Fix offline node handling
  rteval: systopology: Slight CpuList.__expand_cpulist() cleanup

 rteval/modules/loads/kcompile.py |  5 ++++-
 rteval/systopology.py            | 15 +++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

--
2.27.0

