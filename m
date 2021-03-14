Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE82C433E0
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Mar 2021 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB54364E7C
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Mar 2021 22:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhCNWrm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCNWrO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 14 Mar 2021 18:47:14 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E3C061574
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Mar 2021 15:47:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h7so1149018qtx.3
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Mar 2021 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=JaDpBAqnExCG/vUbbswDL/01w3Fu1dlRqsfpqhfdMF0=;
        b=s/uQUItNKt3BzKt64x5W7EytDplm72Dob0C37r1QryAWdjb+vNyUNznp1MzhgYW6gr
         hkkO5qlEIBGTmjsXgUIfqBZSwA3V68XBJCxZnH+7kaZ6/jwL9b4qKxerciIx/eHkl5m4
         iSamLKrfahb4JdZEnZ/KM34vHirn31hcbA2fDxaemgoo6p8Pxv/igYAwI8g7N0QSyGoq
         g7+tuyI6d3pSrlBCTmeXnm5Dm65e1BX2xaW4KFPHboOAB5WF2cYiFyhCioHTHSuyvNoG
         Z7YOshOzmbL1Rvd7e0teorf2rs3vfBC8+oOaMlTeqiMQ0H8fRFYUt7e76rMF21PMobH8
         m4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=JaDpBAqnExCG/vUbbswDL/01w3Fu1dlRqsfpqhfdMF0=;
        b=VTLsVPYJ79/s53hAK8+Xel0nXyuUIxODnc2cqju/tO8T8dClj1EBXmLyHvSJWf2px8
         g+u88Z6g/tokAvCGuedKQSKJPkyiqQtWS6V3MV9Pms5t9xrLNHIAUjiaPsB/EgbdAlYc
         HsjY3dg8eyDk1AhdhaOFrKs4ItTmcPHhE1w2Fv+Jp6BSp1IivECcen8NXpPBmohgZ2mG
         fMxR18EWhnQi+FMHGvucF+ZNhd/bFxPhXlyepgBefJ9zkXDzkBFRKVEiZFTXYRTwGGQQ
         pdYpagPcFHNXvG9I/BJnEaVz7mgU4d4lG0H6PIqwkufW6vYqRX/NZdHB/rn/zHtyyLn/
         T6Bg==
X-Gm-Message-State: AOAM532kMQeiSkG8Wg8Qrglg9H2+I7qITJKsGEuUElr1hF5ti1ruYtMF
        w1pTIr9YjWdmYTksQAhwgaA=
X-Google-Smtp-Source: ABdhPJwIfz2q+ZdczAKUz8+jziaYPIcJPfOxqR4uSE2Bn9bklsslwyLE/srojJEg3+xylUcmjS3/wQ==
X-Received: by 2002:ac8:4412:: with SMTP id j18mr19008650qtn.387.1615762033460;
        Sun, 14 Mar 2021 15:47:13 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id 79sm11199599qki.37.2021.03.14.15.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:47:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 03/14] signaltest: Add missing --output usage
 info
In-Reply-To: <20210305073500.17926-4-dwagner@suse.de>
Message-ID: <e23a8a86-471-8fdc-65c-c20b0324a4@redhat.com>
References: <20210305073500.17926-1-dwagner@suse.de> <20210305073500.17926-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 5 Mar 2021, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/signaltest/signaltest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index b1a7e1db8302..e2ffc0bb8693 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -189,6 +189,7 @@ static void display_help(int error)
>  		"-h       --help            display usage information\n"
>  		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>  		"-m       --mlockall        lock current and future memory allocations\n"
> +		"         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
>  		"-q       --quiet           print a summary only on exit\n"
>  		"-t NUM   --threads=NUM     number of threads: default=2\n"
> -- 
> 2.30.1
> 
> 
    Added missing commit description
    Signed-off-by: John Kacur <jkacur@redhat.com>

Please don't forget to add a short commit description, even if you feel 
that the title explains everything
