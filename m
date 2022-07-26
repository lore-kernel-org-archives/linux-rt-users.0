Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0159FC00140
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 15:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiGZP7j (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiGZP7i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 11:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF2902C12F
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658851177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjFrnGpQnWXOrO8dfZazbJiud2jKEznVsAHrkiDJpGA=;
        b=YTdQhir4/stWz76J5lo/zTjLStXmZ99O1OUuQKmUlZscSrAFtXpTUzsTDfhKCdBBR9+TSn
        cdx+/GGsRaWrfat8OUTFA4jgD6EgeQ64dYtLv1/kyJhps3OKYlDtD+p4QZFmEX/BJONkVq
        aMZ6yBQ6c9rE+PMK01V4K1JFR/6TpEE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-_6KYq6EPP-6OATL5BJr0EA-1; Tue, 26 Jul 2022 11:59:35 -0400
X-MC-Unique: _6KYq6EPP-6OATL5BJr0EA-1
Received: by mail-il1-f198.google.com with SMTP id d12-20020a056e02214c00b002dd143bee38so9277565ilv.7
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 08:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=WjFrnGpQnWXOrO8dfZazbJiud2jKEznVsAHrkiDJpGA=;
        b=HuMmpORM1Ya5QSKQnxt0B0QJcwl1O4GdcnlyKc1ehyUShHFH/Xth64n0QNHtJamFhZ
         Wew/lBq1jDT9UzJ7Lu65lbzBiRVXgIFVzfnAzmQJSA3iehHokLdO6DhD8YPlvRs/wLrY
         XYSDS0rtnBxw0jW45OBjwg3ssBQ6H53lXf2Wt5oFz+8k7PBIOfHyqOSrL1FZKWtJhVT4
         AByGUhLZ/tsrElTfgBUFAR/AXF1RY4nsbn1KuaUqecdpBa0SomBgB59iqo7BRJDJHcwC
         Kbo+LuYYn8IaG5yOWv6d8QFIMh6rYsQVZ7Ta5SErkCJdqPlrdnFqk10F/0pnnyN7b7Ux
         NHXQ==
X-Gm-Message-State: AJIora9Ui1uvkXk5saysX0giMBTmErZSy2/Z5p3lwW3UBrD86HkrdH9L
        2CWHUK1cBFSDAgXx11ezZOGH0QTYPOno2W6G6o9AjSgOkB6C1f2pCLuTkN2oAa2XNvfhFgJQX7f
        qup7uc45/Fdvzw1WchS1OI31NeaQ=
X-Received: by 2002:a05:6638:2105:b0:33f:6b09:948d with SMTP id n5-20020a056638210500b0033f6b09948dmr7160234jaj.169.1658851174416;
        Tue, 26 Jul 2022 08:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1smheTzNrCiQrAgX1jjPoIPB9qnb1XcbOgiSepe0by0GNfGZ0Dc7Acr07mYHTIqq8QvpuxSDQ==
X-Received: by 2002:a05:6638:2105:b0:33f:6b09:948d with SMTP id n5-20020a056638210500b0033f6b09948dmr7160222jaj.169.1658851174135;
        Tue, 26 Jul 2022 08:59:34 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id l1-20020a056e020e4100b002db4e72ead5sm5841550ilk.50.2022.07.26.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:59:33 -0700 (PDT)
Date:   Tue, 26 Jul 2022 11:59:09 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Manasi Godse <magodse@redhat.com>
cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com
Subject: Re: [PATCH] rteval: Add man page entry for -S, --source-download
 option
In-Reply-To: <20220726155135.787696-1-magodse@redhat.com>
Message-ID: <5f59d1a1-f14f-58e6-8a24-fdac2254752a@redhat.com>
References: <20220726155135.787696-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 26 Jul 2022, Manasi Godse wrote:

> Update the man page for rteval kernel download option
> 
> Signed-off-by: Manasi Godse <magodse@redhat.com>
> ---
>  doc/rteval.8 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/rteval.8 b/doc/rteval.8
> index 25dcfcc298e7..a8129f18a9f5 100644
> --- a/doc/rteval.8
> +++ b/doc/rteval.8
> @@ -108,6 +108,10 @@ Log the output of the loads in the report directory
>  .TP
>  .B \-O, \-\-onlyload
>  Only run the loads (don't run measurement threads)
> +.TP
> +.B \-S KERNEL_VERSION, \-\-source\-download=KERNEL_VERSION
> +download a source kernel from kernel.org and exit
> +
>  
>  .SH MODULE OPTIONS
>  These are options that affect the execution behavior of the measurement and load modules.
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

