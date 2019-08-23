Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B40C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068CA206E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoWDPkRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfHWPR0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:17:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39187 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfHWPR0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 11:17:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so8980746wra.6
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Aug 2019 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=y4dz/IEtvce18tYgzhB7cfdbzJK5qGVJRH8H/aU2eiI=;
        b=ZoWDPkRqye6zZD4d9RXO4tBQKg26PhL4epvrT0t5e3quPO8sZhO5Rrv1pRluPPVo8T
         wWH0qljAFQmEtNO+EOlP3tPAo/2ZSCf7Pxt8jI57xxk9OevHrZhRcssdYnFUGDCbUgq9
         q9oIYOJojn6Apz3TEF71g9rK7kqlmHjh21cH9YAuQBqe8MvdTdURujV0dZJ9L3MqZMcL
         5Wv0VY+qu6TaNcfEfDZu6jRCMrWUBlUsc5lzZH7DCzN4rAke7tF1o6TezKosn0hxe9k+
         lPO1UThBcUpw5KlIuEMv+orzX4Ifo9JP91VcGj9LwcSvWx4rDA56XBdcPUfdJlQDoYTO
         evQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=y4dz/IEtvce18tYgzhB7cfdbzJK5qGVJRH8H/aU2eiI=;
        b=JuDP9rtjk9zfKbYbZYv7N03wUXV3Qxu+zHIL3gjMCQao9nDLjxlWGnmnGeq8C2LXm0
         24KwWy2lO6BMPYEBZivqdgVMscbFVfRBwULT963GBJT1etc03MYjkj16TNBN2pIeV6FV
         6ER4gGHfeh7AK7OyJq5PUvTeGSEOUTrhJgMmMhhq3a6AW13RxRvDQELduuI2PrrLSDVQ
         yl3zk+rQJa4r28Rdc2DrUj6QyXq0yUBbA7F3i5fO6frbftQVm4zQXPIQ5pejj6kaKjGp
         p8+Cge6gXKeePye4PgerW44yUSH3sYk23pnDVphsuI2v93wPzqAP//fca1K9fRItFi9I
         q2vw==
X-Gm-Message-State: APjAAAX30VI6X/Wr2lcm84sPZSpbm9JtemEVuAqNA4pgknHLL0fL3hu/
        q8Vm55SoNgM65Ii7jjfmSoDDrBd0EdI=
X-Google-Smtp-Source: APXvYqymRYxNdI0Mkvti/voYw3f0Cz/FOwPHJKPptsVkn55VKYoJ/mdvkV7MupDr2Hq4Y85TbFlRGw==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr6144956wrq.236.1566573444005;
        Fri, 23 Aug 2019 08:17:24 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id p69sm4884414wme.36.2019.08.23.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:17:23 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:17:15 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 v1 2/4] sigwaittest: Increase buffer to avoid
 overflow
In-Reply-To: <20190819064304.4676-3-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1908231716540.7154@planxty>
References: <20190819064304.4676-1-wagi@monom.org> <20190819064304.4676-3-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-235855781-1566573436=:7154"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-235855781-1566573436=:7154
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 19 Aug 2019, Daniel Wagner wrote:

> Increase the size of the char buffer. gcc 9.1.1 reports:
> 
> src/sigwaittest/sigwaittest.c:494:5: note: ‘sprintf’ output between 5 and 14 bytes into a destination of size 8
>   494 |     sprintf(f_opt, "-fr%d", i);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> src/sigwaittest/sigwaittest.c:522:24: warning: ‘%d’ directive writing between 1 and 10 bytes into a region of size 5 [-Wformat-overflow=]
>   522 |     sprintf(f_opt, "-fs%d", i);
>       |                        ^~
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/sigwaittest/sigwaittest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 59f28a5babcb..2d0c04132fa7 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -352,7 +352,7 @@ int main(int argc, char *argv[])
>  	struct params *sender = NULL;
>  	sigset_t sigset;
>  	void *param = NULL;
> -	char f_opt[8];
> +	char f_opt[14];
>  	struct timespec launchdelay, maindelay;
>  
>  	process_options(argc, argv);
> -- 
> 2.21.0
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-235855781-1566573436=:7154--
