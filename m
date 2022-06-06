Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D2CC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jun 2022 11:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiFFLAC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jun 2022 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiFFLAA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jun 2022 07:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FCDF13E90
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jun 2022 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654513198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgU7+AqmSzAqJfG16N2aRdqo5wT32YyrvESrM2jNUBw=;
        b=CmMBAEjpmz6HQeI6I5YYiS+Cj4iUsMn2WNiVKnFkwEpNIsZ3aNCT5FBbzcKHlbZi71Z6zf
        jnjUSskzoqlhftFkdTuwnuunb9EHZzOCWx2nW4bH4A1kU5n9LqGdMlSHq/cKHu4/x0TOq6
        q8WX6Z9ZRxmhxa8zM8ELwwyJNg54Woo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-s3nGiGKvMpuJi8u674Qmxw-1; Mon, 06 Jun 2022 06:59:57 -0400
X-MC-Unique: s3nGiGKvMpuJi8u674Qmxw-1
Received: by mail-wm1-f72.google.com with SMTP id n18-20020a05600c3b9200b00397335edc7dso11068886wms.7
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jun 2022 03:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mgU7+AqmSzAqJfG16N2aRdqo5wT32YyrvESrM2jNUBw=;
        b=MAr4wTbJp+ZUHtV+XJWrjU+erdmKx9IWVie6m09gu2Lza9+PtqH+LBb27u4OMSxdaf
         2Oy+ICQQz7PmSJVyKt8xSVhPoOUSqRtqs/U1S+3B/SDMapOs/J1CG7DmeFpoSM1KlHuk
         JA/UaeHu6aJ7YwfurbKizjWgI+N7xCaoi+FvXH6HVljMj9gpXCEzcLitgDZIzjPB+yae
         9faN002vRzGIrQlOq4cqPZ+C93U/JEHkj6pItz5JmH9pcCB1/SR0WzXUaBDPqLty5iFA
         VyszKmeuNnZhdAzH17iD9L+XMHItrpGqyC6uYop958Lr5q0qnDK/TtlRiXkwBcccGfZE
         1ziw==
X-Gm-Message-State: AOAM531s9et5ld1nnQ24fvVDo+jJfxhJdZXRALctG5/ZTikWgwC7pS6U
        +NhC88WAT/esD++oQ9zHwAD7o016Z4kLzV8HyNBOJl0gSB/XdHDPLqU5/LB65uH7i7vT6kBKB9Y
        TdZx1Hu9FTRVxowAM9D34tX7yU6c=
X-Received: by 2002:a7b:c842:0:b0:394:8d6c:2768 with SMTP id c2-20020a7bc842000000b003948d6c2768mr22210598wml.205.1654513196338;
        Mon, 06 Jun 2022 03:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsi4B3uoSaSOyrnccyzzosPNc+L1XgJAwfPn8ccMKrh3o3ad+DMl++mgu5MjDMNm6tVV/wtQ==
X-Received: by 2002:a7b:c842:0:b0:394:8d6c:2768 with SMTP id c2-20020a7bc842000000b003948d6c2768mr22210583wml.205.1654513196094;
        Mon, 06 Jun 2022 03:59:56 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id v190-20020a1cacc7000000b003975c7058bfsm17184565wme.12.2022.06.06.03.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:59:55 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 6/7] rteval: kcompile: Fix regular expression to match
 kernel prefix
In-Reply-To: <20220603161224.10947-6-jkacur@redhat.com>
References: <20220603161224.10947-1-jkacur@redhat.com>
 <20220603161224.10947-6-jkacur@redhat.com>
Date:   Mon, 06 Jun 2022 11:59:54 +0100
Message-ID: <xhsmhzgiq6or9.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 03/06/22 12:12, John Kacur wrote:
> @@ -169,7 +169,7 @@ class Kcompile(CommandLineLoad):
>              if not os.path.exists(tarfile):
>                  raise rtevalRuntimeError(self, " tarfile %s does not exist!" % tarfile)
>              self.source = tarfile
> -            kernel_prefix = re.search(r"linux-\d\.\d", self.source).group(0)
> +            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)

Sorry about that one!
That looks OK to me, though why not go for "linux-\d+\.\d+" ?

