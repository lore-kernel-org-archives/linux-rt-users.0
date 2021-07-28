Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D0BC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 21:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4358B60F12
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 21:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhG1ViL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 17:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhG1ViL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 17:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627508288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dw/PjKYTHyOXkOIzJqt0/KXFrtk3L61i3/Mx8m0zQog=;
        b=WFgmUCCpylrWfTUDVLVRDWXkETMYmOsWz2LfGGF3qrm8W/uKR4vwrNsoWJeHXl6e2gTN7N
        O704K5scdpcqElONCNYR+WJKFyEpH9BzpQI0hIAiY5zs8OSj2l/OXY93iXpmLwldpGlChP
        yXsgFhn0u0BfcyvhJCV76blfK5sX8Y8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-sAIJ6Go-OMODj59Ya0mG2Q-1; Wed, 28 Jul 2021 17:38:07 -0400
X-MC-Unique: sAIJ6Go-OMODj59Ya0mG2Q-1
Received: by mail-qt1-f198.google.com with SMTP id q10-20020a05622a04cab0290267bc0213a9so1762663qtx.0
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jul 2021 14:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Dw/PjKYTHyOXkOIzJqt0/KXFrtk3L61i3/Mx8m0zQog=;
        b=sedpTTLaf8BBEveXd2XnqmKvkJw8pj2rxZeyYQTj6zT644WrucYnw3BSns1Zc5ZgWQ
         K3NI98LnX0gfK6lv75TaRmCu9IKz9bGl2gXe6d4gxenfuO194bFNDBs0PHeAgJnoRtVa
         6Cl0KMXSRC7aPD3xo3wVzZHlLcjhW73cGhWy27pA4HJlZhtPcfyddtXtof+DJZLFjvrn
         5BNfANbWBTs+Q4Uoznmj3EDGCLjS8xFpMrOMfCRhEI5AxxpO7IBG3e284+HldcrAQvg0
         OinnZaP9RP5ZY44yrmSL2d7TJ6oo8gzkngA7ufsnb0+Xx7EuRXjHSn08YCWGnq3NQc6/
         XCxA==
X-Gm-Message-State: AOAM532barMBu6luBqvBywFmfp2Dza/k8A2Wshncbe4lPi3gz/FBAKhu
        QE+3PYrJO2xQB6KR3aGqpRxpXQ/WUJo0oOHq4xYTFMqLcI9nxsH5D1XBcNC8LsN6tEKWlhPWQz6
        hnpHNZ89wfChYP0Ezn0HFr4giG2I=
X-Received: by 2002:ac8:75d4:: with SMTP id z20mr1533171qtq.360.1627508286847;
        Wed, 28 Jul 2021 14:38:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqa9S9+8Y6CLkuyDHIIqx/E3M0touoB6WID/HnwCnC79br2E4YaaqnwsHZou+d32vmsDyz/Q==
X-Received: by 2002:ac8:75d4:: with SMTP id z20mr1533165qtq.360.1627508286717;
        Wed, 28 Jul 2021 14:38:06 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id h16sm450657qtx.23.2021.07.28.14.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 14:38:06 -0700 (PDT)
Date:   Wed, 28 Jul 2021 17:38:05 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [rteval PATCH] rteval: stressng.py: Fix argument passing to
 Popen
In-Reply-To: <20210728.201927.2141210326291227293.atsushi.nemoto@sord.co.jp>
Message-ID: <1643d3d2-250-5a9d-731f-fecf8f2f2b17@redhat.com>
References: <20210728.201927.2141210326291227293.atsushi.nemoto@sord.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 28 Jul 2021, Atsushi Nemoto wrote:

> The self.args is a list of strings which may contains spaces.
> Use shell style and pass self.args as a joined string.
> 
> Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
> ---
>  rteval/modules/loads/stressng.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
> index 926de38..927bee5 100644
> --- a/rteval/modules/loads/stressng.py
> +++ b/rteval/modules/loads/stressng.py
> @@ -84,7 +84,7 @@ class Stressng(CommandLineLoad):
>  
>          self._log(Log.DEBUG, "starting with %s" % " ".join(self.args))
>          try:
> -            self.process = subprocess.Popen(self.args,
> +            self.process = subprocess.Popen(" ".join(self.args), shell=True,
>                                              stdout=self.__out,
>                                              stderr=self.__err,
>                                              stdin=self.__in)
> -- 
> 2.11.0
> 

I don't see the need to do this here and in fact there are some security 
implications to using shell=True. Is there a reason you want to do this?

John

