Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FB2C433E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB064E76
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhBJQJT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231645AbhBJQJQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612973270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=guOXexYS9u4o0awA0xpjdlMNG9ohNS8eKBBFeg8i4yE=;
        b=OZqSBdjky4oZynmL3LUylU+Jrlb1Pse95W//uv71FUBelNHDUJ2xp2aVhPEqQbQUyMM5aV
        eL/f/QvzmfqybmukwehBquWrxMZdIbySQqUZ2qIl7nM2W/Lbu6/vn1jmFlT1X/h696CnHT
        LzJ8CpeoCTsdnQiLnlRQ2I4z/6652ao=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-LfQOoliROiOfyAJdvoGvcA-1; Wed, 10 Feb 2021 11:07:48 -0500
X-MC-Unique: LfQOoliROiOfyAJdvoGvcA-1
Received: by mail-qk1-f199.google.com with SMTP id 124so1926276qkg.6
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 08:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=guOXexYS9u4o0awA0xpjdlMNG9ohNS8eKBBFeg8i4yE=;
        b=fVy4V2lHcZ1AOj1jk7404M7ckWbU7r45kjqWiuIjGyycImNf/Uq35MkjmN5Lsmj0jM
         y5ESvuyNP8sBfAzXmlIMcy5yfCIPk/7jxNsKNts+81y140zlmsn78hI2sgzPLCqPYUun
         NhQz+fNj/6rEFPjR01KLAL4b7OB5m2qMFYORmJX4VMnrZHqrtcFB4UHZRPjDY86+yroE
         3R64xk+FBNFtzFPoeogwD1Wcy686ENoPFxuSUlDRg0Cl4OBH4hC0MFCKuO2/MaJOJVAv
         /gH7E8Z3vAudFAaAgpi2OGwafP37i4pJ702tc507FpAevyeVTvbt+ZT8bXQZS+R2PpO0
         FSUA==
X-Gm-Message-State: AOAM5335Ubfym68NLQND2sVzF83PV98ylXxc9PImXF7/9pIl6cApC4Wy
        w5j+XUHC+wVPAVUh0QcwdI6Vs3N41v1IDauICnM51jrbDhPRRTsqRcyIz5diguZrWL7L/G6AcCp
        RaszWsaN8JFsQjMdcs3Wn7hpxJmQ=
X-Received: by 2002:ad4:4047:: with SMTP id r7mr3329119qvp.0.1612973267429;
        Wed, 10 Feb 2021 08:07:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxf22BUQDS9j/U9Xgj/FOGL+5pOgaPV3DraTn578EB8YqI+xIMJyDXGh7i9tDmBR9SoK019YA==
X-Received: by 2002:ad4:4047:: with SMTP id r7mr3329101qvp.0.1612973267185;
        Wed, 10 Feb 2021 08:07:47 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id t6sm1734086qkd.127.2021.02.10.08.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:07:46 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:07:45 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        psahoo@redhat.com
Subject: Re: [rt-tests v1 6/6] oslat: Use parse_cpumask() from rt-numa.h
Message-ID: <20210210160745.GH103365@xz-x1>
References: <20201113210910.21807-1-dwagner@suse.de>
 <20201113210910.21807-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113210910.21807-7-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Nov 13, 2020 at 10:09:10PM +0100, Daniel Wagner wrote:
> Use the common parse_cpumask() helper and use struct bitmask directly
> instead transforming it into a CPU_SET first.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Hi, Daniel,

This seems to have broken oslat with --cpu-list...

xz-x1:rt-tests [master]$ sudo ./oslat -c 1-2
Total runtime:          1 seconds
Thread priority:        default
CPU list:               1-2
CPU for main thread:    0
Workload:               no
Workload mem:           0 (KiB)
Preheat cores:          1

Pre-heat for 1 seconds...
Test starts...
Test completed.

        Core:    1
    CPU Freq:    2114 (Mhz)
    001 (us):    49979990
    002 (us):    471
    003 (us):    53
    004 (us):    9
    005 (us):    16
    006 (us):    14
    007 (us):    4
    008 (us):    4
    009 (us):    1
    010 (us):    1
    011 (us):    0
    012 (us):    0
    013 (us):    2
    014 (us):    59
    015 (us):    11
    016 (us):    173
    017 (us):    12
    018 (us):    25
    019 (us):    112
    020 (us):    10
    021 (us):    66
    022 (us):    7
    023 (us):    13
    024 (us):    16
    025 (us):    7
    026 (us):    18
    027 (us):    13
    028 (us):    7
    029 (us):    3
    030 (us):    3
    031 (us):    0
    032 (us):    5 (including overflows)
     Minimum:    1 (us)
     Average:    1.000 (us)
     Maximum:    82 (us)
     Max-Min:    81 (us)
    Duration:    0.995 (sec)

Reported-by: Pradipta Kumar Sahoo <psahoo@redhat.com>

Thanks,

-- 
Peter Xu

