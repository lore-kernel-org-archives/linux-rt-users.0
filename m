Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D5FEB64DA
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Jul 2023 08:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjGVIFc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 Jul 2023 04:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGVIFa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 Jul 2023 04:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF63273F
        for <linux-rt-users@vger.kernel.org>; Sat, 22 Jul 2023 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690013083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbSZkv9qcwLx6TkEBQeR4Wnol8rh9QTnB0QIfSJxe8A=;
        b=I/TVtsFCJ2V9d0sADVBXuVTqNHPjMAecG2iL7WcQXn+tkJPDfuUc1/IRd+TyxOkf56a2k5
        zHAVJRnCF+wINbVJoqVRxEc3GqrXbm94oiT+A022G6L1jVLUV9RXm79lk3kxZg5gaUTpHv
        zAlcAqxYF5tod/fuRJrGJj8myuyVkcg=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-tscsM1RePFmCmg1SWZQgWw-1; Sat, 22 Jul 2023 04:04:41 -0400
X-MC-Unique: tscsM1RePFmCmg1SWZQgWw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1ba51d4e577so4767977fac.3
        for <linux-rt-users@vger.kernel.org>; Sat, 22 Jul 2023 01:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690013081; x=1690617881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbSZkv9qcwLx6TkEBQeR4Wnol8rh9QTnB0QIfSJxe8A=;
        b=dsXnqz6QziE3BSOCnZC2TuobbU/NO69fzk/J7xXDn8OO0pUMGbP0f3XQlRIik2XAGk
         rD2qiCYa/2cmBeee84GLV3HNROiSSFaOYgZXmrAbFpgG4mR088PvMPeRLvxMDJ3SsTYh
         A0wtjLI3S6LeEugeXkgwzjk5sEVA4xXRXkTO3rOhAlkrm5t5LmBKMkrNRWzy8/GQub9Y
         3135AHNvfv+yaONQByVeUcGXTzBusnIaJ4oubxH1npzJrvMCkrfZh7Q3edQQTfXqQHrk
         mXaPjadm8Ui1oEJtxf/0n8ISMmcpK3zf8OYa1+PCez3owkAViTS1LUJj9Mw3vQlsg1YN
         K8oQ==
X-Gm-Message-State: ABy/qLY65LtG/765i6ONhW014qCAbgcPWC56Bm5b3R2EGp3vRpD+cxWO
        Ja+tNTtxqirc4UZnBh3nFjv5SBscTex7HhAnMfJWk3BRu2uOyFyYRCpTuBJoEBonIbJLWWQqvNy
        Nu019PB1/MIHibESMCWJawmLXUj9wo5pWIL84YUwTVuo=
X-Received: by 2002:a05:6870:f69e:b0:1b0:43b6:e13b with SMTP id el30-20020a056870f69e00b001b043b6e13bmr5415912oab.54.1690013080956;
        Sat, 22 Jul 2023 01:04:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTHBxJ83OPWYjyyNOUC3XHdVgTNzaset85zkOMNxYBC17Xoo0VXVQRCj/sg/zGs6W4odjxmgoFJn4fb7835PI=
X-Received: by 2002:a05:6870:f69e:b0:1b0:43b6:e13b with SMTP id
 el30-20020a056870f69e00b001b043b6e13bmr5415901oab.54.1690013080765; Sat, 22
 Jul 2023 01:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230716193000.231406-1-costa.shul@redhat.com> <9b212c49-ab51-0cd9-5871-c145c5f41b48@kernel.org>
In-Reply-To: <9b212c49-ab51-0cd9-5871-c145c5f41b48@kernel.org>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Sat, 22 Jul 2023 11:04:29 +0300
Message-ID: <CADDUTFx+tfdkLp=wp-XH-U1iB3ZM90W=ktbR4ckp62pDmUGPMg@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Add latency threshold
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> rtla timerlat has the --aa-only that ignores the trace until
> the tracing stops, and then do the auto-analysis based on the
> tail of the trace.

> So, as I said, I am not convinced that adding this interface file is
> better than setting the stop-tracing option... and then waiting for
> the trace to stop... parsing only the tail of the buffer.

I see. Stop-tracing option of rtla timerlat solves the problem for
most of the cases.

Thank you very much!
Costa

