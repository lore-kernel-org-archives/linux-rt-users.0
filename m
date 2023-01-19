Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31827C6379F
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Jan 2023 21:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjASVYi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 16:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjASVWe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Jan 2023 16:22:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59DC4670F
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 13:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674162925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=y8twyfwh84c4dgge2UqdCfG48N/yPn3P76O0d8rOMcg=;
        b=XZgV8o4AKg8ILwAsd4e1N8Hu8Dlarwz3guX8Dubl6v8zYp7G/IQdhKQRDNYpPOUhGbnHG2
        53UCCfvi4DDAPpRxkR+kxh5NyfE6FZR5qpA8jYkk+Kc4ldTXO5xSa2twzeZ4rzLCVJzLZ1
        B0O28pzwZdlhhJ5k4UBsgxzCtWfqycU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-xjvBnkhBNPOotNZUaipo4g-1; Thu, 19 Jan 2023 16:15:24 -0500
X-MC-Unique: xjvBnkhBNPOotNZUaipo4g-1
Received: by mail-qv1-f72.google.com with SMTP id i7-20020a056214020700b004ffce246a2bso1581061qvt.3
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 13:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8twyfwh84c4dgge2UqdCfG48N/yPn3P76O0d8rOMcg=;
        b=prMnCO44/Ctuf0AUBmioeK4vgK1KyzQsmXBQxhEQDD+5zbLztfEEdjTqiICaUM4EhK
         Wvc8yeFLCYs4EBCgyMsiY88wOVk/vlmJsX0y2RlplefOE594bEGaDBuV+KkhkWaxsUKj
         7C1pMfkyy3fxdwcucw07V8netgw34K4AvUWtCkMBlNjOsNZ2Af2/ISyb30Ik6T0zzHcl
         2zJMVDsq2/Ocmm0VM7CdRFYwsiZ/qDLEAQMZgNMvjEHDuiiTeHuHhzGbBVBNKE2vJqfG
         Q1wSNd47asSaifPdeNNWgdlStlvoloJ0TUN21wtpgA/NLoHEEPKFvAlXs7RMerTFMsME
         O4Bg==
X-Gm-Message-State: AFqh2kp4X+6k6qBauLtPw7qs4ea4qCxucWyf016mAMYpzzhcLaOgdmzs
        5dnyZ2rC1T04XYegfJ3WxoOoboVeeNx2NxEFtvAT68D9x1S3+ln2pa6ODvqwayT7lT2Q8Kefu2Y
        9w6cndREu+CgVcJutznDWtxkJbog=
X-Received: by 2002:ac8:6f09:0:b0:3a7:e271:fc05 with SMTP id bs9-20020ac86f09000000b003a7e271fc05mr20033783qtb.3.1674162924087;
        Thu, 19 Jan 2023 13:15:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt5lIz4aB4qsJoQg4L49XLKtqNPp0FBDtcmmb+e3C878DYLR74rp358T2jlf3lHOQTUY+nZ/w==
X-Received: by 2002:ac8:6f09:0:b0:3a7:e271:fc05 with SMTP id bs9-20020ac86f09000000b003a7e271fc05mr20033758qtb.3.1674162923829;
        Thu, 19 Jan 2023 13:15:23 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id t20-20020ac865d4000000b003ab7aee56a0sm3081504qto.39.2023.01.19.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:15:23 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [RFC PATCH RESEND 0/1] fs/namespace: defer free_mount from namespace_unlock
Date:   Thu, 19 Jan 2023 16:14:54 -0500
Message-Id: <20230119211455.498968-1-echanude@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We noticed significant slow down when running containers on an Aarch64 system
with the RT patch set using the following test:
# mkdir -p "rootfs/bin"
# printf "int main(){return 0;}" | gcc  -x c - -static -o rootfs/bin/sh
# crun spec
# perf stat -r 10 --table --null -- crun run test

 Performance counter stats for 'crun run test' (10 runs):

            # Table of individual measurements:
            0.3902 (-0.1941) ##########
            0.5791 (-0.0053) #
            0.5785 (-0.0058) #
            0.5891 (+0.0047) #
            0.6682 (+0.0839) ###
            0.5507 (-0.0337) ##
            0.5888 (+0.0044) #
            0.5797 (-0.0047) #
            0.5977 (+0.0133) #
            0.7217 (+0.1374) ####

            # Final result:
            0.5844 +- 0.0269 seconds time elapsed  ( +-  4.60% )

A 6.2 non-RT kernel results on the same hardware for comparison:

 Performance counter stats for 'crun run test' (10 runs):

            # Table of individual measurements:
            0.1680 (+0.1375) #################
            0.0074 (-0.0231) ###############################################################
            0.0073 (-0.0232) ################################################################
            0.0070 (-0.0235) ####################################################################
            0.0072 (-0.0233) #################################################################
            0.0794 (+0.0489) #############
            0.0078 (-0.0227) ##########################################################
            0.0070 (-0.0235) ###################################################################
            0.0070 (-0.0235) ####################################################################
            0.0068 (-0.0237) ######################################################################

            # Final result:
            0.0305 +- 0.0169 seconds time elapsed  ( +- 55.33% )

It looks like there is one bottleneck in:
-> do_umount 
 -> namespace_unlock
  -> synchronize_rcu_expedited

With the following patch, namespace_unlock will queue up the resources that
needs to be released and defer the operation through call_rcu to return without
waiting for the grace period.

Alexander Larsson (1):
  fs/namespace: defer free_mount from namespace_unlock

 fs/namespace.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

-- 
2.39.0

