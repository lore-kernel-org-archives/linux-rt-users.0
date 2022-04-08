Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA78C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Apr 2022 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiDHNON (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiDHNNx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Apr 2022 09:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AC931BD
        for <linux-rt-users@vger.kernel.org>; Fri,  8 Apr 2022 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649423502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOFlqhY22jYsoq+ob7xKTzQP+SCAy2ygHB8Qj3FLlrk=;
        b=TY69DCGelnui9RUnOXZbE81WDlv3Dzh/MCL/qjoLy96n+yTG9XunANrLqoBvToIB0U0mli
        nwv2IVyveBxQY1OA4ocheswGk2F9C/+s833wTtjk2JhE7n3NMGvWQJdUgNC09ri5lrjVBa
        ztzG1UVZs9ULjbEe6+P6olUGm5a7otQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-RfW6SbzwPl27_kWyY8IhYw-1; Fri, 08 Apr 2022 09:11:41 -0400
X-MC-Unique: RfW6SbzwPl27_kWyY8IhYw-1
Received: by mail-ed1-f71.google.com with SMTP id j39-20020a05640223a700b0041992453601so4623965eda.1
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Apr 2022 06:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oOFlqhY22jYsoq+ob7xKTzQP+SCAy2ygHB8Qj3FLlrk=;
        b=gFWx3V7GiDtiGJE2oTOoGZi0L7PYB2rwmcmLsrRIK/CewOonoiQ2Jt5v6Y7TY8qwlS
         1fCDU1fKLSUuh/rHcti1PxWtBTRDFZihxZM1xh8TBNDZWTrOta0ZJFjtFinGHngzUVDD
         hOFcmceDo0zWuj0qGfFzFjtfbrFtsdkRR15X8gim69bqGOUxORRA7FgpD/kOouj/9Raa
         i6eQUQIF982EgNAg6/6fBAqwspYeFgUm+ZUFu15CGhXqwjEWuzlanCNmsbBxGCE9w7BV
         60q9NCyS7H5qe4IVEhu5sQ8+8Iyp+YzExpj7JXh7j1d+tkq+KxOPmlSGW29shv1T+Fcd
         WNGQ==
X-Gm-Message-State: AOAM531nr1wBY96hOD5EFy2VhVaUrFIQVQVb60k7OrNz26xFKghcImYc
        Gb1DRw7ujWBhkZoiKzJtwNYN4uVt8mpI4HFo0/y3viHqVLjMZMYwdI8cI9XaA2TvL9ABW3wgGVi
        Enm86j6jcq//DjmxlAlH+dqKWfsE=
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr17642066ejc.249.1649423500618;
        Fri, 08 Apr 2022 06:11:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGqWMXtLxjkDiB9O5FvZYY9poEXz7xmy/mjbGXXrp6fd6M5rVBrNzOmCmqPPF0uyeM5Pww/A==
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr17642050ejc.249.1649423500417;
        Fri, 08 Apr 2022 06:11:40 -0700 (PDT)
Received: from [10.0.0.45] (host-95-245-33-130.retail.telecomitalia.it. [95.245.33.130])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm8747089ejd.155.2022.04.08.06.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 06:11:40 -0700 (PDT)
Message-ID: <06ee8466-ffb9-20f5-f66b-3c36e45b1488@redhat.com>
Date:   Fri, 8 Apr 2022 15:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] rtla: Don't overwrite existing directory mode
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220402043939.6962-1-jkacur@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220402043939.6962-1-jkacur@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/2/22 06:39, John Kacur wrote:
> The mode on /usr/bin is often 555 these days,
> but make install on rtla overwrites this with 755
> 
> Fix this by preserving the current directory if it exists.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel

