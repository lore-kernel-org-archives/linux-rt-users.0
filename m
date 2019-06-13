Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D86BC31E4A
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26424207E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUbL8aen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbfFMPGy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:06:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35901 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732401AbfFMOEy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 10:04:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so10282827wmm.1
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ksJqsJAo0QfBLuMg4bssuqvpLmEHAaYz/uXlef7f390=;
        b=gUbL8aenyGFOAY50t7LzKyPsb5uEbeuX0c5A4axlwhm3+/Z/vVBNy3I8jTTjEEXifT
         HgRCG1V1YEUb2B/MSkd9kvut/OX4+/nC7rv3+IKezzPfI2Euz6O6Wh5Lv9yDVB0fTuNF
         doMrq0IsTNJiTC+wSmwChmwyT1ySD8uCFrrBJgf6WcweU7dA6trzqHHkO0ATic+Iy6OO
         FQUT2F9X/T2STpnL0/4AEC+LJzDBUlea1iUEg1Gz+VnIueNv+mcGD6AGVnuFvJ7cLTbO
         dTDa7MOz2yg6gzPsaxj9RO9x7qLRWn4xKFdt2qA2YfCRBD5lNBlYQiXPSEsG8F42Yo5R
         TcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=ksJqsJAo0QfBLuMg4bssuqvpLmEHAaYz/uXlef7f390=;
        b=PJT3bAQRWjDYT3y5FvLJm18/Mks5V2cIFpj/xrkKrRz9c07Dhv4u8P3e67FfuU6ncK
         S56FuhJzOQlpI2v1uvRGtr+KDZpJbg1pG0giJM7wcWbmdQ0CuLX9xGP0xp9PxTEIBB+e
         EoWq9oIQ2mJ5LPX3p3yDf2T3qgazWlKdM67Ay1H1OP6mVWpg3EmakL/yJGXFsKctm9uJ
         N75HkJKjGciIoFsMFkMzKBBDikcDY4jMuQgvbhXPDXWoZoEF0ciGv0M4G7FpEEVp29Bi
         N5yqyGu0ZESfQ216M/srNHY5MzaiwpLuLzvVsw+3nEJm/R36USFuu9Auv7uaHbRVjpSf
         5v1A==
X-Gm-Message-State: APjAAAUtuwfCJhyFl79Al+HIc4Qqa0WshZEm1CsdPaEgxqfoheW5TaGa
        3Gj6sZO6sB/p9yBENNZ7t1uPRweI5Sw=
X-Google-Smtp-Source: APXvYqxuHNwEHi+V79tjB/UI1fY4nk8SPqNZtOpfPmyovmThve/0M6zj9yJDnQDATOUABzvPd5OxQA==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr3920318wmb.17.1560434692627;
        Thu, 13 Jun 2019 07:04:52 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id l4sm2556571wmh.18.2019.06.13.07.04.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 07:04:52 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:04:44 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 04/12] pi_stress: Allow short command line arguments
In-Reply-To: <20190605160617.22987-5-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906131603230.8187@planxty>
References: <20190605160617.22987-1-wagi@monom.org> <20190605160617.22987-5-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 5 Jun 2019, Daniel Wagner wrote:

> Add optstring to getopt_long() command line parser to support the
> short options as it documented in the man page and also in the usage
> help text.
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/pi_tests/pi_stress.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index ac7646cd2613..543106be8e18 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -1322,9 +1322,8 @@ int process_sched_line(const char *arg)
>  void process_command_line(int argc, char **argv)
>  {
>  	int opt;
> -	while ((opt = getopt_long(argc, argv, "+", options, NULL)) != -1) {
> +	while ((opt = getopt_long(argc, argv, "+ht:vqi:g:rs:pdVum", options, NULL)) != -1) {
>  		switch (opt) {
> -		case '?':
>  		case 'h':
>  			usage();
>  			exit(0);
> -- 
> 2.20.1
> 

I actually don't see short options in the usage help text, but I do see 
them in the manpage.

This could use some clean-up to make sure the manpage is current and the 
usage text is current and synced too, if you or anyone else reading cares 
to address this.

Signed-off-by: John Kacur <jkacur@redhat.com>
