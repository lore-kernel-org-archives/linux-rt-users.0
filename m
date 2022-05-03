Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DACFC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 May 2022 10:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiECKar (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbiECKam (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 May 2022 06:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8886F15737
        for <linux-rt-users@vger.kernel.org>; Tue,  3 May 2022 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651573627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NB3IZtLnnCngJmQwIY9BapslLGgjY8QXV/w9Chpg2AE=;
        b=T2n6+aF62wYhOQyXB4kgdNW9EEqXe0HSlHH/bE7+BL0x5stdvpzpnRJUvlYkTV4lIei3Hw
        iotPUqVE8ftPkXycue/N2zxy78EmneEXNdThGJA9Nu3cn9N3+19C2r8ayWy3MNW6CzxVbd
        +OI6AFdz/85+OQ36O9FulyLcG7r+9+8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-qB6yLsa6MWONK1bH3h33Wg-1; Tue, 03 May 2022 06:27:04 -0400
X-MC-Unique: qB6yLsa6MWONK1bH3h33Wg-1
Received: by mail-wr1-f69.google.com with SMTP id g7-20020adfbc87000000b0020ac76d254bso6196542wrh.6
        for <linux-rt-users@vger.kernel.org>; Tue, 03 May 2022 03:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NB3IZtLnnCngJmQwIY9BapslLGgjY8QXV/w9Chpg2AE=;
        b=CD03ygg0YS4CfzoMWIPFvu1Da8eIsG5xlWGjDiajAlvlX36PVn0oPBh0UxEUbinb83
         uYElnWe4zV4C/kQKhHhGkUeFKWN5dyNmI78VkWYTbvIrnDY3JbSSC+BvVtq+qtlQLmHf
         eNF5uZx73snPYlpM4G+cpJtoXFxFjIDf/uFVqItC3Jm2PaBjIznliMAjUbDdmvyQoI6v
         W2ZknXfUC3BDuPeK4XhFouJJj5BmpskVUsGuiKxFbZ/0ATZvpHcbPOEU+AjRII4F0Odg
         eTK1lUrRX3tFViBUXZQbRGj7bFztYSXm7xUyNQHGaWRW7wvoKXiviiLU9OJVcdoZIg/Y
         KKkQ==
X-Gm-Message-State: AOAM532PiBLR3E3cj5hFPEb585eZynnXk3/KYx4B3JkCGMYxK1iMNfJU
        mGzyz39i2ZTae9wgNInb8W9MSddI09FaY6nREMGwUR3ulmFcvWVZZ4v9gqCqFYTyU7l6/a0jr5A
        Sl0nueNRFrtfCR/1m+DGkVuhZpN4=
X-Received: by 2002:a5d:64e7:0:b0:20c:5b42:a93c with SMTP id g7-20020a5d64e7000000b0020c5b42a93cmr8811103wri.619.1651573622547;
        Tue, 03 May 2022 03:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd/h11Y4h9KnXZ0TY+dZGA50CkOBxvI7L+iAx3HCUXsfDbafe8pKn20EAaXysgpV9r+CwAKA==
X-Received: by 2002:a5d:64e7:0:b0:20c:5b42:a93c with SMTP id g7-20020a5d64e7000000b0020c5b42a93cmr8811089wri.619.1651573622333;
        Tue, 03 May 2022 03:27:02 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id c10-20020adfa30a000000b0020c5253d8f4sm8929678wrb.64.2022.05.03.03.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:27:01 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rteval: kcompile: Tweak default source tarball selection
In-Reply-To: <bea14b39-5875-e180-a714-bc6ed7bf465@redhat.com>
References: <20220419162142.91470-1-vschneid@redhat.com>
 <bea14b39-5875-e180-a714-bc6ed7bf465@redhat.com>
Date:   Tue, 03 May 2022 11:27:01 +0100
Message-ID: <xhsmhmtfyvrm2.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 02/05/22 11:17, John Kacur wrote:
> On Tue, 19 Apr 2022, Valentin Schneider wrote:
>
>> Kcompile._WorkloadSetup() looks for a "tarball" and "tarfile" entry in
>> the CfgSection, but I couldn't find a single setter for thoses. The
>> only way for a user to specify a file is via --kcompile-source, which
>> doesn't seem to be actually used by the module.
>>
>> As it stands, this method will look for a tarball matching the
>> hardcoded kernel_prefix.
>>
>> Make Kcompile
>> - actually use --kcompile-source
>> - use the latest tarball in the loadsource if no source is specified.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>> I'm not entirely sure about that one, I tried to dig up the git
>> history for uses of those "tarball" and "tarfile" options but didn't
>> really get anywhere, so maybe I'm completely wrong...
>> ---
>>  rteval/modules/loads/kcompile.py | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>

> I think we wanted to make sure we were doing an apples to apples
> comparison, so we restricted the default kernel to the the one we supply
> in rteval-loads. I am thinking of changing this in the future to using the
> one supplied by the distribution, but still mulling this over.
>
> However, --kcompile-source should work as advertised. Do you think you
> could resend a patch with just the part to make --kcompile-source work
> correctly?
>

Sure thing, will do.

> Thanks
>
> John

