Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE4BC7EE2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jun 2023 18:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbjFLSef (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjFLSe2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2023 14:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C8E1727
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686594755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLXSwrAmK3g25GHnxD0Nyf1gJH/PjJerrXIIPctoIPM=;
        b=aEKctyIZD2ywWgnINfjs1iPHhM1zmZQWvvwUI6MMK/PZWkBMcyzSGBIkigyFJ9S4vLv0P+
        Bgd3twgQU4Wmu+CicImkfOV/2WieBVtKkAKz6cqJvE8GB7amlxmimGUwW/dM5QwAQb9bXf
        1LBHrWVa+AwT4hTLTwwW3Uw60eeAK9Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Okkxu6T-M16XEVlSGqAgyg-1; Mon, 12 Jun 2023 14:32:31 -0400
X-MC-Unique: Okkxu6T-M16XEVlSGqAgyg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62de0c6e67bso2086886d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594751; x=1689186751;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLXSwrAmK3g25GHnxD0Nyf1gJH/PjJerrXIIPctoIPM=;
        b=NBiUg8T5mBGR8E094Rbb1IXYR/YbZ8Iic5517kyWGjwxlekeFPEAkN7o66IqDJsNR7
         ceaSsRV59PtYXbkCmQoh97/i3cbRF2UbOA1GzEMJ6m8mOLOMo5kRYWe35GtL/TDTmem5
         76RUtiRjfe39Efg3dUj/BVxuJUZ8lsk23JKkwmjvpK031hibOfvyPfLzXgXajfukxN3z
         1rtURTale2kUrKoqRsldYEc9Kj9q2/O7kCPFva9ZxtNTctNoWZlhws/dF+cnr/d5aH8e
         uHmQDe0JXUIXDLj443cPk5E9vn8b8h2uYyJikeS9e9ktxPF9E+5IW/itNJrP2UFGKjw9
         4ZwQ==
X-Gm-Message-State: AC+VfDyfEqedoJJRYrAaL88PdLyDkvoTobIH2hZ+auhRwJ3VxmLamQVO
        CqN10uYsD49z0lSvmkJCoYKBWnoyPjLdhO1O3GWlk8QwCidUFp3AJ694fHrmB8cPyy48TfZgOOh
        MM4VPKe8knsx5JFSNIQyjmy0KS4y0JHs0XiA=
X-Received: by 2002:a05:6214:29e6:b0:623:66ee:79b2 with SMTP id jv6-20020a05621429e600b0062366ee79b2mr11404342qvb.36.1686594750949;
        Mon, 12 Jun 2023 11:32:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6p0FwWiHBIXEV3Ztr7tsKU8CAjRN+fLPRipqzxBlJt/UMjNHllxBk4Ee2N2ag9TOGTJkuTPg==
X-Received: by 2002:a05:6214:29e6:b0:623:66ee:79b2 with SMTP id jv6-20020a05621429e600b0062366ee79b2mr11404329qvb.36.1686594750692;
        Mon, 12 Jun 2023 11:32:30 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cf049000000b0062618962ec0sm297272qvl.133.2023.06.12.11.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:32:30 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:32:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 03/10] rteval: Use f-strings in cputopology
In-Reply-To: <20230601202734.813515-4-ashelat@redhat.com>
Message-ID: <9c403da9-bb3-b930-8222-ed3cfe6adf8e@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-4-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Use f-strings in cputopology
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/sysinfo/cputopology.py | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/rteval/sysinfo/cputopology.py b/rteval/sysinfo/cputopology.py
> index ced7e1f295b7..2bb632312320 100644
> --- a/rteval/sysinfo/cputopology.py
> +++ b/rteval/sysinfo/cputopology.py
> @@ -124,9 +124,7 @@ def unit_test(rootdir):
>          x.saveFormatFileEnc('-', 'UTF-8', 1)
>  
>          print(" ---- getCPUcores() / getCPUscokets() ---- ")
> -        print("CPU cores: %i (online: %i) - CPU sockets: %i" % (cputop.cpu_getCores(False),
> -                                                                cputop.cpu_getCores(True),
> -                                                                cputop.cpu_getSockets()))
> +        print(f"CPU cores: {cputop.cpu_getCores(False)} (online: {cputop.cpu_getCores(True)}) - CPU sockets: {cputop.cpu_getSockets()}")
>          return 0
>      except Exception as e:
>          # import traceback
> -- 
> 2.31.1

Signed-off-by: John Kacur <jkacur@redhat.com>

