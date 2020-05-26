Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5DBC433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 20:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE0820899
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 20:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPeEyqOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391067AbgEZUTi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390072AbgEZUTh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 16:19:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D7C03E96D
        for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2020 13:19:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l26so897430wme.3
        for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2020 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=207p+O3z4/vNMiHn3dN+duJP8DRqoyKRCJOqI9HyC6o=;
        b=nPeEyqOT7ixcDagCFomGb4T6ecHPX8U6mvc8Gx4uwH4Agfhk85GOPg0Q6yv6rE8jQo
         j+ryMkzVWb+M0Jqb1wcqDXobpZ6TqN8Hp23V95qn51q+rB+x6w5ohFIjI+m+Zc1nm7aI
         YIyGpp0c8+LT/lw1HWP26ZX6zZoFWaiwA6ury5zT8E1L6ksY384qyf9bcbQFXI26vAS8
         7Vne9nsIELavj16vBTjlleIAuXaskaMRsqZcNJeQzWf+yP16tEgLJnqmqZJXyjmedsoc
         FwU8cvj/wMmJBKlFiTHeaI9nxVBwtV9ypMr+9zKsgZsv67puVcXPl+HyWJSB7o+sqK5X
         ftcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=207p+O3z4/vNMiHn3dN+duJP8DRqoyKRCJOqI9HyC6o=;
        b=lJlzvhTxNEVVMg4tIq7wBa/AXN1ruCsKr8z5lQWklwsMIjLwa4PToUuT1QLkcdqTrQ
         aG7IahP/Yq8+GFxvuXJ8HvZXYsRFBiTc+ZZzPbbGYZygQoGM2Gh6kNZ6un+gZsMta4pO
         mZjFf2+LlOBSorVs0a4UqpzHWqsyKQTQufByDLzXr8L3XpsOS3XbCNm7QMlc7Yc7Vfnz
         n4J2pAqFUvp/hgCBDHFQh0GULJtNdEr+6HdmOVFO1p+c2RvNU5yWm7VlpXjD6S0R9qC8
         lLb6Wm5Iayygr+CmJoRKSbKEi3qfLmpPSDz8cD6fokTowmmadmUCFIXwF21lB+O1RLY3
         pfMg==
X-Gm-Message-State: AOAM531m2sZyUlQ00mvTot5UB9eYLBqni/I4+m1jIAGN703e+tyr2v9Q
        W3Yz9QHXwN51a65bP1Bcl/IT4zJK
X-Google-Smtp-Source: ABdhPJy8NP2RNbUDlNcpAyySZcN2zgBJis/35wFljgCyeLd0AceDnhuifSRe7oupMTRPcsncRuaigQ==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr821020wma.59.1590524375894;
        Tue, 26 May 2020 13:19:35 -0700 (PDT)
Received: from [192.168.0.2] (p5de561c1.dip0.t-ipconnect.de. [93.229.97.193])
        by smtp.gmail.com with ESMTPSA id c25sm529946wmb.44.2020.05.26.13.19.35
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 13:19:35 -0700 (PDT)
To:     linux-rt-users@vger.kernel.org
From:   =?UTF-8?Q?Reiner_Pr=c3=b6ls?= <reiner.proels@gmail.com>
Subject: RT Ptach and EFI
Message-ID: <1ed327d1-6c33-9531-6416-32e2934e15bc@gmail.com>
Date:   Tue, 26 May 2020 22:19:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I tried the last RT patch against a 5.6.10 kernel.

After enabeling the FULL preemption model I'am no longer possible to use 
efibootmgr.

The kernel module efivarfs refuses to load - no device ...


Any idea

Reiner
