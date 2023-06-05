Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0737C7EE24
	for <linux-rt-users@archiver.kernel.org>; Mon,  5 Jun 2023 19:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFET3d (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjFET3c (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Jun 2023 15:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633FED
        for <linux-rt-users@vger.kernel.org>; Mon,  5 Jun 2023 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685993332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxiUF1n+gp+8iY9FiqTjU4B6cPF/6pmNYP0y3Nffhk4=;
        b=gl7velEN/SKvwglhmDRP4+EKU+7w7qVRIHa9AGSLEH+sreZIMNQrKz1voO3ZspPqG9P32V
        wJzfNP43vq088/z65pSRoY/i9ujGDoOZr7oLpqUS0PRR5IDKVuJF5D494+k2efIsdYD9D2
        3epj+UP86OtIbvOn/yY8CW4sOciFaP0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-LR-cA6WaOcGAsw-8IGxoCw-1; Mon, 05 Jun 2023 15:28:50 -0400
X-MC-Unique: LR-cA6WaOcGAsw-8IGxoCw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62b3d4accd8so24702366d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Jun 2023 12:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685993330; x=1688585330;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxiUF1n+gp+8iY9FiqTjU4B6cPF/6pmNYP0y3Nffhk4=;
        b=kE0tjvSk+EN00PqC2eG+ZOGqHXu72RHAfOtHzSd07+yiMU04oK9rHw8wtt1zWwb64M
         W5JhluoLiLFkw7ZT79b5r14OC6zxcVIWNMIpe5dCtItDi3Td8oLrqdzPSZTZtZIa/WFW
         AFzW/MNb4pO9ekJyO0wv1/iICzlHR16YUWEcChtTlt97saM4DGol8tygGrC+feLhO8Zh
         z6HYmMBV+gt4gYFmkkRB/os4mYQ0b07/hPox1fotI7wsz3Jg+404zsIoqae0MO+7/d7X
         aiJ5mu3Q2+VvrvYsa19HlA5TjEyzuyLtxDwI7hjOYAa4l1ClhbBy+LeP6m3suC8i9R4t
         5nBQ==
X-Gm-Message-State: AC+VfDyHvE2N73YivIo6/t2s5+VZkOL+RA90yLDwwBdy5PDepJw6qhSa
        q4TeuAULyeNM2u3sgQmbtAbFYHLSqVAIS6usV73lPgSzKjvfvDljbn2PEJtXXQe2AyHHWpaILdS
        2FRo/urrlBq2PJibCnWa4X36HEwQFXjjQsv0=
X-Received: by 2002:a05:6214:d6d:b0:5e0:7ecb:8ffa with SMTP id 13-20020a0562140d6d00b005e07ecb8ffamr10679775qvs.1.1685993330323;
        Mon, 05 Jun 2023 12:28:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gdVu73nQmhYBV62k7/S9ozuVJfSmfY7YK22AsmoMNyoQMyglwT8rMudLt4Q4IW8dVxwEUkA==
X-Received: by 2002:a05:6214:d6d:b0:5e0:7ecb:8ffa with SMTP id 13-20020a0562140d6d00b005e07ecb8ffamr10679762qvs.1.1685993330059;
        Mon, 05 Jun 2023 12:28:50 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id m1-20020a0ce8c1000000b0062381fa97c5sm4832660qvo.92.2023.06.05.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:28:49 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:28:08 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 01/10] rteval: Use f-strings in rtevalclient.py
In-Reply-To: <20230601202734.813515-2-ashelat@redhat.com>
Message-ID: <c2c2607d-4e61-8f3b-90b4-9692e9624f8@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-2-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Use f-strings in rtevalclient.py
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/rtevalclient.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/rtevalclient.py b/rteval/rtevalclient.py
> index 26c953005326..7ff7d2700cfc 100644
> --- a/rteval/rtevalclient.py
> +++ b/rteval/rtevalclient.py
> @@ -61,7 +61,7 @@ class rtevalclient:
>          cmpr = compr.compress(fbuf.getvalue())
>          data = base64.b64encode(cmpr + compr.flush())
>          ret = self.srv.SendReport(self.hostname, data)
> -        print("rtevalclient::SendReport() - Sent %i bytes (XML document length: %i bytes, compression ratio: %.02f%%)" % (len(data), doclen, (1-(float(len(data)) / float(doclen)))*100 ))
> +        print(f"rtevalclient::SendReport() - Sent {len(data)} bytes (XML document length: {doclen} bytes, compression ratio: {(1-(float(len(data)) / float(doclen)))*100}:.2f)")
>          return ret
>  
>      def SendDataAsFile(self, fname, data, decompr = False):
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

